import random
import itertools
import string
import datetime

# Constants
MAX_RESEARCHERS = 1000
MAX_BLACK_HOLES = 7500
MAX_GALAXIES = 80
MAX_TELESCOPES = 50
MAX_PHENOMENA = 6
database_name = ""  # Enter your database name here
NUMBER_OF_OBSERVATIONS = 0

# Function to get user input with constraints
def get_user_input(prompt, max_value):
    while True:
        try:
            value = int(input(f"{prompt} (max {max_value}): "))
            if 1 <= value <= max_value:
                return value
            else:
                print(f"Please enter a number between 1 and {max_value}.")
        except ValueError:
            print("Invalid input. Please enter a valid number.")

# Get user inputs
NUM_RESEARCHERS = get_user_input("Enter the number of researchers", MAX_RESEARCHERS)
NUM_BLACK_HOLES = get_user_input("Enter the number of black holes", MAX_BLACK_HOLES)
NUM_GALAXIES = get_user_input("Enter the number of galaxies", MAX_GALAXIES)
NUM_TELESCOPES = get_user_input("Enter the number of telescopes", MAX_TELESCOPES)
NUM_PHENOMENA = get_user_input("Enter the number of phenomena", MAX_PHENOMENA)
NUM_PHENOMENA_ASSIGNMENTS = get_user_input("Enter the number of phenomena assignments to black holes", NUM_BLACK_HOLES * NUM_PHENOMENA)
database_name = input("Enter your database name: ")

# Function to generate researchers
def generate_researchers():
    first_names = ["Adam", "Barbara", "Cezary", "Dorota", "Edward", "Felicja", "Grzegorz", "Hanna", "Ireneusz", "Julia", "Krzysztof", "Magdalena", "Łukasz", "Natalia", "Paweł", "Olga", "Rafał", "Sylwia", "Tomasz", "Zofia", "Michał", "Alicja", "Sebastian", "Ewa", "Andrzej", "Joanna", "Marek", "Karolina", "Wojciech", "Patrycja"]
    last_names_male = ["Kowalski", "Nowak", "Wiśniewski", "Wójcik", "Kamiński", "Lewandowski", "Zieliński", "Szymański", "Dąbrowski", "Górski", "Mazur", "Kaczmarek", "Piotrowski", "Grabowski", "Zając", "Król", "Jabłoński", "Wieczorek", "Wilk", "Sikora", "Baran", "Rutkowski", "Szewczyk", "Lis", "Makowski"]
    last_names_female = ["Kowalska", "Nowak", "Wiśniewska", "Wójcik", "Kamińska", "Lewandowska", "Zielińska", "Szymańska", "Dąbrowska", "Górska", "Mazur", "Kaczmarek", "Piotrowska", "Grabowska", "Zając", "Król", "Jabłońska", "Wieczorek", "Wilk", "Sikora", "Baran", "Rutkowska", "Szewczyk", "Lis", "Makowska"]
    agencies = ['NASA', 'ESA', 'ISRO', 'CSA']

    unique_combinations = []
    for first_name in first_names:
        last_names = last_names_female if first_name[-1] == 'a' and first_name not in ["Kuba"] else last_names_male
        unique_combinations.extend(itertools.product([first_name], last_names))

    random.shuffle(unique_combinations)

    values = []
    for _ in range(NUM_RESEARCHERS):
        first_name, last_name = random.choice(unique_combinations)
        agency = random.choice(agencies)
        values.append(f"('{first_name}', '{last_name}', '{agency}')")

    insert_statement = f"INSERT INTO badacze (imie, nazwisko, instytucja) VALUES {', '.join(values)};"
    return insert_statement

researchers_inserts = generate_researchers()

# Function to generate black holes
def generate_black_holes():
    black_hole_names = [
        "Cygnus X-1", "Sagittarius A*", "M87*", "TON 618", "NGC 4889", "V404 Cygni", "GRO J1655-40", "GX 339-4",
        "3C 273", "PKS 0521-36", "Ophiuchus X-1", "IC 310", "PKS 0745-191", "NGC 1277", "NGC 1600", "NGC 3842",
        "Abell 1201", "SDSS J0100+2802", "Holm 15A", "S5 0014+81"
    ]

    def generate_random_name():
        prefix = ''.join(random.choices(string.ascii_uppercase, k=3))
        suffix = random.randint(1000, 9999)
        return f"{prefix} {suffix}"

    black_hole_names.extend(generate_random_name() for _ in range(5000))

    black_hole_types = ["gwiazdowe", "supermasywne", "pierwotne"]

    unique_entries = set()
    while len(unique_entries) < NUM_BLACK_HOLES:
        name = random.choice(black_hole_names)
        mass = round(random.uniform(5, 1000000), 3)
        bh_type = random.choice(black_hole_types)
        distance = round(random.uniform(0.1, 13000), 3)
        entry = (name, mass, bh_type, distance)
        unique_entries.add(entry)

    values = [
        f"('{name}', {mass}, '{bh_type}', {distance})"
        for name, mass, bh_type, distance in unique_entries
    ]

    insert_statement = f"INSERT INTO czarnedziury (nazwa, masa, typ, odleglosc_od_ziemi) VALUES {', '.join(values)};"
    return insert_statement

