class LlmHealth < Formula
  include Language::Python::Virtualenv

  desc "Local-first health intelligence CLI and agent plugin scaffold"
  homepage "https://llm-health.net"
  url "https://github.com/nvk/llm-health/releases/download/v0.0.28/llm_health-0.0.28.tar.gz"
  sha256 "effafd6a4ef4359f24271f42959350b9b0ea34d3184bd8180834fccff80454c3"
  license "MIT"

  depends_on "python@3.11"
  depends_on "poppler"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    system venv.root/"bin/python", "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system venv.root/"bin/python", "-m", "pip", "install", ".[v2-core,source-audit]"

    bin.install_symlink libexec/"bin/health"
    bin.install_symlink libexec/"bin/llm-health"
    bin.install_symlink libexec/"bin/health-v2"
  end

  def caveats
    <<~EOS
      Initialize your private llm-health HUB/store with:
        health agreement show
        health config hub-path ~/health --init --accept-risk
        health doctor

      Then import the latest de-identified health-assessment wiki rows with:
        health sync-v2 --wiki-root <health-assessments-topic-root> --profile all

      Archive a privacy-scanned HUB snapshot for future reference with:
        health archive create

      Audit private source reads with:
        health source-vault init
        health source-audit run --focus medium

      Agent plugin templates are available at:
        health plugin-paths

      This Homebrew formula installs the package-first CLI plus v2-core analytics.
      The full live Panel dashboard remains an optional Python extra for dev installs.
    EOS
  end

  test do
    assert_match "llm-health", shell_output("#{bin}/health doctor")
    assert_match "Health Assessment v2", shell_output("#{bin}/health-v2 doctor")
    hub = testpath/"health-hub"
    assert_match "Initialized", shell_output("#{bin}/health config hub-path #{hub} --init --accept-risk")
    assert_path_exists hub/"agreement.json"
    assert_path_exists hub/"manifest.json"
    assert_match "local-service", shell_output("#{bin}/health capabilities")
    assert_match "archive", shell_output("#{bin}/health capabilities")
    assert_match "source-vault-audit", shell_output("#{bin}/health capabilities")
    assert_match "Initialized source vault", shell_output("#{bin}/health source-vault init --store #{hub}")
    archive = shell_output("#{bin}/health archive create --store #{hub}")
    assert_match "skipped: 0", archive
    archive_path = archive[/archive: (.*\.tar\.gz)/, 1]
    assert_path_exists archive_path
    assert_match "status: ok", shell_output("#{bin}/health archive verify --store #{hub} #{archive_path}")
    service_out = shell_output("#{bin}/health service --local --smoke --accept-risk --store #{hub}")
    assert_match "status: smoke-ok", service_out
    note = testpath/"synthetic-note.txt"
    note.write "Patient: Jane Doe\nEmail: jane@example.com\n"
    redacted = shell_output("#{bin}/health deid preview #{note} --accept-risk --store #{hub}")
    assert_match "[PERSON_", redacted
    assert redacted.exclude?("Jane Doe")
    shell_output("#{bin}/health enroll --alias alex --birth-year 1983 --accept-risk --store #{hub}")
    shell_output("#{bin}/health enroll --alias parenta --birth-year 1955 --accept-risk --store #{hub}")
    family_add = "#{bin}/health family add --profile alex --relative parenta"
    family_add += " --relation father --shared-household yes --store #{hub}"
    shell_output(family_add)
    family_condition = "#{bin}/health family condition --profile parenta"
    family_condition += " --condition 'Gilbert syndrome' --status believed --evidence context --store #{hub}"
    shell_output(family_condition)
    family = shell_output("#{bin}/health family risks --profile alex --store #{hub}")
    assert_match "HEREDITARY_RISK", family
    draft = shell_output("#{bin}/health operator draft --profile alex --intent review --store #{hub}")
    assert_match "approval_required: true", draft
    draft_id = draft[/draft_id: (draft_[a-f0-9]+)/, 1]
    finalized = shell_output("#{bin}/health operator finalize --draft-id #{draft_id} --approve --store #{hub}")
    assert_match "finalized:", finalized
    traces = shell_output("#{bin}/health operator traces --profile alex --store #{hub}")
    assert_match "fingerprints:", traces
  end
end
