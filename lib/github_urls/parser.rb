module GithubUrls
  class Parser
    def self.parse(url)
      new(url).parse
    end

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def parse
      return nil if url.nil?
      return nil unless url.include?('github')
      if extract_github_io_name(url)
        return extract_github_io_name(url)
      end
      url_string = url
      url_string = url_string.gsub(/\s/, '')
      url_string = url_string.gsub(/>|<|\(|\)|\[|\]/, '')
      url_string = url_string.gsub(/(#\S*)$/i, '')
      url_string = url_string.gsub(/(\?\S*)$/i, '')
      url_string = url_string.split('@')[-1]
      url_string = url_string.split('=')[-1]
      url_string = url_string.gsub(/(((git|ssh|hg|svn|scm|http|https)+?:)+?)/i, '')
      url_string = url_string.gsub(/(www|ssh|raw|git|wiki)+?\./i, '')
      url_string = url_string.gsub(/(github.io|github.com|github.org|raw.githubusercontent.com)+?(:|\/)?/i, '')
      url_string = url_string.gsub(/(\.git|\/)$/i, '')
      url_string = url_string.gsub(/git\/\//i, '')
      url_string = url_string.split('/').reject(&:blank?)[0..1]
      return nil unless url_string.length == 2
      url_string.join('/')
    end

    def extract_github_io_name(url)
      return nil if url.nil?
      return nil if url.match(/www.github.(io|com|org)/i)
      match = url.match(/([\w\.@\:\-_~]+)\.github\.(io|com|org)\/([\w\.@\:\-\_\~]+)/i)
      return nil unless match && match.length == 4
      "#{match[1]}/#{match[3]}"
    end
  end
end

