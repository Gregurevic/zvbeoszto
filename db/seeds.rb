#User data: Courses, Instructors and Students
#Associations: ExamCourse, Supervisor for Students

courses = {
  S00: { name: "3D grafikus rendszerek",                 neptun: "BMEVIIIAC01" },
  S01: { name: "Adatvezérelt alkalmazások fejlesztése",  neptun: "BMEVIAUA369" },
  S02: { name: "Adatvezérelt rendszerek",                neptun: "BMEVIAUAC01" },
  S03: { name: "Alkalmazásfejlesztési környezetek",      neptun: "BMEVIAUAC04" },
  S04: { name: "Informatikai rendszertervezés",          neptun: "BMEVIMIAC01" },
  S05: { name: "Integrációs és ellenőrzési technikák",   neptun: "BMEVIMIAC04" },
  S06: { name: "Intelligens rendszerfelügyelet",         neptun: "BMEVIMIA370" },
  S07: { name: "Kliensoldali technológiák",              neptun: "BMEVIAUAC02" },
  S08: { name: "Kooperatív és tanuló rendszerek",        neptun: "BMEVIMIA357" },
  S09: { name: "Mobil infokommunikációs rendszerek",     neptun: "BMEVIHIA317" },
  S10: { name: "Objektumorientált szoftvertervezés",     neptun: "BMEVIIIAC00" },
  S11: { name: "Objektumorientált szoftvertervezés",     neptun: "BMEVIIIA371" }
}

courses.each do |key, hash|
  Course.create( name: hash[:name], neptun: hash[:neptun] )
end