black_holes_inserts = generate_black_holes()

# Function to generate galaxies
def generate_galaxies():
    galaxy_names = [
        "Andromeda", "Whirlpool", "Sombrero", "Triangulum", "Pinwheel", "Black Eye", "Cigar", "Sunflower",
        "Cartwheel", "Centaurus A", "Bodes Galaxy", "Tadpole", "Butterfly", "Fireworks", "Hoags Object",
        "Medusa Merger", "Needle", "Sculptor", "Leo Triplet", "Virgo A", "Messier 81", "Messier 82",
        "Messier 87", "Messier 104", "Messier 106", "Messier 110", "Messier 51", "Messier 63", "Messier 64",
        "Messier 74", "Messier 83", "Messier 94", "Messier 95", "Messier 96", "Messier 101", "Messier 108",
        "Messier 109", "Messier 65", "Messier 66", "Messier 77", "Messier 88", "Messier 91", "Messier 98",
        "Messier 99", "Messier 100", "Messier 102", "Messier 105", "Messier 107", "Messier 49", "Messier 58",
        "Messier 59", "Messier 60", "Messier 61", "Messier 62", "Messier 67", "Messier 68", "Messier 69",
        "Messier 70", "Messier 71", "Messier 72", "Messier 73", "Messier 75", "Messier 76", "Messier 78",
        "Messier 79", "Messier 80", "Messier 84", "Messier 85", "Messier 86", "Messier 89", "Messier 90",
        "Messier 92", "Messier 93", "Messier 97", "Messier 103", "Messier 111", "Messier 112", "Messier 113",
        "Messier 114", "Messier 115", "Messier 116", "Messier 117", "Messier 118", "Messier 119", "Messier 120",
        "Messier 121", "Messier 122", "Messier 123", "Messier 124", "Messier 125", "Messier 126", "Messier 127"
    ]

    ngc_numbers = random.sample(range(1, 8000), len(galaxy_names))
    unique_galaxies = set(zip(galaxy_names, ngc_numbers))
    unique_galaxies = list(unique_galaxies)[:NUM_GALAXIES]

    values = [
        f"('{name}', {ngc})"
        for name, ngc in unique_galaxies
    ]

    insert_statement = f"INSERT INTO galaktyki (nazwa, numer_katalogowy_ngc) VALUES {', '.join(values)};"
    return insert_statement

galaxies_inserts = generate_galaxies()

# Function to generate telescopes
def generate_telescopes():
    telescope_names = [
        "Hubble", "James Webb", "Kepler", "Chandra", "Spitzer", "Gaia", "TESS", "Euclid", "Swift", "XMM-Newton",
        "ALMA", "VLT", "Keck", "Gemini", "Arecibo", "FAST", "LOFAR", "MeerKAT", "Green Bank", "LIGO"
    ]

    telescope_types = ["naziemny", "kosmiczny"]

    unique_entries = set()
    while len(unique_entries) < NUM_TELESCOPES:
        name = random.choice(telescope_names)
        t_type = random.choice(telescope_types)
        in_use = random.choice([1, 0])
        entry = (name, t_type, in_use)
        unique_entries.add(entry)

    values = [
        f"('{name}', '{t_type}', {in_use})"
        for name, t_type, in_use in unique_entries
    ]

    insert_statement = f"INSERT INTO teleskopy (nazwa, typ, czy_w_uzyciu) VALUES {', '.join(values)};"
    return insert_statement

telescopes_inserts = generate_telescopes()

