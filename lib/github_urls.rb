require "github_urls/version"

class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
end

module GithubUrls
  def self.parse(url_string)
    return nil if url_string.nil?
    return nil unless url_string.include?('github')
    if extract_github_io_name(url_string)
      return extract_github_io_name(url_string)
    end
    url_string = url_string.gsub(/\s/, '')
    url_string = url_string.split('@')[-1]
    url_string = url_string.split('=')[-1]
    url_string = url_string.gsub(/((git|ssh|hg|svn|scm)+?:)/, '')
    url_string = url_string.gsub(/(https:https:)/, 'https:')
    github_regex = /((git\+)?(((https|http)?:\/\/(www\.)?(wiki\.)?)|\/\/git@|https:\/\/git@|git@||git@))?(www\.)?(ssh\.)?(git\.)?(gith\.)?(wiki\.)?(github.com|github.org|raw.githubusercontent.com)(:|\/)/i

    url_string = url_string.gsub(github_regex, '').strip
    url_string = url_string.gsub(/(\.git|\/)$/i, '')
    url_string = url_string.gsub(/(#\S*)$/i, '')
    url_string = url_string.gsub(/(\?\S*)$/i, '')
    url_string = url_string.gsub(/>|<|(|)|[|]/, '')
    url_string = url_string.split('/').reject(&:blank?)[0..1]
    return nil unless url_string.length == 2
    url_string.join('/')
  end

  def self.extract_github_io_name(url)
    return nil if url.nil?
    return nil if url.match(/www.github.(io|com|org)/i)
    match = url.match(/([\w\.@\:\-_~]+)\.github\.(io|com|org)\/([\w\.@\:\-\_\~]+)/i)
    return nil unless match && match.length == 4
    "#{match[1]}/#{match[3]}"
  end
end
