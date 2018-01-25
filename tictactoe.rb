class Players
  attr_accessor :name, :symbol # un joueur aura 2 propriétés, son "name" et son "symbol"
  def initialize(name, symbol) # on initialise les propriétés
    @name = name
    @symbol = symbol
  end

end

class Board
  attr_accessor :board, :grid # on ajoute 2 propriétés

  def initialize() # on initialise la grillle pour qu'elle soit vide et on fait correspondre chaque case à une valeur qu'on range dans un hash 
    @board = "
     --------------
      a1 | a2 | a3
     --------------
      b1 | b2 | b3
     --------------
      c1 | c2 | c3
     --------------" # on met les combinaisons de touches pour marquer un X ou O selon l'utilisateur

    @grid = {a1: 'null', a2: 'null', a3: 'null', # chaque case de la grille est nulle au départ
     b1: 'null', b2: 'null', b3: 'null',
     c1: 'null', c2: 'null', c3: 'null'}
  end

  def start() # la fonction "start" correspond au début du jeu ==> on va enregistrer le nom des joueurs et leur attribuer un symbole
    puts "Joueur 1, quel est votre nom ?"
      player1 = $stdin.gets.chomp
      playerX = Players.new(player1, "X") # on ajoute un joueur dans la classe Players : son "name" est player1 et son "symbol" est X
      puts "___________________________________"
      puts "Ok #{playerX.name}, tu es X"
      puts "___________________________________"

    puts "Joueur 2, quel es votre nom ?"
      player2 = $stdin.gets.chomp
      playerO = Players.new(player2, "O") # on ajoute un joueur dans la classe Players : son "name" est player2 et son "symbol" est O 
      puts "___________________________________"
      puts "Ok #{playerO.name}, tu es O."
      puts "___________________________________"

      game = Board.new() # ok on instancie dans la classe Board
      play(playerO.name, playerO.symbol, playerX.name, playerX.symbol, game.board) # OK chaque joueur a un nom et un symbole 
  end

  def win_checker(marker) # on attribut toutes les positions gagnantes dans la grille avec 'marker' en paramètres qui correspond à l'input de l'un des utilisateurs
      if (@grid[:a1] == marker) && (@grid[:a2] == marker) && (@grid[:a3] == marker)
        return 'win' # on retourne "win"  
      elsif (@grid[:b1] == marker) && (@grid[:b2] == marker) && (@grid[:b3] == marker)
        return 'win'
      elsif (@grid[:c1] == marker) && (@grid[:c2] == marker) && (@grid[:c3] == marker)
        return 'win'
      elsif (@grid[:a1] == marker) && (@grid[:b1] == marker) && (@grid[:c1] == marker)
        return 'win'
      elsif (@grid[:a2] == marker) && (@grid[:b2] == marker) && (@grid[:c2] == marker)
        return 'win'
      elsif (@grid[:a3] == marker) && (@grid[:b3] == marker) && (@grid[:c3] == marker)
        return 'win'
      elsif (@grid[:a1] == marker) && (@grid[:b2] == marker) && (@grid[:c3] == marker)
        return 'win'
      elsif (@grid[:a3] == marker) && (@grid[:b2] == marker) && (@grid[:c1] == marker)
        return 'win'
     else
        return 'play' #sinon on continue de jouer dans la fonction play
      end
  end

  def turn(player, marker, display) # cette fonction récupère la case dans laquelle le joueur souhaite placer son symbole
    puts display 
    puts "Où veux-tu te placer #{player}? Ecrit la case dans laquelle tu souhaites placer ton #{marker}"
    user_input = $stdin.gets.chomp # on récupère les données écrite par l'un des joueurs
      exit?(user_input) # on sort de l'input
    @grid[user_input.to_sym] = marker # on remplit la case du joueur par l'input d'un joueur et on le converti en "symbol", ce qui nous donnera la variable "marker"
    @board = display.gsub!(user_input, marker) # on remplit la grille par la case ci-dessus
  end

  def play(playerO_name, playerO_symbol, playerX_name, playerX_symbol, game_board) #
      while ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"].any? {|box| game_board.include? box} # tant qu'il y a l'une des valeurs (a1, a2, etc.) dans la grille... 
            turn(playerX_name, playerX_symbol, game_board) # on fait jouer le joueur au symbole X...
            if win_checker(playerX_symbol) == 'win' # si le joueur a gagné...
              winner(playerX_name, game_board) 
              break # ...on arrête la boucle et on va à la méthode winner ci-dessous.
            end
            turn(playerO_name, playerO_symbol, game_board) if ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"].any? {|box| game_board.include? box} # même principe que ci-dessus
            if win_checker(playerO_symbol) == 'win'
              winner(playerO_name, game_board)
              break
            end
      end
    puts game_board + "\n Mauvaise manipulation..." if win_checker(playerX_symbol) != 'win' && win_checker(playerO_symbol) != 'win' # si on sort de la boucle ci-dessus mais qu'on a quand même pas gagné ('win') alors on affiche un message d'erreur.
  end

  def winner(player, board) #  méthode pour annoncer le vainqueur
    puts board # on affiche la grille
    puts "Bien joué #{player}, tu as gagné !" # l'un des "player" a gagné et on l'annonce   
    puts "Félicitation !"
  end

  def exit?(user_input) # on créé une méthode qui permet de quitter le jeu si l'un des joueurs tape "exit"
    if user_input == "exit"
      exit
    end
  end
end

game = Board.new() # on lance la classe Board en lui ajoutant une instance game
game.start() # on lance la méthode start