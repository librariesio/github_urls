require "github_urls/version"
require "github_urls/parser"

class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
end

module GithubUrls
  def self.parse(url_string)
    Parser.parse(url_string)
  end
end
