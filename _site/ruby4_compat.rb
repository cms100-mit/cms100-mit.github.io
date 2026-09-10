# Local-only shim, loaded via RUBYOPT (see README / serve command).
#
# Ruby 3.2 removed Object#tainted? and #untaint, but liquid 4.0.3 — the version
# hard-pinned by the github-pages gem — still calls tainted? on every variable
# render. Restoring them as no-ops is safe: taint tracking was already inert in
# Ruby 2.7+ before being deleted outright.
#
# This file is never used by GitHub Pages; it only unblocks local previews.
class Object
  def tainted?
    false
  end

  def untaint
    self
  end
end
