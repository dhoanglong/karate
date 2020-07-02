function fn() {
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }
  var port ='9080'
  var config = {
//    baseURL: 'https://api.thecatapi.com/v1/',
//    apiKey: '3e5c20e0-2875-4551-b983-d25c008d626c'
    baseURL: 'http://localhost:' + port + '/api'
  };
//  if (env == 'stage') {
//    // over-ride only those that need to be
//    config.baseURL = 'https://stage-host/v1/auth';
//  } else if (env == 'e2e') {
//    config.baseURL = 'https://e2e-host/v1/auth';
//  }
  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