# Function to generate observations
def generate_observations():
    id_czarnej_dziury = list(range(1, NUM_BLACK_HOLES + 1))
    id_teleskopu = list(range(1, NUM_TELESCOPES + 1))
    zakresy_promieniowania = ['rentgenowskie', 'radiowe', 'hawkinga', 'gamma']
    min_data = datetime.datetime(2000, 1, 1)
    max_data = datetime.datetime(2023, 12, 31)

    def generuj_date():
        delta = max_data - min_data
        losowe_dni = random.randint(0, delta.days)
        return min_data + datetime.timedelta(days=losowe_dni)
    
    global NUMBER_OF_OBSERVATIONS

    values = []
    for id_czarna_dziura in id_czarnej_dziury:
        for _ in range(random.randint(2, 3)):
            data = generuj_date()
            teleskop = random.choice(id_teleskopu)
            zakres = random.choice(zakresy_promieniowania)
            values.append(f"({id_czarna_dziura}, '{data.strftime('%Y-%m-%d')}', {teleskop}, '{zakres}')")
            NUMBER_OF_OBSERVATIONS += 1
            

    insert_statement = f"INSERT INTO obserwacje (Id_czarnej_dziury, data_obserwacji, Id_teleskopu, zakres_promieniowania) VALUES {', '.join(values)};"
    return insert_statement

observations_inserts = generate_observations()

# Function to generate researcher observations
def generate_researcher_observations():
    observation_ids = list(range(1, NUMBER_OF_OBSERVATIONS + 1))
    random.shuffle(observation_ids)
    success_values = ['y', 'n']

    values = []
    for observation_id in observation_ids:
        researcher_id = random.randint(1, NUM_RESEARCHERS)
        success = random.choice(success_values)
        values.append(f"({observation_id}, {researcher_id}, '{success}')")

    insert_statement = f"INSERT INTO badacze_obserwacje (Id_obserwacji, Id_badacza, `czy_udane(y/n)`) VALUES {', '.join(values)};"
    return insert_statement

researcher_observations_inserts = generate_researcher_observations()

# Function to generate black hole phenomena
def generate_black_hole_phenomena():
    black_hole_ids = random.sample(range(1, NUM_BLACK_HOLES + 1), NUM_BLACK_HOLES)

    def random_timestamp(start_year=2000, end_year=2025):
        start_date = datetime.datetime(start_year, 1, 1, 0, 0, 0)
        end_date = datetime.datetime(end_year, 12, 31, 23, 59, 59)
        delta = end_date - start_date
        random_seconds = random.randint(0, int(delta.total_seconds()))
        return (start_date + datetime.timedelta(seconds=random_seconds)).strftime('%Y-%m-%d %H:%M:%S')

    values = []
    for _ in range(NUM_PHENOMENA_ASSIGNMENTS):
        black_hole_id = random.choice(black_hole_ids)
        phenomenon_id = random.randint(1, NUM_PHENOMENA)
        event_timestamp = random_timestamp()
        values.append(f"({phenomenon_id}, {black_hole_id}, '{event_timestamp}')")

    insert_statement = f"INSERT INTO czarnedziury_zjawiska (Id_zjawiska, Id_czarnejdziury, data_zjawiska) VALUES {', '.join(values)};"
    return insert_statement

black_hole_phenomena_inserts = generate_black_hole_phenomena()

# Function to generate locations
def generate_locations():
    black_hole_ids = list(range(1, NUM_BLACK_HOLES + 1))
    random.shuffle(black_hole_ids)

    values = []
    for black_hole_id in black_hole_ids:
        galaxy_id = random.randint(1, NUM_GALAXIES)
        ra = round(random.uniform(0, 360), 3)
        dec = round(random.uniform(-90, 90), 3)
        values.append(f"({black_hole_id}, {galaxy_id}, {ra}, {dec})")

    insert_statement = f"INSERT INTO lokalizacje (Id_czarnej_dziury, Id_galaktyki, wspolrzedne_RA, wspolrzedne_DEC) VALUES {', '.join(values)};"
    return insert_statement

locations_inserts = generate_locations()

# Write all inserts to a single file
with open("all_inserts.sql", "w", encoding="utf-8") as file:
    file.write("USE " + database_name + ";\n")
    file.write(researchers_inserts + "\n")
    file.write(black_holes_inserts + "\n")
    file.write(galaxies_inserts + "\n")
    file.write(telescopes_inserts + "\n")
    file.write(observations_inserts + "\n")
    file.write(researcher_observations_inserts + "\n")
    file.write(black_hole_phenomena_inserts + "\n")
    file.write(locations_inserts + "\n")

print("All insert statements have been generated and written to all_inserts.sql")