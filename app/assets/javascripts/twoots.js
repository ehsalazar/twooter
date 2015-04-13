// Ready... set... go
$( document ).ready(function () {
  init()
})

function init () {
  recentTweets();
  popularHashtags();
  bindEventListeners();
}

// view for create a tweet
function bindEventListeners() {
  $("#tweet-form").on("submit", createTweet)
}

// --- Grab Recent Tweets
function recentTweets () {
  var request = $.ajax({
    url: "/twoots/recent",
    type: "GET"
  }).done(updateRiver)
}

// --- Make Tweet
function createTweet(event) {
  // event.preventDefault()
  var post = $.ajax({
    url: "/twoots",
    type: "POST",
    data: { tweet: {'content': this[0].value } }
  }).done(updateRiver)
}

// --- Update Tweet River (for make and grab recent)
function updateRiver ( data ) {
  var source   = $("#tweets-template").html();
  var template = Handlebars.compile(source);
  $('#tweets-container').append(template({tweets: data}))
}

// --- grab hashtags
function popularHashtags () {
  var request = $.ajax({
    url: "/hashtags/popular",
    type: "GET"
  }).done(updateHashtags)
}

// --- append hashtags
function updateHashtags ( data ) {
  var source   = $("#trends-template").html();
  var template = Handlebars.compile(source);
  $('#trends-container').append(template({hashtags: data}))
}














