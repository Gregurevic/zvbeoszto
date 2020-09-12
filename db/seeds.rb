courses = [
  [ "3D grafikus rendszerek", "BMEVIIIAC01" ],
  [ "Adatvezérelt alkalmazások fejlesztése", "BMEVIAUA369" ],
  [ "Adatvezérelt rendszerek", "BMEVIAUAC01" ],
  [ "Alkalmazásfejlesztési környezetek", "BMEVIAUAC04" ],
  [ "Informatikai rendszertervezés", "BMEVIMIAC01" ],
  [ "Integrációs és ellenőrzési technikák", "BMEVIMIAC04" ],
  [ "Intelligens rendszerfelügyelet", "BMEVIMIA370" ],
  [ "Kliensoldali technológiák", "BMEVIAUAC02" ],
  [ "Kooperatív és tanuló rendszerek", "BMEVIMIA357" ],
  [ "Mobil infokommunikációs rendszerek", "BMEVIHIA317" ],
  [ "Objektumorientált szoftvertervezés", "BMEVIIIAC00" ],
  [ "Objektumorientált szoftvertervezés", "BMEVIIIA371" ]
]

courses.each do |name, neptun|
  Course.create( name: name, neptun: neptun )
end

instructors = [
  [ "Ács Judit", "N3P7UN", false, false, false ],
  [ "Albert István", "N3P7UN", false, false, false ],
  [ "Asztalos Márk", "N3P7UN", false, true, false ],
  [ "Benedek Zoltán", "N3P7UN", false, false, false ],
  [ "Blázovics László", "N3P7UN", false, true, false ],
  [ "Braun Patrik János", "N3P7UN", false, false, true ],
  [ "Budai Ádám", "N3P7UN", false, false, true ],
  [ "Charaf Hassan", "N3P7UN", true, false, false ],
  [ "Cserkúti Péter", "N3P7UN", false, false, false ],
  [ "Csorba Kristóf", "N3P7UN", false, true, false ],
  [ "Dudás Ákos", "N3P7UN", false, true, false ],
  [ "Dunaev Dmitriy", "N3P7UN", false, false, false ],
  [ "Ekler Péter", "N3P7UN", false, true, false ],
  [ "Fekete Tamás", "N3P7UN", false, false, true ],
  [ "Forstner Bertalan", "N3P7UN", true, false, false ],
  [ "Lengyel László", "N3P7UN", true, false, false ],
  [ "Gazdi László", "N3P7UN", false, false, true ],
  [ "Hideg Attila", "N3P7UN", false, false, true ],
  [ "Imre Gábor", "N3P7UN", false, false, false ],
  [ "Iváncsy Szabolcs", "N3P7UN", false, true, false ],
  [ "Jánoky László Viktor", "N3P7UN", false, false, true ],
  [ "Kovács Tibor", "N3P7UN", false, true, false ],
  [ "Kővári Bence András", "N3P7UN", false, true, false ],
  [ "Kövesdán Gábor", "N3P7UN", false, false, false ],
  [ "Kundra László János", "N3P7UN", false, false, false ],
  [ "Vajk István", "N3P7UN", true, false, false ],
  [ "Mezei Gergely", "N3P7UN", false, true, false ],
  [ "Pomázi Krisztián", "N3P7UN", false, false, true ],
  [ "Rajacsics Tamás", "N3P7UN", false, false, false ],
  [ "Recski Gábor András", "N3P7UN", false, true, false ],
  [ "Simon Gábor", "N3P7UN", false, false, false ],
  [ "Sipos Márton Ákos", "N3P7UN", false, false, false ],
  [ "Somogyi Ferenc Attila", "N3P7UN", false, false, true ],
  [ "Szabó Gábor", "N3P7UN", false, false, false ],
  [ "Tóth Tibor", "N3P7UN", false, false, false ],
  [ "Tömösközi Máté Ferenc", "N3P7UN", false, false, true ],
  [ "Szécsi László", "N3P7UN", false, false, false ],
  [ "Gincsai Gábor", "N3P7UN", false, false, false ],
  [ "Bányász Gábor", "N3P7UN", false, false, false ],
  [ "Filep Szabolcs", "N3P7UN", false, false, false ],
  [ "Micskei Zoltán Imre", "N3P7UN", false, false, false ],
  [ "Strausz György", "N3P7UN", false, false, false ],
  [ "Horváth Gábor", "N3P7UN", false, false, false ],
  [ "Goldschmidt Balázs", "N3P7UN", false, false, false ],
  [ "Hamar János Krisztián", "N3P7UN", false, false, false ],
  [ "Kökényesi Tamás", "N3P7UN", false, false, false ],
  [ "Kis-Nagy Dániel Dávid", "N3P7UN", false, false, false ],
  [ "Fazekas Péter", "N3P7UN", false, false, false ]
]

instructors.each do |name, neptun, can_be_president, can_be_member, can_be_secretary|
  Course.create( name: name,
  	             neptun: ("a".."z").to_a.concat( (0..9).to_a ).shuffle[0..5].join.upcase,
  	             can_be_president: can_be_president,
  	             can_be_secretary: can_be_secretary,
  	             can_be_member: can_be_member )
end

students = [
  [ "", "", "", "" ],
]