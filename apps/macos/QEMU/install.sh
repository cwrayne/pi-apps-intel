if which brew &>/dev/null; then
    echo "Homebrew is installed."
    brew install qemu
else
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install qemu
fi