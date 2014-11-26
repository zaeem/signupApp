OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'HVR38aUydtciVmZJnMpkun4QT', 'wlUAq5W8lgqD5w5WDR9RPAsYTVFgO4jyLcv46IzOmpUseIbpK1'
end

