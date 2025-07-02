# dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications I use in my development environment.
The configurations are managed through symbolic links and can be easily installed using the provided installation script.

> [!IMPORTANT]
> Running this installer will make significant changes to your local configuration. Please proceed with caution.

<br/>

## Requirements

This project requires [`zx`](https://github.com/google/zx) to be installed globally.

You can install it using npm:

```zsh
npm install -g zx
```

<br/>

## Installation

1. Clone the repository into the root directory.

```sh
cd ~ && git clone https://github.com/zudydy/dotfiles.git
```

2. Move to the cloned repository and run the install script.

```sh
cd dotfiles && zx install.mjs
```
