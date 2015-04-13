// mvc for create a tweet (part of river? with own view)

$( document ).ready(function () {
  var riverView       = new RiverView ();
  var riverController = new RiverController ( riverView );
  riverController.start();

  var hashView        = new HashtagView ();
  var hashController  = new HashtagController ( hashView );
  hashController.start();

  var tweetBoxView    =  new TweetBoxView ();
  var tweetBoxController = new TweetBoxController ( tweetBoxView );
  tweetBoxController.init(); // event listenter
})

// === River Controller ===================================
function RiverController ( view ) {
  this.view = view;
}

RiverController.prototype = {
  start: function () {
    var request = $.ajax({
      url: "/twoots/recent",
      type: "GET"
    }).done( this.view.render )
  }
}

// === River View =========================================
function RiverView () {
}

RiverView.prototype = {
  render: function ( data ) {
    var source = $( "#tweets-template" ).html();
    var template = Handlebars.compile( source )
    $( '#tweets-collection' ).append( template ({ twoots: data }))
  }
}

// === Hashtag Controller =================================
function HashtagController( view ) {
  this.view = view;
}

HashtagController.prototype = {
  start: function () {
    var request = $.ajax({
      url: "/hashtags/popular",
      type: "GET"
    }).done( this.view.render )
  }
}

// === Hashtag View =======================================
function HashtagView () {
}

HashtagView.prototype = {
  render: function ( data ) {
    var source = $( "#trends-template" ).html();
    var template = Handlebars.compile( source );
    $('#trends-container').append( template ({ hashtags: data }) )
  }
}

// === TweetBox Controller ================================
function TweetBoxController ( view ) {
  this.view = view
  var self = this

  this.init = function () {
    $("#tweet-form").on("submit", this.create)
  },

  this.create = function ( event ) {
    event.preventDefault();
    var post = $.ajax({
      url: "/twoots",
      type: "POST",
      data: { twoot: { 'body': this[0].value } }
    }).done( self.view.render )
  }
}

// === TweetBox View ======================================
function TweetBoxView() {
}

TweetBoxView.prototype = {
  render: function ( data ) {
    var source = $( "#single-tweets-template" ).html();
    var template = Handlebars.compile( source )
    $( '#tweets-collection' ).prepend( template ( data ))
    $( '#new-tweet' ).val("")
  }
}







