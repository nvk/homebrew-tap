class LlmWikiChrome < Formula
  desc "Private local connector for explicitly shared Chrome tabs"
  homepage "https://github.com/nvk/llm-wiki-adapter-browser-execution"
  head "https://github.com/nvk/llm-wiki-adapter-browser-execution.git", branch: "main"

  depends_on "python@3.14"

  def install
    libexec.install ".llm-wiki-adapter.json", "adapter.py", "browser_executor", "extension", "schemas"
    (bin/"llm-wiki-chrome").write <<~SH
      #!/bin/sh
      export LLM_WIKI_CHROME_EXTENSION_DIR="#{opt_libexec}/extension"
      exec "#{Formula["python@3.14"].opt_bin}/python3.14" "#{opt_libexec}/adapter.py" "$@"
    SH
    chmod 0755, bin/"llm-wiki-chrome"
  end

  def caveats
    <<~EOS
      This is a development-only HEAD formula until a release is explicitly approved.

      Register the local Chrome Native Messaging connector once with:
        llm-wiki-chrome install

      Then load the extension shown by:
        llm-wiki-chrome extension-path

      Verify the content-free local installation with:
        llm-wiki-chrome doctor

      No socket argument or background service is required. Chrome starts the
      native host on demand and the CLI discovers its private runtime sockets.
    EOS
  end

  test do
    native_hosts = testpath/"NativeMessagingHosts"
    state = testpath/"state"
    socket_path = testpath/"runtime"/"s"
    ENV["LLM_WIKI_BROWSER_EXECUTOR_STATE_DIR"] = state.to_s

    assert_match '"id": "browser-execution"', shell_output("#{bin}/llm-wiki-chrome describe")
    extension_path = Pathname(shell_output("#{bin}/llm-wiki-chrome extension-path").strip)
    assert_path_exists extension_path/"manifest.json"

    installed = shell_output(
      "#{bin}/llm-wiki-chrome install --native-host-dir #{native_hosts} " \
      "--native-socket #{socket_path} --command-path #{bin}/llm-wiki-chrome",
    )
    assert_match '"installed": true', installed
    assert_match '"healthy": true', shell_output(
      "#{bin}/llm-wiki-chrome doctor --native-host-dir #{native_hosts} --native-socket #{socket_path}",
    )
    assert_match '"uninstalled": true', shell_output(
      "#{bin}/llm-wiki-chrome uninstall --native-host-dir #{native_hosts}",
    )
  end
end
