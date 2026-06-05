# frozen_string_literal: true
#
# LOCAL-ONLY compatibility shim for previewing this academicpages/github-pages
# site on modern Ruby (3.2+/4.x). The pinned github-pages stack (Jekyll 3.9 +
# Liquid 4.0.3) still calls a few methods Ruby has since removed:
#   * Object#tainted? / #taint / #untaint  — taint mechanism removed in Ruby 3.2
#   * File.exists? / Dir.exists?           — removed in Ruby 3.2
#
# GitHub Pages builds in safe mode and ignores everything in _plugins/, so this
# file has NO effect on the deployed site — it only unblocks `jekyll serve`
# locally. Safe to delete once the toolchain is upgraded to a current Jekyll.

unless Object.new.respond_to?(:tainted?)
  class Object
    def tainted?
      false
    end

    def taint
      self
    end

    def untaint
      self
    end
  end
end

File.singleton_class.alias_method(:exists?, :exist?) unless File.respond_to?(:exists?)
Dir.singleton_class.alias_method(:exists?, :exist?) unless Dir.respond_to?(:exists?)
