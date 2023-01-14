# emacs.d

<p>
	<a href="https://github.com/otype/emacs.d/commits/master">
	<img src="https://img.shields.io/github/last-commit/otype/emacs.d.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub last commit">
    <a href="https://github.com/otype/emacs.d/issues">
    <img src="https://img.shields.io/github/issues-raw/otype/emacs.d.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub issues">
    <a href="https://github.com/otype/emacs.d/pulls">
    <img src="https://img.shields.io/github/issues-pr-raw/otype/emacs.d.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub pull requests">
    <a href="https://twitter.com/intent/tweet?text=Try this Emacs configuration:&url=https%3A%2F%2Fgithub.com%2Fotype%2Femacs.d">
    <img src="https://img.shields.io/twitter/url/https/github.com/otype/emacs.d.svg?style=flat-square&logo=twitter" alt="GitHub tweet">
</p>

This is an opinionated emacs.d configuration directory.

<p float="left">
	<img src="/images/emacs.d_dashboard.png" alt="Emacs Dashboard" width="250"/>
	<img src="/images/emacs.d_coding.png" alt="Coding in Rust" width="250"/>
	<img src="/images/emacs.d_helm.png" alt="Using Helm" width="250"/>
</p>

The configuration is mainly based on [use-package](https://jwiegley.github.io/use-package/), [helm](https://emacs-helm.github.io/helm/) (& various addons to Helm), [projectile](https://docs.projectile.mx/projectile/index.html), [flycheck](https://www.flycheck.org/en/latest/) and [smartparens](https://github.com/Fuco1/smartparens). For the looks, it uses [dashboard](https://github.com/emacs-dashboard/emacs-dashboard), [centaur-tabs](https://github.com/ema2159/centaur-tabs), [doom-modeline](https://seagle0128.github.io/doom-modeline/), [kaolin-themes](https://github.com/ogdenwebb/emacs-kaolin-themes) and [all-the-icons](https://github.com/domtronn/all-the-icons.el).

For coding, it provides  [magit](https://magit.vc/), [lsp](https://emacs-lsp.github.io/lsp-mode/) and lots of other wonderful packages I heavily rely on when modifying code in [Java](/elisp/lang-java.el), [Golang](/elisp/lang-go.el), [Haskell](/elisp/lang-haskell.el), [Javascript](/elisp/lang-javascript.el), [Lisp](/elisp/lang-lisp.el), [Ruby](/elisp/lang-ruby.el), [Python](/elisp/lang-python.el), [Rust](/elisp/lang-rust.el), [Vala](/elisp/lang-vala.el), etc.

## Getting started

#### Requirements

- [Emacs](https://www.gnu.org/software/emacs/) v26.x or higher

#### Setup

1. Clone this repo:

```console
$ git clone git@github.com:otype/emacs.d.git ~/.emacs.d
```

2. Start Emacs:

```console
$ emacs
```

This will automatically install all packages on startup.

## Maintainer

Managed by [Hans-Gunther Schmidt](mailto:hans@otype.de). For any feedback or change requests, feel free to drop a line to the maintainer.
