module GithubUrls
  class Parser
    def self.parse(url)
      new(url).parse
    end

    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def parse
      return nil if url.nil?
      return nil unless url.include?('github')
      if extract_github_io_name
        return extract_github_io_name
      end

      remove_whitespace
      remove_brackets
      remove_anchors
      remove_querystring
      remove_auth_user
      remove_equals_sign
      remove_scheme
      remove_subdomain
      remove_github_domain
      remove_git_extension
      remove_git_scheme
      remove_extra_segments

      return nil unless url.length == 2
      url.join('/')
    end

    def remove_extra_segments
      self.url = url.split('/').reject(&:blank?)[0..1]
    end

    def remove_brackets
      url.gsub!(/>|<|\(|\)|\[|\]/, '')
    end

    def remove_querystring
      url.gsub!(/(\?\S*)$/i, '')
    end

    def remove_anchors
      url.gsub!(/(#\S*)$/i, '')
    end

    def remove_git_scheme
      url.gsub!(/git\/\//i, '')
    end

    def remove_git_extension
      url.gsub!(/(\.git|\/)$/i, '')
    end

    def remove_equals_sign
      self.url = url.split('=')[-1]
    end

    def remove_auth_user
      self.url = url.split('@')[-1]
    end

    def remove_whitespace
      url.gsub!(/\s/, '')
    end

    def remove_scheme
      url.gsub!(/(((git|ssh|hg|svn|scm|http|https)+?:)+?)/i, '')
    end

    def remove_subdomain
      url.gsub!(/(www|ssh|raw|git|wiki)+?\./i, '')
    end

    def remove_github_domain
      url.gsub!(/(github.io|github.com|github.org|raw.githubusercontent.com)+?(:|\/)?/i, '')
    end

    def extract_github_io_name
      return nil if url.match(/www.github.(io|com|org)/i)
      match = url.match(/([\w\.@\:\-_~]+)\.github\.(io|com|org)\/([\w\.@\:\-\_\~]+)/i)
      return nil unless match && match.length == 4
      "#{match[1]}/#{match[3]}"
    end
  end
end

