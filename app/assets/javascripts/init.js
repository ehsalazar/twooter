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

  var searchBarView   = new SearchBarView ();
  var searchBarBinder = new SearchBarBinder ();
  var searchBarController = new SearchBarController ( searchBarView, searchBarBinder );
  searchBarController.init();
})