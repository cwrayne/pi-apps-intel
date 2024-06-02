if which brew &>/dev/null; then
    echo "Homebrew is installed. Installing..."
    brew install --cask chromium
else
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install --cask chromium
fi