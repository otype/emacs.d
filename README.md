# emacs.d

#### An opinionated Emacs configuration.
<p>
	<a href="https://github.com/otype/emacs.d/commits/master">
	<img src="https://img.shields.io/github/last-commit/otype/emacs.d.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub last commit">
    <a href="https://github.com/otype/emacs.d/issues">
    <img src="https://img.shields.io/github/issues-raw/otype/emacs.d.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub issues">
    <a href="https://github.com/otype/emacs.d/pulls">
    <img src="https://img.shields.io/github/issues-pr-raw/otype/emacs.d.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub pull requests">
	<a href="https://github.com/otype/emacs.d/blob/main/LICENSE">
	<img src="https://img.shields.io/github/license/otype/emacs.d" alt="LICENSE">
</p>

Emacs.d is an opinionated [Emacs](https://www.gnu.org/software/emacs/) configuration that is based on [use-package](https://jwiegley.github.io/use-package/), [helm](https://emacs-helm.github.io/helm/) (& various addons to Helm), [projectile](https://docs.projectile.mx/projectile/index.html), [flycheck](https://www.flycheck.org/en/latest/) and [smartparens](https://github.com/Fuco1/smartparens). For the looks, it uses [dashboard](https://github.com/emacs-dashboard/emacs-dashboard), [centaur-tabs](https://github.com/ema2159/centaur-tabs), [doom-modeline](https://seagle0128.github.io/doom-modeline/), [kaolin-themes](https://github.com/ogdenwebb/emacs-kaolin-themes) and [all-the-icons](https://github.com/domtronn/all-the-icons.el).

For coding, it provides  [magit](https://magit.vc/), [lsp](https://emacs-lsp.github.io/lsp-mode/) and lots of other wonderful packages I heavily rely on. All packages are all listed in the configuration files for [Java](/elisp/lang-java.el), [Golang](/elisp/lang-go.el), [Haskell](/elisp/lang-haskell.el), [Javascript](/elisp/lang-javascript.el), [Lisp](/elisp/lang-lisp.el), [Ruby](/elisp/lang-ruby.el), [Python](/elisp/lang-python.el), [Rust](/elisp/lang-rust.el), [Vala](/elisp/lang-vala.el), etc.

## Preview

Here are some sample screenshots:

<p float="left">
	<img src="/images/emacs.d_dashboard.png" alt="Emacs Dashboard" width="250"/>
	<img src="/images/emacs.d_coding.png" alt="Coding in Rust" width="250"/>
	<img src="/images/emacs.d_helm.png" alt="Using Helm" width="250"/>
</p>

## Getting started

#### Requirements

- [Emacs](https://www.gnu.org/software/emacs/) v26.x or higher
- Font [IBM Plex Mono](https://fonts.google.com/specimen/IBM+Plex+Mono)
- [Ag - The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
- Various Language Servers, e.g. [gopls](https://pkg.go.dev/golang.org/x/tools/gopls) (Golang), [lsp-server](https://github.com/rust-lang/rust-analyzer/tree/master/lib/lsp-server) (Rust), etc.

#### Installation

1. **Clone this repo**. This will go to your `$HOME` directory.

```console
$ git clone https://github.com/otype/emacs.d.git ~/.emacs.d
```

2. **Enable your desired language support configurations.** This happens in [init.el](/init.el).

Please check each language configuration file (see [/elisp/](/elisp/)) for related dependencies.

```console
$ nano -w ~/.emacs.d/init.el
```

3. **Start Emacs.** Emacs will auto-install all dependencies.

```console
$ emacs
```

Once finished, you have a working Emacs configuration.
