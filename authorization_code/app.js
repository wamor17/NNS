/**
 * This is an example of a basic node.js script that performs
 * the Authorization Code oAuth2 flow to authenticate against
 * the Spotify Accounts.
 *
 * For more information, read
 * https://developer.spotify.com/web-api/authorization-guide/#authorization_code_flow
 */

var express = require('express'); // Express web server framework
var request = require('request'); // "Request" library
var querystring = require('querystring');
var cookieParser = require('cookie-parser');

var client_id = ''; // Your client id
var client_secret = ''; // Your secret
var redirect_uri = 'http://localhost:8888/callback'; // Your redirect uri

/**
 * Generates a random string containing numbers and letters
 * @param  {number} length The length of the string
 * @return {string} The generated string
 */
var generateRandomString = function(length) {
  var text = '';
  var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  for (var i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return text;
};

var stateKey = 'spotify_auth_state';

var app = express();

app.use(express.static(__dirname + '/public'))
   .use(cookieParser());

app.get('/login', function(req, res) {

  var state = generateRandomString(16);
  res.cookie(stateKey, state);

  // your application requests authorization
  var scope = 'user-read-private user-read-email';
  res.redirect('https://accounts.spotify.com/authorize?' +
    querystring.stringify({
      response_type: 'code',
      client_id: client_id,
      scope: scope,
      redirect_uri: redirect_uri,
      state: state
    }));
});

app.get('/callback', function(req, res) {

  // your application requests refresh and access tokens
  // after checking the state parameter

  var code = req.query.code || null;
  var state = req.query.state || null;
  var storedState = req.cookies ? req.cookies[stateKey] : null;

  if (state === null || state !== storedState) {
    res.redirect('/#' +
      querystring.stringify({
        error: 'state_mismatch'
      }));
  } else {
    res.clearCookie(stateKey);
    var authOptions = {
      url: 'https://accounts.spotify.com/api/token',
      form: {
        code: code,
        redirect_uri: redirect_uri,
        grant_type: 'authorization_code'
      },
      headers: {
        'Authorization': 'Basic ' + (new Buffer(client_id + ':' + client_secret).toString('base64'))
      },
      json: true
    };

    


    function playStreamConsole(playlistId, userId,access_token,refresh_token,genero) {
      var options = {
        url: 'https://api.spotify.com/v1/users/'+userId+'/playlists/'+playlistId+'/tracks?market=ES&fields=items(track(name,id))&limit=68&offset=0',
        headers: { 'Authorization': 'Bearer ' + access_token },
        json: true
      };
      request.get(options, function(error, response, body) {
        //console.log(body.items.length);
       
        var idt = body.items[0].track.id;
        for (var i = 1; i < body.items.length; i++) {
          var sId = body.items[i].track.id;
          var songName = body.items[i].track.name;
          var sal = sId + ' ' + songName;
          idt = idt + ',' + body.items[i].track.id;
          //console.log(sal);
        }
        var opt = {
          url: 'https://api.spotify.com/v1/audio-features?ids=' + idt,
          headers: { 'Authorization': 'Bearer ' + access_token },
          json: true
        };
        request.get(opt, function(error, response, body2){
          //console.log(body2);
          for (var i = 0; i < body2.audio_features.length; i++) {
            var element = body2.audio_features[i];
            var salida = element.danceability
            + ', ' + element.energy
            + ', ' + element.key
            + ', ' + element.loudness
            + ', ' + element.mode
            + ', ' + element.speechiness
            + ', ' + element.acousticness
            + ', ' + element.instrumentalness
            + ', ' + element.liveness
            + ', ' + element.valence
            + ', ' + element.tempo + ', '+genero;
            console.log(salida);
            
          }
          
        });
      });


    }

    //model provided by weka Multilayer perceptron 
    function songGenre(danceability,energy,key,loudness,mode,speechiness,acousticness,instrumentalness,liveness,valence,tempo){
      var node10 = danceability  *  6.997157707248215
      + energy  *  4.862031434578238
      + key  *  -1.6219041203664024
      + loudness  *  9.604185449067343
      + mode *   1.9706142902890433
      + speechiness   * 7.300855209602662
      + acousticness  *  -0.820395543177108
      + instrumentalness  *  -3.4075290699777603
      + liveness  *  -1.9568730007200539
      + valence  *  -5.14131578644236
      + tempo  *  -1.6982891137056497;

      var node9 = danceability  *  0.495897069056054
      + energy  *  7.510934948915397
      + key   * -1.702415560296827
      + loudness *   -5.3778198081538475
      + mode *   1.1502508944931618
      + speechiness  *  5.04848705011842
      + acousticness *   0.7201668812719576
      + instrumentalness  *  0.380425705549369
      + liveness  *  2.7216243954893846
      + valence *   9.685256396900254
      + tempo *   0.7080968497862127;

      var node8 = danceability *   3.8828640758971127
      + energy  *  -5.096476061971926
      + key  *  -3.149351013911207
      + loudness  *  8.219617604415646
      + mode  *  1.5872999508232835
      + speechiness  *  1.6965977041787823
      + acousticness *   1.1078427430781834
      + instrumentalness  *  0.023347270073926625
      + liveness *   -2.67247448522038
      + valence  *  -0.8231270133611804
      + tempo  *  -1.1103973292755067;

      var node7 = danceability  *  -2.4993564923676495
      + energy *   -4.760097468799522
      + key  *  0.8094654735103495
      + loudness  *  -3.4375144484916182
      + mode  *  -0.6030999357889668
      + speechiness  *  -3.6539062575565158
      + acousticness *   1.0642239218918532
      + instrumentalness  *  2.4428111663071466
      + liveness  *  -0.08834284272314019
      + valence *   3.9937642511711426
      + tempo  *  0.4627127686799716;

      var node6 = danceability  *  7.430141011512432
      + energy  *  -5.581210970844047
      + key  *  -0.3616751984524231
      + loudness  *  7.8831599924082125
      + mode  *  1.517667661084508
      + speechiness  *  0.8062171696205649
      + acousticness   * -0.12096156754410724
      + instrumentalness  *  -2.7860594070208
      + liveness *   1.4390010174347072
      + valence *   0.7729656144831463
      + tempo  *  2.915375738700547;

      var node5 = danceability  *  0.2942175745834719
      + energy  *  9.003857156768357
      + key  *  -1.6978843048237215
      + loudness  *  -8.122363718802237
      + mode *   0.5267542942794367
      + speechiness  *  0.5345574632378868
      + acousticness *   -0.7120454742280412
      + instrumentalness *   3.4967759017620708
      + liveness *   -2.9011655569189965
      + valence  *  2.271806498393726
      + tempo  *  -2.1555221286180797;

      var node4 = danceability *   -0.08471076689515705
      + energy  *  -5.489921579041415
      + key *   -0.024416613835547666
      + loudness  *  -5.075955172110244
      + mode *   1.997178644286046
      + speechiness *   -7.603660929744988
      + acousticness *   4.974680302809416
      + instrumentalness *   -0.8444339842391761
      + liveness  *  6.156695710144062
      + valence *   3.88906964564521
      + tempo  *  1.044064585519532;

      var node3 = node4  *  -4.120595441775882
      + node5  *  5.077932650283655
      + node6  *  -5.26457757164372
      + node7  *  2.85842642218365
      + node8  *  -6.351415143857489
      + node9  *  -8.10301359478401
      + node10 *   6.504290642054541;

      var node2 = node4 *   -5.971113398485105
      + node5 *   -4.520492001161191
      + node6 *   -6.2727857936276665
      + node7 *   -7.2918548975110165
      + node8 *   4.963076905505547
      + node9 *   10.41121145634989
      + node10  *  -6.936877675209364;

      var node1 = node4 *   -9.532501301886468
      + node5  *  -7.810640962279495
      + node6  *  7.738498529424319
      + node7  *  -1.1475999621269808
      + node8  *  3.057481142425089
      + node9  *  -4.718977864947505
      + node10 *   1.1873393265319698;

      var node0 =  node4  *  10.173360846479827
      + node5  *  -1.4047850274104365
      + node6  *  0.20183158531103867
      + node7  *  2.3050410537886696
      + node8  *  -0.10811007102056269
      + node9  *  -0.15796674335951816
      + node10 *   -6.787513829203931;

     var mayor = 0;
     
     if (node0 > mayor){
       mayor = node0;
     }
     if (node1 > mayor){
      mayor = node1;
      }
      if (node2 > mayor){
      mayor = node2;
      }
      if (node3 > mayor){
      mayor = node3;
      }

      if (node0 == mayor){
      return 'mexicano';
      }else if (node1 == mayor){
      return 'pop';
      }else if (node2 == mayor){
      return 'rock';
      }else if (node3 == mayor){
      return 'metal';
      }
     

    }

    function playlistWrongSongGenre(playlistId, userId,access_token,refresh_token,genero) {
      var options = {
        url: 'https://api.spotify.com/v1/users/'+userId+'/playlists/'+playlistId+'/tracks?market=ES&fields=items(track(name,id))&limit=68&offset=0',
        headers: { 'Authorization': 'Bearer ' + access_token },
        json: true
      };
      request.get(options, function(error, response, body) {
        //console.log(body.items.length);
       
        var idt = body.items[0].track.id;
        for (var i = 1; i < body.items.length; i++) {
          var sId = body.items[i].track.id;
          var songName = body.items[i].track.name;
          var sal = sId + ' ' + songName;
          idt = idt + ',' + body.items[i].track.id;
          //console.log(sal);
        }
        var opt = {
          url: 'https://api.spotify.com/v1/audio-features?ids=' + idt,
          headers: { 'Authorization': 'Bearer ' + access_token },
          json: true
        };
        request.get(opt, function(error, response, body2){
          //console.log(body2);
          for (var i = 0; i < body2.audio_features.length; i++) {
            var element = body2.audio_features[i];
            var gen = songGenre(element.danceability,element.energy,element.key,element.loudness,element.mode,element.speechiness,element.acousticness,element.instrumentalness,element.liveness,element.valence,element.tempo);
            if (genero != gen){
              var salida = element.id + ' ' + gen + ' ' + genero;
              console.log(salida);
            } 
            
          }
          
        });
      });
    }

    request.post(authOptions, function(error, response, body) {
      if (!error && response.statusCode === 200) {

        var access_token = body.access_token,
            refresh_token = body.refresh_token;
        var playlistM = '2v57WWENoDs0GC3SjvD6Nt';
        var playlistPop = '7lX55qDjynVxQlCbrWSAer';
        var playlistRock = '5fIz9EJpgHBgSJgQ8I0hot';
        var walter = '12180557174';
        var metal = '2agL2ffvTRBYU22DZz1E8z';
        var pedro = '1276669561';
        

        
        playStreamConsole(playlistM,pedro,access_token,refresh_token,"mexicano");
        playStreamConsole(playlistPop,pedro,access_token,refresh_token,"pop");
        playStreamConsole(playlistRock,pedro,access_token,refresh_token,"rock");
        playStreamConsole(metal,walter,access_token,refresh_token,"metal");

        

        // use the access token to access the Spotify Web API
        

        

        // we can also pass the token to the browser to make requests from there
        res.redirect('/#' +
          querystring.stringify({
            access_token: access_token,
            refresh_token: refresh_token
          }));
      } else {
        res.redirect('/#' +
          querystring.stringify({
            error: 'invalid_token'
          }));
      }
    });

    
  }
});

app.get('/refresh_token', function(req, res) {

  // requesting access token from refresh token
  var refresh_token = req.query.refresh_token;
  var authOptions = {
    url: 'https://accounts.spotify.com/api/token',
    headers: { 'Authorization': 'Basic ' + (new Buffer(client_id + ':' + client_secret).toString('base64')) },
    form: {
      grant_type: 'refresh_token',
      refresh_token: refresh_token
    },
    json: true
  };

  request.post(authOptions, function(error, response, body) {
    if (!error && response.statusCode === 200) {
      var access_token = body.access_token;
      res.send({
        'access_token': access_token
      });
    }
  });
});

console.log('\n Listening on 8888...');
app.listen(8888);
