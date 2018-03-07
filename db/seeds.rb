shows = [
  ['Planet Earth II', 2016],
  ['Band of Brothers', 2001],
  ['Planet Earth', 2006],
  ['Game of Thrones', 2011],
  ['Breaking Bad', 2008],
  ['Blue Planet II', 2017],
  ['The Wire', 2002],
  ['Rick and Morty', 2013],
  ['Cosmos: A Spacetime Odyssey', 2014],
  ['Cosmos', 1980],
  ['The World at War', 1973],
  ['The Sopranos', 1999],
  ['Avatar: The Last Airbender', 2003],
  ['Life', 2009],
  ['Sherlock', 2010],
  ['Human Planet', 2011],
  ['The Civil War', 1990],
  ['The Twilight Zone', 1959],
  ['Dekalog', 1989],
  ['Firefly', 2002],
  ['True Detective', 2014],
  ['Hagane no renkinjutsushi', 2009],
  ['Last Week Tonight with John Oliver', 2014],
  ['Fargo', 2014],
  ['Batman: The Animated Series', 1992],
  ['Death Note: Desu nôto', 2006],
  ['The Blue Planet', 2001],
  ['Frozen Planet', 2011],
  ['Cowboy Bebop', 1998],
  ['Das Boot', 1985],
  ['One Punch Man: Wanpanman', 2015],
  ['Africa', 2013],
  ['Pride and Prejudice', 1995],
  ['Black Mirror', 2011],
  ['Stranger Things', 2016],
  ['Westworld', 2016],
  ['Arrested Development', 2003],
  ['House of Cards', 2013],
  ['Friends', 1994],
  ['Seinfeld', 1989],
  ['Only Fools and Horses....', 1981],
  ['Over the Garden Wall', 2014],
  ['Twin Peaks', 1990],
  ['TVF Pitchers', 2015],
  ['Narcos', 2015],
  ['Freaks and Geeks', 1999],
  ['I, Claudius', 1976],
  ['Gravity Falls', 2012],
  ['Fawlty Towers', 1975],
  ['Blackadder Goes Forth', 1989],
  ['Rome', 2005],
  ['Oz', 1997],
  ['Peaky Blinders', 2013],
  ['The Office', 2005],
  ['The Simpsons', 1989],
  ['South Park', 1997],
  ['Attack on Titan', 2013],
  ['The Marvelous Mrs. Maisel', 2017]
]

shows.each do |e|
  show, year = e
  Show.create(name: show, year: year)
end

users = %w[
  Roger
  StoneGuy
  BridgeMan
  Lebron4Ever
  RoboTruck
  DailyNews
  WaterfallPerson
  MysticBick
  ContentiousKid
  DapperMouth
  DrCool
  WinterStorm
  OhRyo
]

users.each do |e|
  user = User.create(username: e, email: "test@email.com", password: 'test')
  num_shows = rand(1..10)
  num_shows.times do
    user.shows << Show.find(rand(1..58))
  end
  user.save
end