instructors = {
  I00: { name: "Ács Judit",              can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I01: { name: "Albert István",          can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I02: { name: "Asztalos Márk",          can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I03: { name: "Benedek Zoltán",         can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I04: { name: "Blázovics László",       can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I05: { name: "Braun Patrik János",     can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I06: { name: "Budai Ádám",             can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I07: { name: "Charaf Hassan",          can_be_president: true,   can_be_member: false,  can_be_secretary: false  },
  I08: { name: "Cserkúti Péter",         can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I09: { name: "Csorba Kristóf",         can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I10: { name: "Dudás Ákos",             can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I11: { name: "Dunaev Dmitriy",         can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I12: { name: "Ekler Péter",            can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I13: { name: "Fekete Tamás",           can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I14: { name: "Forstner Bertalan",      can_be_president: true,   can_be_member: false,  can_be_secretary: false  },
  I15: { name: "Lengyel László",         can_be_president: true,   can_be_member: false,  can_be_secretary: false  },
  I16: { name: "Gazdi László",           can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I17: { name: "Hideg Attila",           can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I18: { name: "Imre Gábor",             can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I19: { name: "Iváncsy Szabolcs",       can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I20: { name: "Jánoky László Viktor",   can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I21: { name: "Kovács Tibor",           can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I22: { name: "Kővári Bence András",    can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I23: { name: "Kövesdán Gábor",         can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I24: { name: "Kundra László János",    can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I25: { name: "Vajk István",            can_be_president: true,   can_be_member: false,  can_be_secretary: false  },
  I26: { name: "Mezei Gergely",          can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I27: { name: "Pomázi Krisztián",       can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I28: { name: "Rajacsics Tamás",        can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I29: { name: "Recski Gábor András",    can_be_president: false,  can_be_member: true,   can_be_secretary: false  },
  I30: { name: "Simon Gábor",            can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I31: { name: "Sipos Márton Ákos",      can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I32: { name: "Somogyi Ferenc Attila",  can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I33: { name: "Szabó Gábor",            can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I34: { name: "Tóth Tibor",             can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I35: { name: "Tömösközi Máté Ferenc",  can_be_president: false,  can_be_member: false,  can_be_secretary: true   },
  I36: { name: "Szécsi László",          can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I37: { name: "Gincsai Gábor",          can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I38: { name: "Bányász Gábor",          can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I39: { name: "Filep Szabolcs",         can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I40: { name: "Micskei Zoltán Imre",    can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I41: { name: "Strausz György",         can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I42: { name: "Horváth Gábor",          can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I43: { name: "Goldschmidt Balázs",     can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I44: { name: "Hamar János Krisztián",  can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I45: { name: "Kökényesi Tamás",        can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I46: { name: "Kis-Nagy Dániel Dávid",  can_be_president: false,  can_be_member: false,  can_be_secretary: false  },
  I47: { name: "Fazekas Péter",          can_be_president: false,  can_be_member: false,  can_be_secretary: false  }
}

instructors.each do |key, hash|
  Instructor.create(  name:              hash[:name],
                      email:             key.to_s + "@email.com",
  	                  can_be_president:  hash[:can_be_president],
  	                  can_be_secretary:  hash[:can_be_secretary],
  	                  can_be_member:     hash[:can_be_member] )
end

students = [
  [ "Andrási Bulcsú János",      "ZEZFCE", "Rajacsics Tamás",        "BMEVIIIAC01" ],
  [ "Antal Gábor",               "FC3E51", "Ekler Péter",            "BMEVIAUA369" ],
  [ "Arnócz László",             "PV8AK9", "Blázovics László",       "BMEVIAUAC01" ],
  [ "Beckl Gábor",               "WX7TPZ", "Gincsai Gábor",          "BMEVIAUA369" ],
  [ "Berta Balázs",              "BB6JQY", "Tóth Tibor",             "BMEVIAUAC02" ],
  [ "Bihary Gergely Sándor",     "DJY1FZ", "Ekler Péter",            "BMEVIAUAC02" ],
  [ "Blum Márton",               "N104LU", "Forstner Bertalan",      "BMEVIAUA369" ],
  [ "Bodor Norbert",             "CA25RQ", "Kővári Bence András",    "BMEVIAUAC02" ],
  [ "Bognár Márton József",      "OES1HB", "Blázovics László",       "BMEVIAUAC01" ],
  [ "Braun Márton Szabolcs",     "YJ8F2X", "Ekler Péter",            "BMEVIAUAC01" ],
  [ "Burján Viktor",             "MLTYU6", "Ács Judit",              "BMEVIAUAC04" ],
  [ "Czap Balázs",               "KUKYQ2", "Forstner Bertalan",      "BMEVIAUAC02" ],
  [ "Csányi Marcell Péter",      "FP9W6B", "Tóth Tibor",             "BMEVIAUAC04" ],
  [ "Cserna Balázs",             "MFIAU4", "Ács Judit",              "BMEVIIIAC00" ],
  [ "Csőre Antal Tamás",         "AR9EI8", "Dunaev Dmitriy",         "BMEVIAUA369" ],
  [ "Dávid Ádám",                "AO4S5C", "Ekler Péter",            "BMEVIAUAC02" ],
  [ "Déri Tamás",                "BAMRHY", "Szabó Gábor",            "BMEVIAUAC02" ],
  [ "Elek Dávid István",         "SI69U0", "Forstner Bertalan",      "BMEVIMIA370" ],
  [ "Élő Dénes Bence",           "LA7VEL", "Kővári Bence András",    "BMEVIMIAC01" ],
  [ "Erdős Szilvia",             "AE6QQJ", "Kővári Bence András",    "BMEVIAUAC02" ],
  [ "Falvai Olivér Benjámin",    "M1Y8AJ", "Forstner Bertalan",      "BMEVIAUAC02" ],
  [ "Farkas Gergő",              "EOW3AB", "Kővári Bence András",    "BMEVIAUA369" ],
  [ "Fodor Gábor Dániel",        "FQ0Y7K", "Forstner Bertalan",      "BMEVIAUAC02" ],
  [ "Gáspár Vilmos",             "GF4UZL", "Benedek Zoltán",         "BMEVIAUAC01" ],
  [ "Gyárfás Gábor",             "YOMPPI", "Tóth Tibor",             "BMEVIAUAC02" ],
  [ "György Tímea",              "FIAFO1", "Dudás Ákos",             "BMEVIAUAC01" ],
  [ "Győri Mihály",              "PFGIXS", "Csorba Kristóf",         "BMEVIAUA369" ],
  [ "Horváth Péter",             "VSRVMZ", "Rajacsics Tamás",        "BMEVIAUA369" ],
  [ "Huszti Dorottya",           "F9MLB3", "Ács Judit",              "BMEVIAUAC02" ],
  [ "Jáhn Erik",                 "AF1WZU", "Fekete Tamás",           "BMEVIAUAC01" ],
  [ "Jancsovics Tamás",          "DDIY6U", "Ekler Péter",            "BMEVIHIA317" ],
  [ "Jenei Máté",                "G1CH4I", "Benedek Zoltán",         "BMEVIAUAC02" ],
  [ "Jóna Kata",                 "IP1LXW", "Ekler Péter",            "BMEVIAUAC01" ],
  [ "Kálmán Bence",              "B06FMG", "Kővári Bence András",    "BMEVIAUAC01" ],
  [ "Karancsi Ádám",             "G1W3OD", "Kővári Bence András",    "BMEVIAUA369" ],
  [ "Károlyi Áron",              "FXXNGR", "Kővári Bence András",    "BMEVIAUA369" ],
  [ "Kiss Szabolcs",             "FGCUAP", "Tóth Tibor",             "BMEVIAUAC02" ],
  [ "Koleszár Patrik",           "TLCXYA", "Kővári Bence András",    "BMEVIAUAC01" ],
  [ "Kovács Bálint István",      "WP3OGO", "Ekler Péter",            "BMEVIAUAC01" ],
  [ "Kovács Benedek",            "HLWG0Q", "Blázovics László",       "BMEVIIIAC00" ],
  [ "Kovács Dániel",             "E0UTKP", "Szabó Gábor",            "BMEVIAUAC01" ],
  [ "Kovács Tibor",              "IS8IJS", "Simon Gábor",            "BMEVIAUAC01" ],
  [ "Kővári Balázs",             "TV071O", "Benedek Zoltán",         "BMEVIAUA369" ],
  [ "Kristály Márk",             "DTJ4Z0", "Ekler Péter",            "BMEVIAUA369" ],
  [ "Kulacs Péter",              "G5IJFF", "Gincsai Gábor",          "BMEVIAUAC02" ],
  [ "Kutasy Kitti",              "OVUMC2", "Csorba Kristóf",         "BMEVIAUAC04" ],
  [ "Lohonyai Bálint",           "JAB2F8", "Dudás Ákos",             "BMEVIAUA369" ],
  [ "Magyar Gábor István",       "VNQ45A", "Lengyel László",         "BMEVIIIAC00" ],
  [ "Mentler Dávid",             "E03FHG", "Kövesdán Gábor",         "BMEVIIIAC00" ],
  [ "Mihályi Balázs",            "LU8D88", "Kővári Bence András",    "BMEVIAUAC02" ],
  [ "Móczár Dávid",              "AGVNXV", "Simon Gábor",            "BMEVIAUAC01" ],
  [ "Müller Gergő Bence",        "GDL0HB", "Forstner Bertalan",      "BMEVIAUAC01" ],
  [ "Nagy Bence Zsigmond",       "A9PACJ", "Ekler Péter",            "BMEVIAUAC02" ],
  [ "Nagy Nikolett",             "CF70RC", "Ács Judit",              "BMEVIAUAC02" ],
  [ "Nagy Péter Géza",           "G2R7EV", "Ács Judit",              "BMEVIAUAC02" ],
  [ "Nagy Péter Szabolcs",       "ACD6T6", "Forstner Bertalan",      "BMEVIAUAC02" ],
  [ "Németh Gergely Dániel",     "C44ZM7", "Ács Judit",              "BMEVIMIAC01" ],
  [ "Palatinszky Dániel Gábor",  "DMEM3S", "Mezei Gergely",          "BMEVIAUAC02" ],
  [ "Páli Márton",               "Z2PWV9", "Tóth Tibor",             "BMEVIAUAC02" ],
  [ "Pap Edina",                 "XD9T9V", "Hideg Attila",           "BMEVIAUAC04" ],
  [ "Pápai Attila",              "X6YVJM", "Szabó Gábor",            "BMEVIIIA371" ],
  [ "Paróczi Gergő",             "O4ZDQ5", "Hamar János Krisztián",  "BMEVIAUAC04" ],
  [ "Perneky Virág",             "VZX4GR", "Kis-Nagy Dániel Dávid",  "BMEVIAUA369" ],
  [ "Pintér Benedek",            "WO892L", "Kővári Bence András",    "BMEVIAUAC02" ],
  [ "Princz Ákos",               "A3BC1G", "Simon Gábor",            "BMEVIIIAC00" ],
  [ "Rostás Balázs",             "C00P7Q", "Forstner Bertalan",      "BMEVIAUAC02" ],
  [ "Rottenhoffer Olivér",       "M9TEFT", "Imre Gábor",             "BMEVIAUAC02" ],
  [ "Stoica Márk",               "MPG13R", "Sipos Márton Ákos",      "BMEVIAUAC02" ],
  [ "Sümegi Márk",               "DVIFYV", "Kökényesi Tamás",        "BMEVIMIAC04" ],
  [ "Szabó András Gábor",        "MWQCI9", "Forstner Bertalan",      "BMEVIAUAC01" ],
  [ "Szabó Attila Dániel",       "U76H5P", "Ács Judit",              "BMEVIAUAC02" ],
  [ "Szabó Dóra",                "KFK3T0", "Gincsai Gábor",          "BMEVIAUAC02" ],
  [ "Szabo Zsombor-Tamás",       "MWT0KX", "Asztalos Márk",          "BMEVIAUA369" ],
  [ "Szántó Dávid Gergely",      "Y7L145", "Albert István",          "BMEVIAUAC02" ],
  [ "Szemán Bence",              "PT9H3E", "Imre Gábor",             "BMEVIAUAC04" ],
  [ "Szendi Tamás Pál",          "XEENOE", "Gincsai Gábor",          "BMEVIAUA369" ],
  [ "Szigeti Blanka",            "V8DGCO", "Csorba Kristóf",         "BMEVIAUAC04" ],
  [ "Szilágyi Norbert Renátó",   "AXFXRO", "Csorba Kristóf",         "BMEVIAUAC01" ],
  [ "Szlovák Máté Ákos",         "AG1UQU", "Blázovics László",       "BMEVIAUA369" ],
  [ "Szücs Cintia Lia",          "BOZQAN", "Kővári Bence András",    "BMEVIAUAC02" ],
  [ "Takács Gergő",              "E7FCHF", "Gazdi László",           "BMEVIAUAC04" ],
  [ "Takács Levente",            "PY82C7", "Hideg Attila",           "BMEVIAUAC01" ],
  [ "Takács Norbert",            "BR2LE6", "Forstner Bertalan",      "BMEVIAUAC02" ],
  [ "Tautz Szilveszter",         "AFGC8N", "Tóth Tibor",             "BMEVIAUAC04" ],
  [ "Temesvári Fanni",           "EIZUOZ", "Kővári Bence András",    "BMEVIAUAC02" ],
  [ "Tolnay Zoltán",             "CT65G8", "Mezei Gergely",          "BMEVIAUA369" ],
  [ "Tombor Dániel",             "RJ3KRA", "Forstner Bertalan",      "BMEVIMIA357" ],
  [ "Tóth Attila",               "X25EZO", "Szabó Gábor",            "BMEVIAUAC02" ],
  [ "Tóth Dániel",               "BCDP1Q", "Albert István",          "BMEVIAUA369" ],
  [ "Tóth Péter István",         "YS93EK", "Ekler Péter",            "BMEVIAUAC01" ],
  [ "Tömpe Boldizsár",           "AOVD7E", "Forstner Bertalan",      "BMEVIAUAC01" ],
  [ "Ujhelyi Benedek",           "BC4HFJ", "Blázovics László",       "BMEVIAUAC02" ],
  [ "Varga Péter Krisztián",     "HIXBYZ", "Dudás Ákos",             "BMEVIAUA369" ],
  [ "Végh Éva",                  "JN12LH", "Imre Gábor",             "BMEVIIIAC00" ],
  [ "Velez Krisztián",           "WFPTP9", "Ekler Péter",            "BMEVIAUAC01" ],
  [ "Veszner Dávid",             "U8UH4E", "Blázovics László",       "BMEVIAUA369" ],
  [ "Zaymus Gábor Mihály",       "DDUU2Y", "Benedek Zoltán",         "BMEVIAUAC02" ],
  [ "Zóka Dániel",               "Y7G3ZL", "Kövesdán Gábor",         "BMEVIAUAC01" ],
  [ "Zollai András",             "A5X7OI", "Cserkúti Péter",         "BMEVIAUAC02" ],
  [ "Zöld Máté",                 "GQH7FW", "Fekete Tamás",           "BMEVIAUAC01" ]
]

students.each do |name, neptun, supervisor, course_neptun|
  Student.create( name: name,
  	              neptun: neptun,
                  email: neptun.to_s + "@email.com",
                  instructor_id: Instructor.find_by(name: supervisor).id,
                  course_id: Course.find_by(neptun: course_neptun).id )
end

#Associations: Examiner

examiners = {
  E00: { course: "BMEVIIIAC01", instructor: "Szécsi László" },
  E01: { course: "BMEVIAUA369", instructor: "Dudás Ákos" },
  E02: { course: "BMEVIAUA369", instructor: "Gincsai Gábor" },
  E03: { course: "BMEVIAUA369", instructor: "Asztalos Márk" },
  E04: { course: "BMEVIAUA369", instructor: "Albert István" },
  E05: { course: "BMEVIAUA369", instructor: "Cserkúti Péter" },
  E06: { course: "BMEVIAUA369", instructor: "Benedek Zoltán" },
  E07: { course: "BMEVIAUAC01", instructor: "Dudás Ákos" },
  E08: { course: "BMEVIAUAC01", instructor: "Benedek Zoltán" },
  E09: { course: "BMEVIAUAC01", instructor: "Imre Gábor" },
  E10: { course: "BMEVIAUAC04", instructor: "Csorba Kristóf" },
  E11: { course: "BMEVIAUAC04", instructor: "Bányász Gábor" },
  E12: { course: "BMEVIAUAC04", instructor: "Filep Szabolcs" },
  E13: { course: "BMEVIMIAC01", instructor: "Micskei Zoltán Imre" },
  E14: { course: "BMEVIMIAC04", instructor: "Strausz György" },
  E15: { course: "BMEVIMIA370", instructor: "Micskei Zoltán Imre" },
  E16: { course: "BMEVIAUAC02", instructor: "Kővári Bence András" },
  E17: { course: "BMEVIMIA357", instructor: "Horváth Gábor" },
  E18: { course: "BMEVIHIA317", instructor: "Fazekas Péter" },
  E19: { course: "BMEVIIIAC00", instructor: "Goldschmidt Balázs" },
  E20: { course: "BMEVIIIA371", instructor: "Goldschmidt Balázs" }
}

examiners.each do |key, hash|
  Examiner.create(course_id: Course.find_by(neptun: hash[:course]).id, instructor_id: Instructor.find_by(name: hash[:instructor]).id )
end

#Actual user profiles: Admin, Instructor, Student
