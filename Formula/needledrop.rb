class Needledrop < Formula
  desc "Good-looking terminal client for YouTube Music"
  homepage "https://github.com/audiarmadhani/needledrop"
  url "https://github.com/audiarmadhani/needledrop/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f83f6ec6caab733655a065459625f7f85a262d762c68973cfe971885a167ffb6"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/audiarmadhani/needledrop.git", branch: "main"

  depends_on "rust" => :build
  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    s = <<~EOS
      Sign in with the browser where you use YouTube Music:
        needledrop login --browser <chrome|arc|brave|edge|firefox|zen|...>
    EOS
    on_macos do
      s += <<~EOS

        To appear in notch and menu bar apps (Vorssaint, for example) as a
        music player, run this once; upgrades are picked up automatically:
          needledrop install-app
      EOS
    end
    s
  end

  test do
    # A --HEAD build's version is "HEAD-<commit>", so match the shape, not the number.
    assert_match(/^needledrop \d+\.\d+\.\d+/, shell_output("#{bin}/needledrop --version"))
    assert_match "Sign in", shell_output("#{bin}/needledrop login --help")
  end
end
