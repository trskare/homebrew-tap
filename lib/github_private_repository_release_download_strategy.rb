  require "download_strategy"

  class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
  super
  @token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", ENV["GITHUB_TOKEN"])
  raise CurlDownloadStrategyError, "HOMEBREW_GITHUB_API_TOKEN (or GITHUB_TOKEN) is required for private GitHub release downloads" if @token.to_s.empty?
  end

  def _fetch(url:, resolved_url:, timeout:)
  curl_download url,
  "--header", "Authorization: token #{@token}",
  "--header", "Accept: application/octet-stream",
  to: temporary_path,
  timeout: timeout
  end
  end

  class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
  super
  @token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", ENV["GITHUB_TOKEN"])
  raise CurlDownloadStrategyError, "HOMEBREW_GITHUB_API_TOKEN (or GITHUB_TOKEN) is required for private GitHub downloads" if @token.to_s.empty?
  end

  def _fetch(url:, resolved_url:, timeout:)
  curl_download url,
  "--header", "Authorization: token #{@token}",
  to: temporary_path,
  timeout: timeout
  end
  end
