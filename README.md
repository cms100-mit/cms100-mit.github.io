# CMS.100 Introduction to Media Studies — Fall 2026
Course website, built with Jekyll + [Just the Docs](https://just-the-docs.com)
and deployed on GitHub Pages.

## Previewing locally

```bash
./serve.sh
```

Then open <http://localhost:4000>. The site rebuilds automatically when you
save, and the browser refreshes itself.

First time on a new machine:

```bash
bundle install
```

### Why serve.sh instead of plain `jekyll serve`

The `github-pages` gem pins Jekyll 3.9 and Liquid 4.0.3 to match GitHub's build
servers. That code predates Ruby 3.2, which deleted `Object#tainted?` — a method
Liquid calls on every variable it renders. `serve.sh` preloads `ruby4_compat.rb`
to restore it as a no-op, and sets a UTF-8 locale so the SCSS compiler accepts
smart quotes. Both are local-only; GitHub Pages builds from source on push and
never sees them.

If local previews start breaking in new ways as Ruby moves on, the durable fix
is to drop the `github-pages` gem for current `jekyll` + `just-the-docs` +
`jekyll-remote-theme`, and deploy via GitHub Actions instead of the built-in
Pages builder.
