CREATE TABLE IF NOT EXISTS questions (
  id SERIAL PRIMARY KEY,
  question TEXT NOT NULL,
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT NOT NULL,
  option_d TEXT NOT NULL,
  correct_answer CHAR(1) NOT NULL,
  category TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS leaderboard (
  id SERIAL PRIMARY KEY,
  player_name TEXT NOT NULL,
  score INTEGER NOT NULL,
  total_questions INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO questions (question, option_a, option_b, option_c, option_d, correct_answer, category) VALUES
-- FOOTBALL
('Which country won the 2018 FIFA World Cup?', 'Croatia', 'France', 'Brazil', 'Germany', 'B', 'Football'),
('How many Ballon d''Or awards has Lionel Messi won?', '6', '7', '8', '9', 'C', 'Football'),
('Which club has won the most UEFA Champions League titles?', 'Barcelona', 'Bayern Munich', 'Real Madrid', 'AC Milan', 'C', 'Football'),
('Who scored the "Hand of God" goal?', 'Pelé', 'Diego Maradona', 'Ronaldo', 'Zidane', 'B', 'Football'),
('Which country hosted the 2022 FIFA World Cup?', 'UAE', 'Saudi Arabia', 'Qatar', 'Bahrain', 'C', 'Football'),
('Who is the all-time top scorer in FIFA World Cup history?', 'Ronaldo', 'Miroslav Klose', 'Pelé', 'Gerd Müller', 'B', 'Football'),
('Which team won the first FIFA World Cup in 1930?', 'Brazil', 'Argentina', 'Uruguay', 'Italy', 'C', 'Football'),
('How many players are on a football team on the field?', '10', '11', '12', '9', 'B', 'Football'),
('Which club did Cristiano Ronaldo join after leaving Manchester United in 2009?', 'PSG', 'Real Madrid', 'Juventus', 'Bayern Munich', 'B', 'Football'),
('What color card results in a player being sent off?', 'Yellow', 'Orange', 'Red', 'Blue', 'C', 'Football'),
('Which country has won the most FIFA World Cups?', 'Germany', 'Italy', 'Argentina', 'Brazil', 'D', 'Football'),
('In what year did Zinedine Zidane head-butt Marco Materazzi in the World Cup final?', '2002', '2004', '2006', '2010', 'C', 'Football'),
('Which player is known as "El Pibe de Oro"?', 'Pelé', 'Maradona', 'Ronaldinho', 'Zidane', 'B', 'Football'),
('What is the maximum number of substitutions allowed in a standard football match?', '3', '4', '5', '6', 'C', 'Football'),
('Which English club is known as "The Red Devils"?', 'Liverpool', 'Arsenal', 'Manchester United', 'Chelsea', 'C', 'Football'),
('Who won the 2022 FIFA World Cup Golden Boot?', 'Mbappé', 'Messi', 'Neymar', 'Benzema', 'A', 'Football'),
('Which stadium is the home of FC Barcelona?', 'Santiago Bernabéu', 'Camp Nou', 'Allianz Arena', 'Anfield', 'B', 'Football'),
('How long is a standard football match?', '80 minutes', '90 minutes', '100 minutes', '120 minutes', 'B', 'Football'),
('Which country does Kylian Mbappé play for?', 'Belgium', 'France', 'Senegal', 'Morocco', 'B', 'Football'),
('Who won the UEFA Euro 2020 tournament?', 'France', 'England', 'Italy', 'Spain', 'C', 'Football'),

-- BASKETBALL
('Which NBA team has won the most championships?', 'LA Lakers', 'Boston Celtics', 'Chicago Bulls', 'Golden State Warriors', 'B', 'Basketball'),
('Who holds the NBA record for most points scored in a single game?', 'Michael Jordan', 'Kobe Bryant', 'Wilt Chamberlain', 'LeBron James', 'C', 'Basketball'),
('How high is an NBA basketball hoop from the floor?', '8 feet', '9 feet', '10 feet', '11 feet', 'C', 'Basketball'),
('Which player is known as "The Black Mamba"?', 'LeBron James', 'Kobe Bryant', 'Dwyane Wade', 'Kevin Durant', 'B', 'Basketball'),
('How many players are on the court per team in basketball?', '4', '5', '6', '7', 'B', 'Basketball'),
('Which country invented basketball?', 'USA', 'Canada', 'UK', 'France', 'B', 'Basketball'),
('Who is the NBA all-time leading scorer?', 'Kareem Abdul-Jabbar', 'LeBron James', 'Michael Jordan', 'Kobe Bryant', 'B', 'Basketball'),
('How many points is a three-pointer worth in basketball?', '2', '3', '4', '5', 'B', 'Basketball'),
('Which team did Michael Jordan play for during his six championships?', 'LA Lakers', 'Boston Celtics', 'Chicago Bulls', 'Miami Heat', 'C', 'Basketball'),
('What is the shot clock duration in the NBA?', '20 seconds', '24 seconds', '30 seconds', '35 seconds', 'B', 'Basketball'),
('Which player won the most NBA MVP awards?', 'Michael Jordan', 'LeBron James', 'Kareem Abdul-Jabbar', 'Bill Russell', 'C', 'Basketball'),
('In what year was the NBA founded?', '1940', '1946', '1950', '1955', 'B', 'Basketball'),
('Which country won the first Olympic basketball gold medal?', 'USA', 'USSR', 'Canada', 'Brazil', 'A', 'Basketball'),
('What does NBA stand for?', 'National Basketball Alliance', 'National Basketball Association', 'North American Basketball Association', 'National Ball Association', 'B', 'Basketball'),
('Who invented basketball?', 'James Naismith', 'Michael Jordan', 'Larry Bird', 'Magic Johnson', 'A', 'Basketball'),

-- TENNIS
('Who has won the most Grand Slam singles titles in men''s tennis?', 'Rafael Nadal', 'Roger Federer', 'Novak Djokovic', 'Pete Sampras', 'C', 'Tennis'),
('How many sets are played in a men''s Grand Slam final?', '3', '4', '5', '6', 'C', 'Tennis'),
('Which Grand Slam is played on clay?', 'Wimbledon', 'US Open', 'Australian Open', 'French Open', 'D', 'Tennis'),
('What is the term for a score of 40-40 in tennis?', 'Tie', 'Deuce', 'Match point', 'Set point', 'B', 'Tennis'),
('Which surface is Wimbledon played on?', 'Clay', 'Hard', 'Grass', 'Carpet', 'C', 'Tennis'),
('Who is known as the "King of Clay"?', 'Roger Federer', 'Rafael Nadal', 'Novak Djokovic', 'Andre Agassi', 'B', 'Tennis'),
('How many Grand Slam titles did Serena Williams win?', '20', '21', '22', '23', 'D', 'Tennis'),
('What is an ace in tennis?', 'A winning return', 'A serve the opponent cannot touch', 'A double fault', 'A net cord winner', 'B', 'Tennis'),
('Which country does Novak Djokovic represent?', 'Croatia', 'Serbia', 'Slovenia', 'Bosnia', 'B', 'Tennis'),
('What is the first point called in tennis?', '15', '10', '5', '1', 'A', 'Tennis'),

-- FORMULA 1
('Who has won the most Formula 1 World Championships?', 'Michael Schumacher', 'Lewis Hamilton', 'Ayrton Senna', 'Sebastian Vettel', 'B', 'Formula 1'),
('Which team has won the most Constructors Championships in F1?', 'Ferrari', 'Mercedes', 'Red Bull', 'McLaren', 'A', 'Formula 1'),
('How many times did Michael Schumacher win the F1 World Championship?', '5', '6', '7', '8', 'C', 'Formula 1'),
('Which country hosts the Monaco Grand Prix?', 'France', 'Italy', 'Monaco', 'Spain', 'C', 'Formula 1'),
('Who won the 2023 F1 World Championship?', 'Lewis Hamilton', 'Max Verstappen', 'Charles Leclerc', 'Fernando Alonso', 'B', 'Formula 1'),
('What nationality is Max Verstappen?', 'Belgian', 'Dutch', 'German', 'Austrian', 'B', 'Formula 1'),
('Which F1 team does Lewis Hamilton drive for as of 2024?', 'Red Bull', 'McLaren', 'Mercedes', 'Ferrari', 'C', 'Formula 1'),
('What is the DRS system in F1?', 'Dynamic Racing System', 'Drag Reduction System', 'Driver Response System', 'Dual Rear Spoiler', 'B', 'Formula 1'),
('In which country is the Silverstone circuit located?', 'Germany', 'USA', 'UK', 'Italy', 'C', 'Formula 1'),
('Who was the youngest F1 World Champion ever?', 'Max Verstappen', 'Lewis Hamilton', 'Sebastian Vettel', 'Fernando Alonso', 'C', 'Formula 1'),

-- OLYMPICS
('Where were the 2020 Summer Olympics held?', 'Paris', 'Tokyo', 'London', 'Rio', 'B', 'Olympics'),
('How often are the Summer Olympics held?', 'Every 2 years', 'Every 3 years', 'Every 4 years', 'Every 5 years', 'C', 'Olympics'),
('Which country has won the most Olympic gold medals all time?', 'China', 'Russia', 'Germany', 'USA', 'D', 'Olympics'),
('Who lit the cauldron at the 1996 Atlanta Olympics?', 'Michael Jordan', 'Muhammad Ali', 'Carl Lewis', 'Jesse Owens', 'B', 'Olympics'),
('Where will the 2028 Summer Olympics be held?', 'New York', 'Los Angeles', 'Chicago', 'San Francisco', 'B', 'Olympics'),
('Which sport was added to the Olympics in Tokyo 2020?', 'Cricket', 'Skateboarding', 'Squash', 'Chess', 'B', 'Olympics'),
('How many rings are on the Olympic flag?', '4', '5', '6', '7', 'B', 'Olympics'),
('Who won the most Olympic gold medals ever?', 'Carl Lewis', 'Usain Bolt', 'Michael Phelps', 'Mark Spitz', 'C', 'Olympics'),
('In which city were the first modern Olympics held in 1896?', 'London', 'Paris', 'Athens', 'Rome', 'C', 'Olympics'),
('What do the five Olympic rings represent?', 'Five continents', 'Five sports', 'Five founding countries', 'Five values', 'A', 'Olympics'),

-- CRICKET
('How many players are in a cricket team?', '9', '10', '11', '12', 'C', 'Cricket'),
('Which country has won the most Cricket World Cups?', 'India', 'Australia', 'West Indies', 'England', 'B', 'Cricket'),
('What is the highest score ever in a single ODI innings by a batsman?', '200', '209', '215', '264', 'D', 'Cricket'),
('Who holds the record for most Test centuries?', 'Ricky Ponting', 'Sachin Tendulkar', 'Virat Kohli', 'Brian Lara', 'B', 'Cricket'),
('How many balls are in a standard cricket over?', '4', '5', '6', '8', 'C', 'Cricket'),

-- AMERICAN FOOTBALL
('Which team has won the most Super Bowls?', 'Dallas Cowboys', 'San Francisco 49ers', 'New England Patriots', 'Pittsburgh Steelers', 'C', 'American Football'),
('How many points is a touchdown worth in American football?', '4', '5', '6', '7', 'C', 'American Football'),
('How long is an American football field in yards?', '80', '90', '100', '110', 'C', 'American Football'),
('What is the term for when the defense tackles the quarterback behind the line of scrimmage?', 'Blitz', 'Sack', 'Fumble', 'Interception', 'B', 'American Football'),
('Who has won the most Super Bowl MVP awards?', 'Tom Brady', 'Joe Montana', 'Terry Bradshaw', 'Eli Manning', 'A', 'American Football'),
('How many players are on the field per team in American football?', '9', '10', '11', '12', 'C', 'American Football'),
('What is a field goal worth in American football?', '1', '2', '3', '4', 'C', 'American Football'),
('Which quarterback has won the most Super Bowls?', 'Joe Montana', 'Tom Brady', 'Peyton Manning', 'Terry Bradshaw', 'B', 'American Football'),
('How many downs does a team get to advance 10 yards?', '3', '4', '5', '6', 'B', 'American Football'),
('What is the name of the trophy awarded to the Super Bowl winner?', 'Vince Lombardi Trophy', 'Commissioner Trophy', 'NFL Cup', 'Championship Trophy', 'A', 'American Football'),

-- BASEBALL
('How many innings are in a standard baseball game?', '7', '8', '9', '10', 'C', 'Baseball'),
('What is a perfect game in baseball?', 'No hits allowed', 'No runs allowed', 'No batter reaches base', 'Striking out all 27 batters', 'C', 'Baseball'),
('Which team has won the most World Series?', 'Boston Red Sox', 'LA Dodgers', 'New York Yankees', 'San Francisco Giants', 'C', 'Baseball'),
('How many strikes does a batter get before striking out?', '2', '3', '4', '5', 'B', 'Baseball'),
('What is the distance between bases in baseball?', '80 feet', '90 feet', '100 feet', '110 feet', 'B', 'Baseball'),

-- GOLF
('How many holes are played in a standard round of golf?', '9', '12', '18', '24', 'C', 'Golf'),
('What term describes completing a hole one stroke under par?', 'Eagle', 'Birdie', 'Bogey', 'Par', 'B', 'Golf'),
('Who has won the most major golf championships?', 'Tiger Woods', 'Jack Nicklaus', 'Arnold Palmer', 'Gary Player', 'B', 'Golf'),
('Which major golf tournament is played at Augusta National?', 'US Open', 'The Open Championship', 'The Masters', 'PGA Championship', 'C', 'Golf'),
('What does the term "bogey" mean in golf?', 'One under par', 'One over par', 'Two under par', 'Two over par', 'B', 'Golf'),
('How many dimples are on a standard golf ball?', '236', '312', '336', '392', 'C', 'Golf'),
('What is a hole-in-one also called?', 'Eagle', 'Condor', 'Ace', 'Birdie', 'C', 'Golf'),
('Who won the most Masters titles?', 'Tiger Woods', 'Jack Nicklaus', 'Arnold Palmer', 'Phil Mickelson', 'B', 'Golf'),

-- SWIMMING
('Who is the most decorated Olympian of all time?', 'Mark Spitz', 'Ian Thorpe', 'Michael Phelps', 'Ryan Lochte', 'C', 'Swimming'),
('How many gold medals did Michael Phelps win in the 2008 Beijing Olympics?', '6', '7', '8', '9', 'C', 'Swimming'),
('Which swimming stroke is the fastest?', 'Breaststroke', 'Butterfly', 'Backstroke', 'Freestyle', 'D', 'Swimming'),
('How long is an Olympic swimming pool?', '25 meters', '50 meters', '75 meters', '100 meters', 'B', 'Swimming'),
('How many swimming strokes are used in an individual medley?', '2', '3', '4', '5', 'C', 'Swimming'),

-- BOXING
('Who is known as "The Greatest" in boxing?', 'Mike Tyson', 'Muhammad Ali', 'Joe Louis', 'Sugar Ray Leonard', 'B', 'Boxing'),
('How many rounds are in a standard world championship boxing match?', '10', '12', '15', '20', 'B', 'Boxing'),
('Who defeated Muhammad Ali in the "Fight of the Century"?', 'George Foreman', 'Joe Frazier', 'Ken Norton', 'Sonny Liston', 'B', 'Boxing'),
('What weight class is above heavyweight in boxing?', 'There is none', 'Super heavyweight', 'Cruiserweight', 'Ultra heavyweight', 'A', 'Boxing'),
('Which boxer was nicknamed "Iron Mike"?', 'Muhammad Ali', 'Joe Frazier', 'Mike Tyson', 'Evander Holyfield', 'C', 'Boxing'),

-- ATHLETICS
('Who holds the world record for the 100m sprint?', 'Carl Lewis', 'Usain Bolt', 'Justin Gatlin', 'Asafa Powell', 'B', 'Athletics'),
('What is the distance of a marathon?', '40km', '41.2km', '42.195km', '43km', 'C', 'Athletics'),
('Who won four gold medals at the 1936 Berlin Olympics?', 'Jesse Owens', 'Carl Lewis', 'Jim Thorpe', 'Bob Beamon', 'A', 'Athletics'),
('What is the world record for the 100m sprint set by Usain Bolt?', '9.56s', '9.58s', '9.63s', '9.69s', 'B', 'Athletics'),
('In which event did Bob Beamon set a legendary world record at the 1968 Olympics?', 'High Jump', 'Triple Jump', 'Long Jump', 'Pole Vault', 'C', 'Athletics'),

-- CYCLING
('Which race is known as "La Grande Boucle"?', 'Giro d''Italia', 'Tour de France', 'Vuelta a España', 'Paris-Roubaix', 'B', 'Cycling'),
('Who won the most Tour de France titles?', 'Lance Armstrong (stripped)', 'Bernard Hinault', 'Eddy Merckx', 'Chris Froome', 'C', 'Cycling'),
('How many stages are in a typical Tour de France?', '15', '18', '21', '25', 'C', 'Cycling'),
('What is the yellow jersey in the Tour de France awarded for?', 'Best climber', 'Overall leader', 'Best sprinter', 'Most aggressive rider', 'B', 'Cycling'),
('Which country does cycling legend Eddy Merckx come from?', 'France', 'Netherlands', 'Belgium', 'Italy', 'C', 'Cycling'),

-- RUGBY
('How many players are in a rugby union team?', '13', '14', '15', '16', 'C', 'Rugby'),
('Which country has won the most Rugby World Cups?', 'Australia', 'South Africa', 'New Zealand', 'England', 'C', 'Rugby'),
('How many points is a try worth in rugby union?', '3', '4', '5', '6', 'C', 'Rugby'),
('What is the name of the New Zealand rugby team?', 'Springboks', 'Wallabies', 'All Blacks', 'Lions', 'C', 'Rugby'),
('Where was the first Rugby World Cup held in 1987?', 'England', 'Australia & New Zealand', 'South Africa', 'France', 'B', 'Rugby'),

-- HOCKEY
('Which country has won the most Olympic field hockey gold medals?', 'Pakistan', 'India', 'Netherlands', 'Australia', 'B', 'Hockey'),
('How many players are on a field hockey team on the pitch?', '9', '10', '11', '12', 'C', 'Hockey'),
('Which NHL team has won the most Stanley Cups?', 'Toronto Maple Leafs', 'Detroit Red Wings', 'Montreal Canadiens', 'Chicago Blackhawks', 'C', 'Hockey'),
('How long is a period in NHL hockey?', '15 minutes', '20 minutes', '25 minutes', '30 minutes', 'B', 'Hockey'),
('What is a hat trick in hockey?', 'Three assists', 'Three goals by one player', 'Three penalties', 'Three saves', 'B', 'Hockey'),

-- VOLLEYBALL
('How many players are on a volleyball team on the court?', '5', '6', '7', '8', 'B', 'Volleyball'),
('How many sets are played in a volleyball match (best of)?', '3', '4', '5', '6', 'C', 'Volleyball'),
('Which country has won the most Olympic volleyball gold medals (men)?', 'Brazil', 'USA', 'Russia/USSR', 'Italy', 'C', 'Volleyball'),
('How many touches is each team allowed per side in volleyball?', '2', '3', '4', '5', 'B', 'Volleyball'),
('What is the term for a serve that results in a point directly?', 'Ace', 'Spike', 'Kill', 'Block', 'A', 'Volleyball'),

-- GENERAL SPORTS
('Which sport uses a shuttlecock?', 'Squash', 'Badminton', 'Racquetball', 'Pickleball', 'B', 'General Sports'),
('What is the national sport of Canada?', 'Ice Hockey', 'Lacrosse', 'Both Ice Hockey and Lacrosse', 'Basketball', 'C', 'General Sports'),
('In which sport would you perform a slam dunk?', 'Volleyball', 'Basketball', 'Handball', 'Water polo', 'B', 'General Sports'),
('Which sport is played at Wimbledon?', 'Golf', 'Cricket', 'Tennis', 'Squash', 'C', 'General Sports'),
('What is the highest governing body of world football?', 'UEFA', 'FIFA', 'IOC', 'CONCACAF', 'B', 'General Sports'),
('In which sport do competitors perform a "vault"?', 'Swimming', 'Athletics', 'Gymnastics', 'Diving', 'C', 'General Sports'),
('What sport does Tiger Woods play?', 'Tennis', 'Golf', 'Baseball', 'Cricket', 'B', 'General Sports'),
('Which country invented the sport of sumo wrestling?', 'China', 'Korea', 'Japan', 'Mongolia', 'C', 'General Sports'),
('What does "LBW" stand for in cricket?', 'Left Behind Wicket', 'Leg Before Wicket', 'Long Ball Wide', 'Late Batting Window', 'B', 'General Sports'),
('In which sport is the "Ryder Cup" contested?', 'Tennis', 'Golf', 'Cricket', 'Rugby', 'B', 'General Sports'),
('Which country has hosted the Summer Olympics the most times?', 'France', 'USA', 'UK', 'Germany', 'B', 'General Sports'),
('What is the diameter of a basketball hoop in inches?', '16 inches', '18 inches', '20 inches', '22 inches', 'B', 'General Sports'),
('In which sport is a "birdie" a good score?', 'Tennis', 'Badminton', 'Golf', 'Cricket', 'C', 'General Sports'),
('How many events are in a decathlon?', '8', '9', '10', '12', 'C', 'General Sports'),
('Which sport has the highest paid athletes on average?', 'Football', 'Basketball', 'Baseball', 'Golf', 'A', 'General Sports');
