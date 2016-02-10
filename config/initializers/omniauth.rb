Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, "ZTZMD4YL1FD1KFFQJZODRPJJ4DJJWBFDIDY2QSDJKZFLBRTX", "KX3ONS2Y4AFZF4NNV2UKNBQA3JD4FRSOCNKM3RT25MHK210Q", {:client_options => {:ssl => {:verify=> false}}}
end