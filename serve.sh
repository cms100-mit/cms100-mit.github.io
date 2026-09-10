#!/usr/bin/env bash
# Local preview for the CMS.100 site: http://localhost:4000
set -euo pipefail
cd "$(dirname "$0")"

# macOS ships Ruby 2.6, which is far too old for this site's gems. Put the
# Homebrew Ruby first explicitly rather than trusting the shell's PATH — a
# terminal opened before `brew install ruby` will still resolve /usr/bin/ruby
# and fail with confusing "ffi requires ruby >= 3.0" errors.
if [ -x /opt/homebrew/opt/ruby/bin/ruby ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
fi

if ruby -e 'exit(RUBY_VERSION.split(".").first.to_i < 3)'; then
  echo "error: found Ruby $(ruby -e 'print RUBY_VERSION') at $(command -v ruby)" >&2
  echo "       This site needs Ruby 3+. Try: brew install ruby" >&2
  exit 1
fi

# Two workarounds, both local-only — GitHub Pages builds from source on push
# and never sees them:
#   RUBYOPT  loads ruby4_compat.rb, restoring Object#tainted? for Liquid 4.0.3,
#            which the github-pages gem pins and Ruby 3.2 broke.
#   LANG     forces UTF-8 so the SCSS compiler accepts smart quotes.
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 RUBYOPT="-r./ruby4_compat" \
  exec bundle exec jekyll serve --livereload --port 4000 "$@"
