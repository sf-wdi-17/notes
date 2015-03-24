$(function() {

	var scoreX = 0, scoreO = 0; // Score trackers for the game

	// Set up the board on load and add in the data elements
	(function() {

		for (var i = 0; i < 9; i++) {
			var $box = $('<div class="box beforeStart">&nbsp;</div>');
			$box.data("space", i);
			$box.appendTo("#board");
		};
	})();

	var currentPlayer = (function(){
		var turn = false;
		
		return function() {
			turn = !turn;
			return turn ? "X" : "O";
		};
	})();

	var checkWins = function(score) {
		var wins = [7, 56, 73, 84, 146, 273, 292, 448];
		console.log(score);
		for (var i = 0; i < wins.length; i++) {
			if((wins[i] & score) === wins[i]) {
				return true;
			}
		};

		return false;
	}


	var doScore = (function() {

		return function(space, player) {

			$board = $('#board'); // Grab the board element in case its needed

			if (player === "X") {
				scoreX += Math.pow(2, space);

				if (checkWins(scoreX)) {
					alert("Player X has won.");
					$board.off().click(function(event) {
						alert("Player X has won. Click reset to start the game again.");
					});
				};

			};
			
			if (player === "O") {
				scoreO += Math.pow(2, space);

				if (checkWins(scoreO)) {
					alert("Player O has won.");
					
					$board.off().click(function(event) {
						alert("Player O has won. Click reset to start the game again.");
					});
				};

			};

		}
	})();

	//var board = document.getElementById('board');
	var $board = $('#board');

	var setupGame = function() {
		scoreX = 0, scoreO = 0; // reset scores to 0

		$('.box').removeClass("beforeStart");
		
		$board.off().click(function(event) { // Unset all events and then set new click event.
			var $el = $(event.target);

			if ($el.html() === '&nbsp;') {
				$el.html(""); // Empty out the element
				var player = currentPlayer();

				var imgSrc = (player === "X") ? "https://lh6.ggpht.com/Ir1ODDSNpKFM7CDrbZdQjsCIqy2xXD2xAe009oJ-yaK9SeZdA6PJsAhmZ1xo8jXEBA=w300" : "http://www.dreamincode.net/forums/uploads/monthly_10_2010/post-0-12884151170642.png";
				$mark = $('<img class="playerMark" src="' + imgSrc + '">'); // Create a wrapper for the X or O mark
				$el.addClass(player).append($mark);

				doScore($el.data("space"), player);

				console.log(player);
			} else {
				console.log("This square has already been clicked");
			}
		});

	}

	

	var $button = $('#reset');

	$button.click(function(e) {
		var $boxes = $('.box');

		// for (var i = 0; i < boxes.length; i++) {
		// 	var box = boxes[i];
		// 	box.innerHTML = "&nbsp;";
		// 	box.setAttribute("class", "box");
		// }

		$boxes.html('&nbsp;').removeClass("X O");

		if (currentPlayer() === "X") {
			currentPlayer();
		}

		setupGame();

		// On first run of game, change button to say "Reset"
		if($button.html() === "Start Game")
			$button.html("Reset Game");

		console.log('Clicked');
	});

});


