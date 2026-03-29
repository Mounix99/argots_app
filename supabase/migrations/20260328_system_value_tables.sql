-- =============================================================================
-- System Value Lookup Tables
-- =============================================================================

-- ----------------------------------------------------------------------------
-- 1. soil_types
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS soil_types (
    id          SERIAL PRIMARY KEY,
    value       TEXT NOT NULL UNIQUE,
    label       TEXT NOT NULL,
    description TEXT,
    ph_min      DECIMAL(4, 2),
    ph_max      DECIMAL(4, 2),
    sort_order  INT NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO soil_types (value, label, description, ph_min, ph_max, sort_order) VALUES
    ('sandy',       'Sandy',                'Light, well-drained soil that warms up quickly in spring. Low in nutrients and organic matter.',                5.5, 7.0, 1),
    ('sandy_loam',  'Sandy Loam',           'Good drainage with moderate nutrient retention. Easy to work and suitable for many crops.',                     6.0, 7.0, 2),
    ('clay',        'Clay',                 'Heavy soil that retains moisture and nutrients well. Prone to waterlogging and can be difficult to work.',        6.0, 7.5, 3),
    ('loamy',       'Loamy',                'Ideal balanced mix of sand, silt, and clay. Excellent drainage, nutrient retention, and workability.',           6.0, 7.0, 4),
    ('calcareous',  'Calcareous',           'Chalky, alkaline and free-draining soil. Shallow depth with underlying limestone or chalk.',                     7.0, 8.5, 5),
    ('peaty',       'Peaty',                'Acidic soil with high organic matter content. Retains moisture very well, found in boggy areas.',               3.5, 5.5, 6),
    ('black_soil',  'Black Soil (Chernozem)', 'Very fertile, dark soil rich in humus. Common in Eastern Europe and prized for crop production.',             6.5, 7.5, 7),
    ('other',       'Other',                'Custom or unclassified soil type. Use when none of the predefined categories apply.',                           NULL, NULL, 8);

-- ----------------------------------------------------------------------------
-- 2. plant_types
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS plant_types (
    id          SERIAL PRIMARY KEY,
    value       TEXT NOT NULL UNIQUE,
    label       TEXT NOT NULL,
    description TEXT,
    sort_order  INT NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO plant_types (value, label, description, sort_order) VALUES
    ('trees',              'Trees',               'Woody perennial plants with a single main trunk and a distinct crown of branches.',                        1),
    ('shrubs',             'Shrubs',              'Woody plants smaller than trees, with multiple stems growing from the base.',                              2),
    ('vines',              'Vines',               'Climbing or trailing plants that use other structures for support.',                                       3),
    ('grasses',            'Grasses',             'Grass-like plants of the family Poaceae, including cereals and lawn grasses.',                             4),
    ('ferns',              'Ferns',               'Vascular plants that reproduce via spores. Prefer shaded, moist environments.',                            5),
    ('mosses',             'Mosses',              'Small, non-vascular flowerless plants. Thrive in damp, shaded conditions.',                               6),
    ('algae',              'Algae',               'Aquatic photosynthetic organisms ranging from single-celled to large seaweeds.',                           7),
    ('lichens',            'Lichens',             'Composite organisms from algae or cyanobacteria living among fungi. Grow on rocks and bark.',              8),
    ('succulents',         'Succulents',          'Plants with thick, fleshy parts adapted to store water. Suited to arid conditions.',                       9),
    ('aquatic_plants',     'Aquatic Plants',      'Plants that grow in or near water, fully or partially submerged.',                                        10),
    ('epiphytes',          'Epiphytes',           'Plants that grow on other plants for physical support, not parasitically.',                               11),
    ('annuals',            'Annuals',             'Plants that complete their life cycle in one growing season.',                                            12),
    ('biennials',          'Biennials',           'Plants that take two years to complete their life cycle.',                                                13),
    ('perennials',         'Perennials',          'Plants that live for more than two years, often dying back and re-growing each season.',                  14),
    ('bulbs',              'Bulbs',               'Plants that grow from bulbs, corms, tubers, or rhizomes. Examples: tulips, onions, garlic.',              15),
    ('cacti',              'Cacti',               'Succulent plants of the family Cactaceae, adapted to hot and dry environments.',                          16),
    ('carnivorous_plants', 'Carnivorous Plants',  'Plants that obtain nutrients by trapping and digesting insects or other small animals.',                  17),
    ('deciduous_plants',   'Deciduous Plants',    'Plants that shed their leaves seasonally, typically in autumn.',                                          18),
    ('evergreen_plants',   'Evergreen Plants',    'Plants that retain their leaves throughout the year.',                                                    19),
    ('fruit_trees',        'Fruit Trees',         'Trees cultivated for their edible fruit. Examples: apple, cherry, mango, citrus.',                        20);

-- ----------------------------------------------------------------------------
-- 3. light_requirements
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS light_requirements (
    id          SERIAL PRIMARY KEY,
    value       TEXT NOT NULL UNIQUE,
    label       TEXT NOT NULL,
    description TEXT,
    min_hours   INT,
    max_hours   INT,
    sort_order  INT NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO light_requirements (value, label, description, min_hours, max_hours, sort_order) VALUES
    ('full_sun',      'Full Sun',      'Requires 6 or more hours of direct sunlight per day. Ideal for most vegetables and flowering plants.',  6,    NULL, 1),
    ('partial_sun',   'Partial Sun',   'Thrives with 4 to 6 hours of direct sunlight per day. Suitable for many herbs and light-loving shrubs.', 4,   6,    2),
    ('partial_shade', 'Partial Shade', 'Grows well with 2 to 4 hours of filtered or indirect sunlight per day.',                               2,    4,    3),
    ('full_shade',    'Full Shade',    'Adapted to fewer than 2 hours of indirect light per day. Suited for understory and woodland plants.',   NULL, 2,    4);

-- ----------------------------------------------------------------------------
-- 4. watering_frequencies
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS watering_frequencies (
    id                 SERIAL PRIMARY KEY,
    value              TEXT NOT NULL UNIQUE,
    label              TEXT NOT NULL,
    description        TEXT,
    interval_days_min  INT,
    interval_days_max  INT,
    sort_order         INT NOT NULL DEFAULT 0,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO watering_frequencies (value, label, description, interval_days_min, interval_days_max, sort_order) VALUES
    ('daily',      'Daily',      'Water every day. Suited to fast-draining soils or high-water-demand plants in hot climates.',    1,  1,  1),
    ('frequent',   'Frequent',   'Water every 2 to 3 days. Good for potted plants or crops in warm, dry conditions.',             2,  3,  2),
    ('moderate',   'Moderate',   'Water approximately once a week. Suitable for most garden vegetables and flowering plants.',     4,  7,  3),
    ('infrequent', 'Infrequent', 'Water every 1 to 2 weeks. Works for drought-tolerant plants once established.',                 8,  14, 4),
    ('rare',       'Rare',       'Water every 2 to 4 weeks. Ideal for cacti, succulents, and plants in cool, low-light settings.', 15, 30, 5);

-- ----------------------------------------------------------------------------
-- 5. growth_seasons
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS growth_seasons (
    id          SERIAL PRIMARY KEY,
    value       TEXT NOT NULL UNIQUE,
    label       TEXT NOT NULL,
    description TEXT,
    month_start INT CHECK (month_start BETWEEN 1 AND 12),
    month_end   INT CHECK (month_end BETWEEN 1 AND 12),
    sort_order  INT NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO growth_seasons (value, label, description, month_start, month_end, sort_order) VALUES
    ('early_spring', 'Early Spring', 'March to April. Soil begins to warm; frost risk remains. Good for cold-hardy seedlings.',      3,    4,    1),
    ('late_spring',  'Late Spring',  'May. Last frost passed in most regions. Ideal for transplanting warm-season crops.',           5,    5,    2),
    ('summer',       'Summer',       'June to August. Peak growing season for warm-season vegetables and tropical plants.',          6,    8,    3),
    ('autumn',       'Autumn',       'September to November. Cooling temperatures. Good for root vegetables and winter greens.',     9,    11,   4),
    ('winter',       'Winter',       'December to February. Dormancy period for most plants. Suitable for cold-hardy crops.',        12,   2,    5),
    ('year_round',   'Year Round',   'Active growth throughout all seasons. Typical for tropical or greenhouse-grown plants.',       1,    12,   6);
