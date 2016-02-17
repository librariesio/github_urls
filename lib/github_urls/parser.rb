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
      url_string = remove_whitespace(url_string)
      url_string = remove_brackets(url_string)
      url_string = remove_anchors(url_string)
      url_string = remove_querystring(url_string)
      url_string = remove_auth_user(url_string)
      url_string = remove_equals_sign(url_string)
      url_string = remove_scheme(url_string)
      url_string = remove_subdomain(url_string)
      url_string = remove_github_domain(url_string)
      url_string = remove_git_extension(url_string)
      url_string = remove_git_scheme(url_string)
      url_string = remove_extra_segments(url_string)

      return nil unless url_string.length == 2
      url_string.join('/')
    end

    def remove_extra_segments(string)
      string.split('/').reject(&:blank?)[0..1]
    end

    def remove_brackets(string)
      string.gsub(/>|<|\(|\)|\[|\]/, '')
    end

    def remove_querystring(string)
      string.gsub(/(\?\S*)$/i, '')
    end

    def remove_anchors(string)
      string.gsub(/(#\S*)$/i, '')
    end

    def remove_git_scheme(string)
      string.gsub(/git\/\//i, '')
    end

    def remove_git_extension(string)
      string.gsub(/(\.git|\/)$/i, '')
    end

    def remove_equals_sign(string)
      string.split('=')[-1]
    end

    def remove_auth_user(string)
      string.split('@')[-1]
    end

    def remove_whitespace(string)
      string.gsub(/\s/, '')
    end

    def remove_scheme(string)
      string.gsub(/(((git|ssh|hg|svn|scm|http|https)+?:)+?)/i, '')
    end

    def remove_subdomain(string)
      string.gsub(/(www|ssh|raw|git|wiki)+?\./i, '')
    end

    def remove_github_domain(string)
      string.gsub(/(github.io|github.com|github.org|raw.githubusercontent.com)+?(:|\/)?/i, '')
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

