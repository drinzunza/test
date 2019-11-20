CREATE TABLE conditions (
    id SERIAL PRIMARY KEY,
    description TEXT,
    type VARCHAR(255),
    defect_id INT
);

CREATE TABLE defects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    number INT,
    material_id INT
);

CREATE TABLE materials (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    measure_unit VARCHAR(50),
    subcomponent_id INT
);

CREATE TABLE structural_components (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE structures (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    primary_owner VARCHAR(255),
    caltrans_bridge_no VARCHAR(255),
    postmile DOUBLE PRECISION,
    begin_stationing VARCHAR(255),
    end_stationing VARCHAR(255)
);

CREATE TABLE structure_components (
    id SERIAL PRIMARY KEY,
    structure_id    VARCHAR(50),
    structural_component_id INT
);

CREATE TABLE subcomponents (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    structural_component_id INT
);

INSERT INTO structure_components ("structure_id","structural_component_id") VALUES ('BR-L01',1),
 ('BR-L01',2),
 ('BR-L01',3),
 ('BR-L01',4),
 ('BR-L01',5),
 ('BR-L01',6),
 ('BR-L01',7),
 ('BR-L01',8),
 ('BR-L01',9),
 ('BR-L01',10),
 ('BR-L01',11),
 ('BR-L02L BR-L02R',1),
 ('BR-L02L BR-L02R',2),
 ('BR-L02L BR-L02R',3),
 ('BR-L02L BR-L02R',4),
 ('BR-L02L BR-L02R',5),
 ('BR-L02L BR-L02R',6),
 ('BR-L02L BR-L02R',7),
 ('BR-L02L BR-L02R',8),
 ('BR-L02L BR-L02R',9),
 ('BR-L02L BR-L02R',10),
 ('BR-L02L BR-L02R',11),
 ('BR-L03',1),
 ('BR-L03',2),
 ('BR-L03',3),
 ('BR-L03',4),
 ('BR-L03',5),
 ('BR-L03',6),
 ('BR-L03',7),
 ('BR-L03',8),
 ('BR-L03',9),
 ('BR-L03',10),
 ('BR-L03',11),
 ('BR-L04',1),
 ('BR-L04',2),
 ('BR-L04',3),
 ('BR-L04',4),
 ('BR-L04',5),
 ('BR-L04',6),
 ('BR-L04',7),
 ('BR-L04',8),
 ('BR-L04',9),
 ('BR-L04',10),
 ('BR-L04',11),
 ('BR-L05',1),
 ('BR-L05',2),
 ('BR-L05',3),
 ('BR-L05',4),
 ('BR-L05',5),
 ('BR-L05',6),
 ('BR-L05',7),
 ('BR-L05',8),
 ('BR-L05',9),
 ('BR-L05',10),
 ('BR-L05',11),
 ('BR-L06',1),
 ('BR-L06',2),
 ('BR-L06',3),
 ('BR-L06',4),
 ('BR-L06',5),
 ('BR-L06',6),
 ('BR-L06',7),
 ('BR-L06',8),
 ('BR-L06',9),
 ('BR-L06',10),
 ('BR-L06',11),
 ('BR-L07',1),
 ('BR-L07',2),
 ('BR-L07',3),
 ('BR-L07',4),
 ('BR-L07',5),
 ('BR-L07',6),
 ('BR-L07',7),
 ('BR-L07',8),
 ('BR-L07',9),
 ('BR-L07',10),
 ('BR-L07',11),
 ('BR-L08',1),
 ('BR-L08',2),
 ('BR-L08',3),
 ('BR-L08',4),
 ('BR-L08',5),
 ('BR-L08',6),
 ('BR-L08',7),
 ('BR-L08',8),
 ('BR-L08',9),
 ('BR-L08',10),
 ('BR-L08',11),
 ('BR-L09',1),
 ('BR-L09',2),
 ('BR-L09',3),
 ('BR-L09',4),
 ('BR-L09',5),
 ('BR-L09',6),
 ('BR-L09',7),
 ('BR-L09',8),
 ('BR-L09',9),
 ('BR-L09',10),
 ('BR-L09',11),
 ('BR-L10',1),
 ('BR-L10',2),
 ('BR-L10',3),
 ('BR-L10',4),
 ('BR-L10',5),
 ('BR-L10',6),
 ('BR-L10',7),
 ('BR-L10',8),
 ('BR-L10',9),
 ('BR-L10',10),
 ('BR-L10',11),
 ('UG-A01',12),
 ('UG-A01',13),
 ('UG-A01',14),
 ('UG-A02',12),
 ('UG-A02',13),
 ('UG-A02',14),
 ('UG-A03',12),
 ('UG-A03',13),
 ('UG-A03',14),
 ('UG-A04',12),
 ('UG-A04',13),
 ('UG-A04',14);
INSERT INTO subcomponents ("id","name","structural_component_id") VALUES (1,'N/A',1),
 (2,'N/A',2),
 (3,'Girders (ft.)',3),
 (4,'Trusses / Arches (ft.)',3),
 (5,'Stringers (ft.)',3),
 (6,'Floor Beams (ft.)',3),
 (7,'Miscellaneous Superstructure Elements',3),
 (8,'N/A',4),
 (9,'Abutments (ft.)',5),
 (10,'Pier Caps (ft.)',5),
 (11,'Columns (Ea.) / Pier Walls (ft.)',5),
 (12,'Pile Caps (ft.) / Footings (ft.) / Piles (Ea.)',5),
 (13,'Seismic Shells / Slope & Scour Protection (Ea.)',5),
 (14,'N/A',6),
 (15,'N/A',7),
 (16,'N/A',8),
 (17,'N/A',9),
 (18,'N/A',10),
 (19,'N/A',11),
 (20,'Liners',12),
 (21,'Tunnel Roof Girders',12),
 (22,'Columns/Piles',12),
 (23,'Cross Passageway',12),
 (24,'Interior Walls',12),
 (25,'Portal',12),
 (26,'Ceiling Slab',12),
 (27,'Ceiling Girder',12),
 (28,'Hangers and Anchorages',12),
 (29,'Ceiling Panels',12),
 (30,'Invert Slab',12),
 (31,'Slab‐on‐Grade',12),
 (32,'Invert Girder',12),
 (33,'Joints',12),
 (34,'Gaskets',12),
 (35,'Miscellaneous metal (e.g. stair stringer supports, escalator supports monorails, grating supports, etc.)',13),
 (36,'Handrails, steel grated walkways, ladders, etc.',14);
INSERT INTO structures ("id","name","type","primary_owner","caltrans_bridge_no","postmile","begin_stationing","end_stationing") VALUES ('BR-L01','Slauson Avenue','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten','53C1924R',5.2,'160+31
(L1 155+29)
(L2 155+52)','185+59
(190+60)'),
 ('BR-L02L BR-L02R','Firestone Blvd Bridge','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,7.2,'272+10
(L1 263+20)','276+19
(L1 286+70)'),
 ('BR-L03','Rosecrans Viaduct','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,11.34,'473+61
(L1 472+60)
(L2 469+12)','494+39
(L2 498+88)'),
 ('BR-L04','Compton Creek Bridge','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,NULL,'578+15
(L1 574+20)','579+47
(L1 584+90)'),
 ('BR-L05','Dominguez Viaduct','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,14.3,'637+41
(L1 632+78)
(L2 634+28)','654+31
(L1 657+85)
(L2 659+24)'),
 ('BR-L06','Del Amo Flyover','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,15.4,'698+55
(L1 692+60)
(L2 690+62)','711+67
(L1 713+75)
(L2 716+95)'),
 ('BR-L07','Cota Viaduct','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten','53 2731',15.9,'725+94
(L1 720+00)
(L2 722+15)','744+87
(L1 750+30)'),
 ('BR-L08','Los Angeles River Bridge','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,16.5,'751+85','760+35'),
 ('BR-L09','Bixby Creek Culvert','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,NULL,'871+15','871+45'),
 ('BR-L10','Culvert South of Bixby Creek','BRIDGES_AND_AERIAL_STRUCTURE','Los Angeles Metropoliten',NULL,NULL,'880+75',NULL),
 ('UG-A01','Portal Cut & Cover Structure','SUBWAY_TUNNELS_USECTION','Los Angeles Metropoliten',NULL,0.02,'YR 84+50
YL 84+70
(YR 82+45)
(YL 77+22)','YR 89+75
YL 89+75'),
 ('UG-A02','Portal to Union Station East Crossover Tunnel','SUBWAY_TUNNELS_USECTION','Los Angeles Metropoliten',NULL,NULL,'89+75','97+04'),
 ('UG-A03','Union Station East Crossover Structure','SUBWAY_TUNNELS_USECTION','Los Angeles Metropoliten',NULL,0.31,'97+04','102+74'),
 ('UG-A04','Union Station','SUBWAY_TUNNELS_USECTION','Los Angeles Metropoliten',NULL,0.42,'102+74','107+80');
INSERT INTO structural_components ("id","name") VALUES (1,'Deck & Slabs (sq. ft.)'),
 (2,'Railings (ft.)'),
 (3,'Superstructure'),
 (4,'Bearings (Ea.)'),
 (5,'Substructure'),
 (6,'Culverts (ft.)'),
 (7,'Joints (ft.)'),
 (8,'Approach Slabs (sq. ft.)'),
 (9,'Protective Systems'),
 (10,'Walkways'),
 (11,'Soil Condtion'),
 (12,'Structural Concrete'),
 (13,'Structural Steel'),
 (14,'Miscellaneous Steel');
INSERT INTO materials ("id","name","description","measure_unit","subcomponent_id") VALUES (1,'Deck - Reinforced Concrete','All reinforced concrete bridge decks regardless of the wearing surface or protection systems used.','sq.ft.',1),
 (2,'Deck – Prestressed Concrete','All prestressed concrete bridge decks regardless of the wearing surface or protection systems used.','sq.ft.',1),
 (3,'Top Flange - Prestressed Concrete','All prestressed bridge girder top flanges where traffic rides directly on the structural element
regardless of the wearing surface or protection systems used. These bridge types include only
concrete bulb-tees, box girders, and girders that require traffic to ride on the top flange. Use in
conjunction with the appropriate girder element.','sq.ft.',1),
 (4,'Top Flange - Reinforced Concrete','All reinforced concrete bridge girder top flanges where traffic rides directly on the structural element
regardless of the wearing surface or protection systems used. These bridge types include only
concrete tee-beams, box girders, and girders that require traffic to ride on the top flange. Use in
conjunction with the appropriate girder element.','sq.ft.',1),
 (5,'Steel Deck - Open Grid','All open grid steel bridge decks with no fill.','sq.ft.',1),
 (6,'Steel Deck - Concrete Filled Grid','Steel bridge decks with concrete fill either in all of the openings or within the wheel tracks.','sq.ft.',1),
 (7,'Steel Deck - Corrugated/Orthotropic/Etc.','Those bridge decks constructed of corrugated metal filled with portland cement, asphaltic concrete,
or other riding surfaces. Orthotropic steel decks are also included.','sq.ft.',1),
 (8,'Deck - Timber','All timber bridge decks regardless of the wearing surface or protection systems used.','sq.ft.',1),
 (9,'Slab - Reinforced Concrete','All reinforced concrete bridge slabs regardless of the wearing surface or protection systems used.','sq.ft.',1),
 (10,'Slab - Prestressed Concrete','All prestressed concrete bridge slabs regardless of the wearing surface or protection systems used.','sq.ft.',1),
 (11,'Slab - Timber','All timber bridge slabs regardless of the wearing surface or protection systems used.','sq.ft.',1),
 (12,'Deck - Other','All bridge decks constructed of other materials not otherwise defined regardless of the wearing
surface or protection systems used.','sq.ft.',1),
 (13,'Slab - Other','All slabs constructed of other materials not otherwise defined regardless of the wearing surface or
protection systems used.','sq.ft.',1),
 (14,'Bridge Railing - Metal','All types and shapes of metal bridge railing. Steel, aluminum, metal beam, rolled shapes, etc. will all
be considered part of this element. Included in this element are the posts of metal, timber or
concrete, blocking, and curb.','ft.',2),
 (15,'Bridge Railing - Reinforced Concrete','All types and shapes of reinforced concrete bridge railing. All elements of the railing must be concrete.','ft.',2),
 (16,'Bridge Railing - Timber','All types and shapes of timber bridge railing. Included in this element are posts of timber, metal, or
concrete, blocking, and curb.','ft.',2),
 (17,'Bridge Railing - Other','All types and shapes of bridge railing except those defined as metal, concrete, timber, or masonry.
Use this element for combination rails that have concrete parapets and metal top sections attached.','ft.',2),
 (18,'Bridge Railing - Masonry','All types and shapes of masonry block or stone bridge railing. All elements of the railing must be
masonry block or stone.','ft.',2),
 (19,'Closed Web/Box Girder - Steel','All steel box girders or closed web girders. For all box girders regardless of protective system.','ft.',3),
 (20,'Closed Web/Box Girder - Prestressed Concrete','All pretensioned or post-tensioned concrete closed web girders or box girders. For all box girders
regardless of protective system.','ft.',3),
 (21,'Closed Web/Box Girder - Reinforced Concrete','All reinforced concrete box girders or closed web girders. For all box girders regardless of protective
system.','ft.',3),
 (22,'Closed Web/Box Girder - Other','All other material box girders or closed web girders. For all other material box girders regardless of
protective system.','ft.',3),
 (23,'Open Girder/Beam - Steel','All steel open girders regardless of protective system.','ft.',3),
 (24,'Open Girder/Beam - Prestressed Concrete','Pretensioned or post-tensioned concrete open web girders regardless of protective system.','ft.',3),
 (25,'Open Girder/Beam - Reinforced Concrete','Mild steel reinforced concrete open web girders regardless of protective system.','ft.',3),
 (26,'Open Girder/Beam - Timber','All timber open girders regardless of protection system.','ft.',3),
 (27,'Open Girder/Beam - Other','All other material girders regardless of protection system.','ft.',3),
 (28,'Truss - Steel','All steel truss elements, including all tension and compression members for through and deck trusses.
It is for all trusses regardless of protective system.','ft.',4),
 (29,'Truss - Timber','All timber truss elements, including all tension and compression members for through and deck
trusses. It is for all trusses regardless of protective system.','ft.',4),
 (30,'Truss - Other','All other material truss elements, including all tension and compression members, and through and
deck trusses. It is for all other material trusses regardless of protective system.','ft.',4),
 (31,'Arch - Steel','Steel arches regardless of type or protective system.','ft.',4),
 (32,'Arch - Other','Other material arches regardless of type or protective system.','ft.',4),
 (33,'Arch - Prestressed Concrete','Only pretensioned or post-tensioned concrete arches regardless of protective system.','ft.',4),
 (34,'Arch - Reinforced Concrete','Only mild steel reinforced concrete arches regardless of protective system.','ft.',4),
 (35,'Arch - Masonry','Masonry or stacked stone arches regardless of protective system.','ft.',4),
 (36,'Arch - Timber','Only timber arches regardless of protective system.','ft.',4),
 (37,'Stringer - Steel','Steel members that support the deck in a stringer floor beam system regardless of protective system.','ft.',5),
 (38,'Stringer - Prestressed Concrete','Pretensioned or post-tensioned concrete members that support the deck in a stringer floor beam
system regardless of protective system.','ft.',5),
 (39,'Stringer - Reinforced Concrete','Mild steel reinforced concrete members that support the deck in a stringer floor beam system
regardless of protective system.','ft.',5),
 (40,'Stringer - Timber','Timber members that support the deck in a stringer floor beam system regardless of protective
system.','ft.',5),
 (41,'Stringer - Other','All other material stringers regardless of protection system.','ft.',5),
 (42,'Floor Beam - Steel','Steel floor beams that typically support stringers regardless of protective system.','ft.',6),
 (43,'Floor Beam - Prestressed Concrete','Prestressed concrete floor beams that typically support stringers regardless of protective system.','ft.',6),
 (44,'Floor Beam - Reinforced Concrete','Mild steel reinforced concrete floor beams that typically support stringers regardless of protective
system.','ft.',6),
 (45,'Floor Beam - Timber','Timber floor beams that typically support stringers regardless of protective system.','ft.',6),
 (46,'Floor Beam - Other','Other material floor beams that typically support stringers regardless of protective system.','ft.',6),
 (47,'Cables - Main Steel','All steel main suspension or cable stay cables not embedded in concrete.
For all cable groups regardless of protective systems.','ft.',7),
 (48,'Cables - Secondary Steel','All steel suspender cables not embedded in concrete.
For all individual or cable groups regardless of protective system.','Each',7),
 (49,'Cables - Secondary Other','All other material cables not embedded in concrete.
For all individual other material cables or cable groups regardless of protective systems.','Each',7),
 (50,'Steel Pin and Pin & Hanger Assembly','Steel pins and pin and hanger assemblies regardless of protective system.','Each',7),
 (51,'Steel Gusset Plate','Only those steel gusset plate(s) connections that are on the main truss/arch panel(s).
These connections can be constructed with one or more plates that may be bolted, riveted, or
welded. For all gusset plates regardless of protective system.','Each',7),
 (52,'Railroad Car Frame','This member defines all superstructures composed of railroad car frames.','ft.',7),
 (53,'Miscellaneous Steel Superstructures','This member is intended to be used for all other miscellaneous steel superstructure elements that
were not previously defined.
Examples of such structures includes army steel tread way, boat hatch cover, army steel pontoon, etc.
The entire superstructure area (equivalent deck area) composed of these miscellaneous elements will
be treated as an each regardless of the number of spans.','Each',7),
 (54,'EQ Restrainer Cables – Type II','This member defines seismic restrainer cables used for hinges with long hinge seats (>9 inches) and
occasionally in combination with pipe seat extenders. The standard length varies from fifteen to forty
feet and the restrainer system at a hinge may consist of six to twelve cables.','Each Unit',7),
 (55,'EQ Restrainer Cables – C1','This member defines seismic restrainer cables used for hinges with short hinge seats (<9 inches).
The current standard number of cables per drum is five. The original systems consisted of seven
cables per drum.','Each Unit',7),
 (56,'EQ Restrainer Cables - Other','This element defines Seismic restrainer cables systems that are not Type II or C-1 restrainer cable
systems.','Each Unit',7),
 (57,'Bearing - Elastomeric','Only those bridge bearings that are constructed primarily of elastomers, with or without fabric or
metal reinforcement.','Each',8),
 (58,'Bearing - Movable','Only those bridge bearings which provide for both rotation and longitudinal movement by means of
roller, rocker, or sliding mechanisms.','Each',8),
 (59,'Bearing - Enclosed/Concealed','Only those bridge bearings that are enclosed so that they are not open for detailed inspection.','Each',8),
 (60,'Bearing - Fixed','Only those bridge bearings that provide for rotation only (no longitudinal movement.','Each',8),
 (61,'Bearing - Pot','Those high load bearings with confined elastomer. The bearing may be fixed against horizontal
movement, guided to allow sliding in one direction, or floating to allow sliding in any direction.','Each',8),
 (62,'Bearing - Disk','Those high load bearings with a hard plastic disk. This bearing may be fixed against horizontal
movement, guided to allow movement in one direction, or floating to allow sliding in any direction.','Each',8),
 (63,'Bearing - Other','All other material bridge bearings regardless of translation or rotation constraints.','Each',8),
 (64,'Abutment - Reinforced Concrete','Reinforced concrete abutments. This includes the material retaining the embankment and monolithic
wingwalls and abutment extensions. For all reinforced concrete abutments regardless of protective
systems.','ft.',9),
 (65,'Abutment - Timber','Timber abutments, including the sheet material retaining the embankment, integral wingwalls, and
abutment extensions. For all abutments regardless of protective systems.','ft.',9),
 (66,'Abutment - Masonry','Those abutments constructed of block or stone, including integral wingwalls and abutment
extensions. The block or stone may be placed with or without mortar. For all abutments regardless of
protective systems.','ft.',9),
 (67,'Abutment - Other','Other material abutment systems, including the sheet material retaining the embankment, and
integral wingwalls and abutment extensions. For all abutments regardless of protective systems.','ft.',9),
 (68,'Abutment - Steel','Steel abutments, including the sheet material retaining the embankment, and integral wingwalls and
abutment extensions. For all abutments regardless of protective systems.','ft.',9),
 (69,'Pier Cap - Steel','Those steel pier caps that support girders and transfer load into piles or columns. For all steel pier
caps regardless of protective system.','ft.',10),
 (70,'Pier Cap - Prestressed Concrete','Those prestressed concrete pier caps that support girders and transfer load into piles or columns. For
all caps regardless of protective system.','ft.',10),
 (71,'Pier Cap - Reinforced Concrete','Those reinforced concrete pier caps that support girders and transfer load into piles or columns. For
all pier caps regardless of protective system.','ft.',10),
 (72,'Pier Cap - Timber','Those timber pier caps that support girders that transfer load into piles, or columns. For all timber
pier caps regardless of protective system.','ft.',10),
 (73,'Pier Cap - Other','Other material pier caps that support girders that transfer load into piles or columns. For all other
material pier caps regardless of protective system.','ft.',10),
 (74,'Column - Steel','All steel columns regardless of protective system.','Each',11),
 (75,'Column - Other','All other material columns regardless of protective system.','Each',11),
 (76,'Column - Prestressed Concrete','All prestressed concrete columns regardless of protective system.','Each',11),
 (77,'Column - Reinforced Concrete','All reinforced concrete columns regardless of protective system.','Each',11),
 (78,'Column - Timber','All timber columns regardless of protective system.','Each',11),
 (79,'Tower - Steel','Steel built up or framed tower supports regardless of protective system.','ft.',11),
 (80,'Trestle - Timber','Framed timber supports. For all timber trestle/towers regardless of protective system.','ft.',11),
 (81,'Pier Wall - Reinforced Concrete','Reinforced concrete pier walls regardless of protective systems.','ft.',11),
 (82,'Pier Wall - Other','Those pier walls constructed of other materials regardless of protective systems.','ft.',11),
 (83,'Pier Wall - Timber','Those timber pier walls that include pile, timber sheet material, and filler. For all pier walls regardless
of protective systems.','ft.',11),
 (84,'Pier Wall - Masonry','Those pier walls constructed of block or stone. The block or stone may be placed with or without
mortar. For all pier walls regardless of protective systems.','ft.',11),
 (85,'Pile Cap/Footing - Reinforced Concrete','Reinforced concrete pile caps/footings that are visible for inspection, including pile caps/footings
exposed from erosion or scour or visible during an underwater inspection. The exposure may be
intentional or caused by erosion or scour.','ft.',12),
 (86,'Pile - Steel','Steel piles that are visible for inspection, including piles exposed from erosion or scour and piles
visible during an underwater inspection. For all steel piles regardless of protective system.','Each',12),
 (87,'Pile - Prestressed Concrete','Prestressed concrete piles that are visible for inspection, including piles exposed from erosion or scour
and piles visible during an underwater inspection. For all prestressed concrete piles regardless of
protective system.','Each',12),
 (88,'Pile - Reinforced Concrete','Reinforced concrete piles that are visible for inspection, including piles exposed from erosion or scour
and piles visible during an underwater inspection are included. For all reinforced concrete piles
regardless of protective system.','Each',12),
 (89,'Pile - Timber','Timber piles that are visible for inspection, including piles exposed from erosion or scour and piles
visible during an underwater inspection. For all timber piles regardless of protective system.','Each',12),
 (90,'Pile - Other','Other material piles that are visible for inspection, including piles exposed from erosion or scour and
piles visible during an underwater inspection. For all other material piles regardless of protective
system.','Each',12),
 (91,'Pile - Cast in Steel Shell','Steel piles filled with concrete. Not for use with steel forms for fully reinforced columns/piles.','Each',12),
 (92,'Pile - Cast-In-Drilled-Hole (CIDH)','Reinforced concrete piles that are visible for inspection. The exposure may be intentional or caused
by scour.','Each',12),
 (93,'Steel Seismic Column Shells (Full Height)','Seismic steel confinement shells that are full height.','Each',13),
 (94,'Steel Seismic Column Shells (Partial Height)','Seismic steel confinement shells that are partial height.','Each',13),
 (95,'Slope/Scour Protection','All types of erosion/scour protection for the supports; including grouted or ungrouted riprap and
concrete paving under the bridge.','EA',13),
 (96,'Culvert - Steel','Steel culverts, including arched, round, or elliptical pipes.','ft.',14),
 (97,'Culvert - Reinforced Concrete','Reinforced concrete culverts, including box, arched, round, or elliptical shapes.','ft.',14),
 (98,'Culvert - Timber','All timber culverts.','ft.',14),
 (99,'Culvert - Other','Other material type culverts, including arches, round, or elliptical pipes. These culverts are not
included in steel, concrete, or timber material types.','ft.',14),
 (100,'Culvert - Masonry','Masonry block or stone culverts.','ft.',14),
 (101,'Culvert - Prestressed Concrete','All prestressed concrete culverts.','ft.',14),
 (102,'Joint - Strip Seal Expansion','Those expansion joint devices which utilize a neoprene type waterproof gland with some type of
metal extrusion or other system to anchor the gland.','ft.',15),
 (103,'Joint - Pourable Seal','Those joints filled with a pourable seal with or without a backer.','ft.',15),
 (104,'Joint - Compression Seal','Only those joints filled with a preformed compression type seal. This joint may or may not have an
anchor system to confine the seal.','ft.',15),
 (105,'Joint - Assembly with Seal','Only those joints filled with an assembly mechanism that has a seal.','ft.',15),
 (106,'Joint - Open Expansion','Only those joints that are open and not sealed.','ft.',15),
 (107,'Joint - Assembly Without Seal','Only those assembly joints that are open and not sealed, excluding steel finger and sliding plate joints.','ft.',15),
 (108,'Joint - Other','Only those other joints that are not defined by any other joint element.','ft.',15),
 (109,'Joint - Asphaltic Plug','Only those joints with a standard asphaltic plug and shall not be used for joints paved over.','ft.',15),
 (110,'Joint - Steel Sliding Plates','Only those joints that are open and constructed as sliding plate type joints.','ft.',15),
 (111,'Joint - Steel Fingers','Only those joints that are steel finger joints.','ft.',15),
 (112,'Approach Slab - Prestressed Concrete','Those structural sections, between the abutment and the approach pavement that are constructed of
prestressed (post-tensioned) reinforced concrete.','sq.ft.',16),
 (113,'Approach Slab - Reinforced Concrete','Those structural sections between the abutment and the approach pavement that are constructed of
mild steel reinforced concrete.','sq.ft.',16),
 (114,'Deck Wearing Surface – Asphaltic Concrete','All decks/slabs that have overlays made with flexible (asphaltic concrete).','sq. ft.',17),
 (115,'Deck Wearing Surface – Concrete (Polyester)','This element is for all decks/slabs that have overlays made with rigid (portland cement) materials or
polyester concrete.','sq. ft.',17),
 (116,'Deck Wearing Surface - Epoxy','This element is for all decks/slabs that have overlays made with epoxy materials.','sq. ft.',17),
 (117,'Deck Wearing Surface - Timber','All timber wearing surfaces','sq. ft.',17),
 (118,'Steel Protective Coating - Paint','Steel elements that have a protective coating such as paint, or other top coat steel corrosion inhibitor.','sq. ft. (surface)',17),
 (119,'Steel Protective Coating - Galvanization','The element is for steel elements that have a protective galvanized coating system.','sq ft. (surface)',17),
 (120,'Steel Protective Coating - Weathering Steel','Steel elements that have a protective weathering steel coating.','sq.ft. (surface)',17),
 (121,'Reinforcing Steel Protective System
(Rebar Coating/Cathodic)','All types of protective systems used to protect reinforcing steel in concrete elements from corrosion.','sq.ft.',17),
 (122,'Concrete Protective Coating (Methacrylate/Sealer)','Concrete elements that have a penetrating sealer applied to them. These coatings include
silane/siloxane water proofers, crack sealers such as High Molecular Weight Methacrylate (HMWM),
or any top coat barrier that protects concrete from deterioration and reinforcing steel from corrosion.','sq.ft. (surface)',17),
 (123,'Deck Membrane','Concrete elements that have a protective membrane applied to the member. The typical
configuration is a waterproofing membrane under the AC overlay that protects the concrete from
deterioration and reinforcing steel from corrosion.','sq.ft. (surface)',17),
 (124,'Steel Tunnel Liner','Record this element for all steel tunnel liners. Steel tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (125,'Cast-in-Place Concrete Tunnel Liner','Record this element for all cast-in-place concrete tunnel liners. Cast-in place concrete tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (126,'Precast Concrete Tunnel Liner','Record this element for all precast concrete tunnel liners. Precast concrete tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (127,'Shotcrete Tunnel Liner','Record this element for all shotcrete tunnel liners. Shotcrete tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (128,'Timber Tunnel Liner','Record this element for all timber tunnel liners consisting of timber sets with or without timber lagging Timber tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (129,'Masonry Tunnel Liner','Record this element for all masonry tunnel liners. Masonry tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (130,'Unlined Rock Tunnel','Record this element for all unlined rock tunnels. Unlined rock tunnels function as the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of an unlined rock tunnel is the product of the length of the tunnel (along the centerline) and the perimeter of the unlined rock.','area, ft2',20),
 (131,'Rock Bolt/Dowel','Record this element for all rock bolts or dowels.
The total number of rock bolt/dowels is the sum of all the number of rock bolts and dowels.','each',20),
 (132,'Other Tunnel Liner','Record this element for all tunnel liners composed of other materials. Other tunnel liners function as a shell for the exterior of the tunnel and as a divider between different bores of the tunnel.
The area of a tunnel liner is the product of the length (along the centerline) of the tunnel and the perimeter of the liner.','area, ft2',20),
 (133,'Steel Tunnel Roof Girders','Record this element for all steel tunnel roof girders. Tunnel roof girders support the tunnel roof liner or exposed rock which constitutes the tunnel roof.
The total length of tunnel roof girder is the sum of all the lengths of each tunnel roof girder.','length, ft',21),
 (134,'Concrete Tunnel Roof Girders','Record this element for all concrete tunnel roof girders. Tunnel roof girders support the tunnel roof liner or exposed rock which constitutes the tunnel roof.
The total length of tunnel roof girder is the sum of all the lengths of each tunnel roof girder.','length, ft',21),
 (135,'Prestressed Concrete Tunnel Roof Girders','Record this element for all prestressed concrete tunnel roof girders. Tunnel roof girders support the tunnel roof liner or exposed rock which constitutes the tunnel roof.
The total length of tunnel roof girder is the sum of all the lengths of each tunnel roof girder.','length, ft',21),
 (136,'Other Tunnel Roof Girders','Record this element for all tunnel roof girders composed of other materials. Tunnel roof girders support the tunnel roof liner or exposed rock which constitutes the tunnel roof.
The total length of tunnel roof girder is the sum of all the lengths of each tunnel roof girder.','length, ft',21),
 (137,'Steel Columns/Piles','Record this element for all steel columns/piles. Tunnel columns support the tunnel roof girders, tunnel ceiling girders and tunnel invert girders. Tunnel piles provide support for the tunnel columns.
The total number of columns/piles is the sum of all the number of columns and piles.','each',22),
 (138,'Concrete Columns/Piles','Record this element for all concrete columns/piles. Tunnel columns support the tunnel roof girders, tunnel ceiling girders tunnel invert girders. Tunnel piles provide support for the tunnel columns.
The total number of columns/piles is the sum of all the number of columns and piles.','each',22),
 (139,'Other Columns/Piles','Record this element for all columns/piles composed of other material. Tunnel columns support the tunnel roof girders, tunnel ceiling girders tunnel invert girders. Tunnel piles provide support for the tunnel columns.
The total number of columns/piles is the sum of all the number of columns and piles.','each',22),
 (140,'Steel Cross Passageway','Record this element for all steel cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (141,'Concrete Cross Passageway','Record this element for all concrete cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (142,'Shotcrete Cross Passageway','Record this element for all shotcrete cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (143,'Timber Cross Passageway','Record this element for all timber cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (144,'Masonry Cross Passageway','Record this element for all masonry cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (145,'Unlined Rock Cross Passageway','Record this element for all unlined rock cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (146,'Other Cross Passageway','Record this element for all other cross passageways. Cross passageways are typically oriented transverse to the tunnel bores, and are comprised of doors to allow egress between separated tunnel bores.
The total length of cross passageways is the sum of all of the lengths of each cross passageway.','length, ft',23),
 (147,'Concrete Interior Walls','Record this element for all concrete interior walls. This element defines those internal walls in tunnels which are usually placed to separate traffic travelling in opposite directions. The internal wall also serves as a barrier between tunnel segments in an emergency to protect evacuees from smoke inhalation, fire or hazardous conditions.
The area of the interior wall is the product of the length (along the centerline) of the tunnel and the height.','area, ft2',24),
 (148,'Other Interior Walls','Record this element for all interior walls composed of other materials. This element defines those internal walls in tunnels which are usually placed to separate traffic travelling in opposite directions. The internal wall also serves as a barrier between tunnel segments in an emergency to protect evacuees from smoke inhalation, fire or hazardous conditions.
The area of the interior wall is the product of the length (along the centerline) of the tunnel and the height.','area, ft2',24),
 (149,'Concrete Portal','Record this element for all concrete portals. This element defines the portal façade, which comprise the architectural/structural elements that are above the roadway at the opening of the tunnel bore.
The area of the portal is the product of the width and height of the portal minus the area of the roadway opening. The area may include wingwalls which retain soil and rock near the portal but does not include walls leading up to the portal.','area, ft2',25),
 (150,'Masonry Portal','Record this element for all masonry portals. This element defines the portal façade, which comprise the architectural/structural elements that are above the roadway at the opening of the tunnel bore.
The area of the portal is the product of the width and height of the portal minus the area of the roadway opening. The area may include wingwalls which retain soil and rock near the portal but does not include walls leading up to the portal.','area, ft2',25),
 (151,'Other Portal','Record this element for all portals composed of other materials. This element defines the portal façade, which comprise the architectural/structural elements that are above the roadway at the opening of the tunnel bore.
The area of the portal is the product of the width and height of the portal minus the area of the roadway opening. The area may include wingwalls which retain soil and rock near the portal but does not include walls leading up to the portal.','area, ft2',25),
 (152,'Concrete Ceiling Slab','Record this element for all concrete ceiling slabs. This element defines those structural slabs which separate the space above the roadway from the upper plenum.
The area of the ceiling slab is the product of the width and length of the slab.','area, ft2',26),
 (153,'Other Ceiling Slab','Record this element for all ceiling slabs composed of other materials. This element defines those structural slabs which separate the space above the roadway from the upper plenum.
The area of the ceiling slab is the product of the width and length of the slab.','area, ft2',26),
 (154,'Steel Ceiling Girder','Record this element for all steel ceiling girders. This element defines the girders that support the structural ceiling slabs which separate the space above the roadway from the upper plenum.
The total quantity for ceiling girder is the sum of all the lengths of each tunnel ceiling girder.','length, ft',27),
 (155,'Concrete Ceiling Girder','Record this element for all concrete ceiling girders. This element defines the girders that support the structural ceiling slabs which separate the space above the roadway from the upper plenum.
The total quantity for ceiling girder is the sum of all the lengths of each tunnel ceiling girder.','length, ft',27),
 (156,'Prestressed Concrete Ceiling Girder','Record this element for all prestressed concrete ceiling girders. This element defines the girders that support the structural ceiling slabs which separate the space above the roadway from the upper plenum.
The total quantity for ceiling girder is the sum of all the lengths of each tunnel ceiling girder.','length, ft',27),
 (157,'Other Ceiling Girder','Record this element for all ceiling girders composed of other materials. This element defines the girders that support the structural ceiling slabs which separate the space above the roadway from the upper plenum.
The total quantity for ceiling girder is the sum of all the lengths of each tunnel ceiling girder.','length, ft',27),
 (158,'Steel Hangers and Anchorages','Record this element for all steel hangers and anchorages. Hangers are tension members that support ceiling girders or ceiling panels. The anchorages of the hangers are typically attached to the tunnel roof and ceiling panels.
The total quantity for hangers and anchorages is the sum of all the number of hanger and anchorage units.','each',28),
 (159,'Other Hangers and Anchorages','Record this element for all hangers and anchorages composed of other materials. Hangers are tension members that support ceiling girders or ceiling panels. The anchorages of the hangers are typically attached to the tunnel roof and ceiling panels.
The total quantity for hangers and anchorages is the sum of all the number of hanger and anchorage units.','each',28),
 (160,'Steel Ceiling Panels','Record this element for all steel ceiling panels. Ceiling panels separate the upper plenum from space above the tunnel roadway. Ceiling panels are typically supported by hangers.
The area of the ceiling panel is the product of the width and length of the panel.','area, ft2',29),
 (161,'Concrete Ceiling Panels','Record this element for all concrete ceiling panels. Ceiling panels separate the upper plenum from space above the tunnel roadway. Ceiling panels are typically supported by hangers.
The area of the ceiling panel is the product of the width and length of the panel.','area, ft2',29),
 (162,'Other Ceiling Panels','Record this element for all ceiling panels composed of other materials. Ceiling panels separate the upper plenum from space above the tunnel roadway. Ceiling panels are typically supported by hangers.
The area of the ceiling panel is the product of the width and length of the panel.','area, ft2',29),
 (163,'Concrete Invert Slab','Record this element for all concrete invert slabs. This element defines those structural slabs which support the roadway and traffic loads.
The total area of the invert slab is the product of the width and length of the slab.','area, ft2',30),
 (164,'Other Invert Slab','Record this element for all invert slabs composed of other materials. This element defines those structural slabs which support the roadway and traffic loads.
The total area of the invert slab is the product of the width and length of the slab.','area, ft2',30),
 (165,'Concrete Slab-on-Grade','Record this element for all concrete slabs-on- grade. This element defines a slab that is supported continuously on a subbase material.
The area of the slab-on-grade is the product of the width and length of the slab.','area, ft2',31),
 (166,'Other Slab-on-Grade','Record this element for all slabs-on-grade composed of other materials. This element defines a slab that is supported continuously on a subbase material.
The area of the slab-on-grade is the product of the width and length of the slab.','area, ft2',31),
 (167,'Steel Invert Girder','Record this element for all steel invert girders. This element defines the invert girders which support the invert slabs.
The total quantity for invert girder is the sum of all the lengths of each invert girder.','length, ft',32),
 (168,'Concrete Invert Girder','Record this element for all concrete invert girders. This element defines the invert girders which support the invert slabs.
The total quantity for invert girder is the sum of all the lengths of each invert girder.','length, ft',32),
 (169,'Prestressed Concrete Invert Girder','Record this element for all prestressed concrete invert girders. This element defines the invert girders which support the invert slabs.
The total quantity for invert girder is the sum of all the lengths of each invert girder.','length, ft',32),
 (170,'Other Invert Girder','Record this element for all invert girders composed of other materials. This element defines the invert girders which support the invert slabs.
The total quantity for invert girder is the sum of all the lengths of each invert girder.','length, ft',32),
 (171,'Strip Seal Expansion Joint','Record this element for all strip seal expansion joints. This element defines those roadway and tunnel expansion joint devices which utilize a neoprene type waterproof gland with some type of metal extrusion or other system to anchor the gland.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (172,'Pourable Joint Seal','Record this element for all pourable joint seals. This element defines those roadway and tunnel joints filled with a pourable seal with or without a backer.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (173,'Compression Joint Seal','Record this element for all compression joint seals. This element defines those roadway and tunnel joints filled with a preformed compression type seal. This joint does not have an anchor system to confine the seal.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (174,'Assembly Joint With Seal','Record this element for all assembly joints with seals. This element defines only those roadway and tunnel joints filled with an assembly mechanism that have a seal.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (175,'Open Expansion Joint','Record this element for all open expansion joints. This element defines only those roadway and tunnel joints that are open and not sealed.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (176,'Assembly Joint Without Seal','Record this element for all assembly joints without seals. This element defines only those roadway and tunnel assembly joints that are open and not sealed. These joints include finger and sliding plate joints.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (177,'Other Joint','Record this element for all other expansion joints. This element defines those roadway and tunnel expansion joint devices which utilize a neoprene type waterproof gland with some type of metal extrusion or other system to anchor the gland.
The total quantity for expansion joints is the sum of all the lengths of each joint.','length, ft',33),
 (178,'Gaskets','Record this element for all gaskets. This element defines those roadway and tunnel gaskets which are joints between segmental tunnel liners.
The total quantity for gasket is the sum of all lengths of each gasket.','length, ft',34);
INSERT INTO defects ("id","name","number","material_id") VALUES (1,'Delamination/ Spall/ Patched Area',1080,1),
 (2,'Exposed Rebar',1090,1),
 (3,'Efflorescence/ Rust Staining',1120,1),
 (4,'Cracking (RC and Other)',1130,1),
 (5,'Abrasion/Wear (PSC/RC)',1190,1),
 (6,'Damage',7000,1),
 (7,'Delamination/ Spall/ Patched Area',1080,2),
 (8,'Exposed Rebar',1090,2),
 (9,'Exposed Prestressing',1100,2),
 (10,'Cracking (PSC)',1110,2),
 (11,'Efflorescence/ Rust Staining',1120,2),
 (12,'Abrasion/Wear (PSC/RC)',1190,2),
 (13,'Damage',7000,2),
 (14,'Delamination/ Spall/ Patched Area',1080,3),
 (15,'Exposed Rebar',1090,3),
 (16,'Exposed Prestressing',1100,3),
 (17,'Cracking (PSC)',1110,3),
 (18,'Efflorescence/ Rust Staining',1120,3),
 (19,'Abrasion/Wear (PSC/RC)',1190,3),
 (20,'Damage',7000,3),
 (21,'Delamination/ Spall/ Patched Area',1080,4),
 (22,'Exposed Rebar',1090,4),
 (23,'Efflorescence/ Rust Staining',1120,4),
 (24,'Cracking (RC and Other)',1130,4),
 (25,'Abrasion/Wear (PSC/RC)',1190,4),
 (26,'Damage',7000,4),
 (27,'Corrosion',1000,5),
 (28,'Fatigue Crack (Steel/Other)',1010,5),
 (29,'Connection',1020,5),
 (30,'Damage',7000,5),
 (31,'Corrosion',1000,6),
 (32,'Fatigue Crack (Steel/Other)',1010,6),
 (33,'Connection',1020,6),
 (34,'Damage',7000,6),
 (35,'Corrosion',1000,7),
 (36,'Fatigue Crack (Steel/Other)',1010,7),
 (37,'Connection',1020,7),
 (38,'Damage',7000,7),
 (39,'Connection',1020,8),
 (40,'Decay/Section Loss',1140,8),
 (41,'Check/Shake',1150,8),
 (42,'Crack (Timber)',1160,8),
 (43,'Split/Delamination (Timber)',1170,8),
 (44,'Abrasion/Wear (Timber)',1180,8),
 (45,'Damage',7000,8),
 (46,'Delamination/ Spall/ Patched Area',1080,9),
 (47,'Exposed Rebar',1090,9),
 (48,'Efflorescence/ Rust Staining',1120,9),
 (49,'Cracking (RC and Other)',1130,9),
 (50,'Abrasion/Wear (PSC/RC)',1190,9),
 (51,'Damage',7000,9),
 (52,'Delamination/ Spall/ Patched Area',1080,10),
 (53,'Exposed Rebar',1090,10),
 (54,'Exposed Prestressing',1100,10),
 (55,'Cracking (PSC)',1110,10),
 (56,'Efflorescence/ Rust Staining',1120,10),
 (57,'Abrasion/Wear (PSC/RC)',1190,10),
 (58,'Damage',7000,10),
 (59,'Connection',1020,11),
 (60,'Decay/Section Loss',1140,11),
 (61,'Check/Shake',1150,11),
 (62,'Crack (Timber)',1160,11),
 (63,'Split/Delamination (Timber)',1170,11),
 (64,'Abrasion/Wear (Timber)',1180,11),
 (65,'Damage',7000,11),
 (66,'Corrosion',1000,12),
 (67,'Fatigue Crack (Steel/Other)',1010,12),
 (68,'Connection',1020,12),
 (69,'Cracking (RC and Other)',1130,12),
 (70,'Delamination/ Spall/ Patched Area',1080,12),
 (71,'Efflorescence/ Rust Staining',1120,12),
 (72,'Deterioration (Other)',1220,12),
 (73,'Damage',7000,12),
 (74,'Corrosion',1000,13),
 (75,'Fatigue Crack (Steel/Other)',1010,13),
 (76,'Connection',1020,13),
 (77,'Delamination/ Spall/ Patched Area',1080,13),
 (78,'Cracking (RC and Other)',1130,13),
 (79,'Deterioration (Other)',1220,13),
 (80,'Efflorescence/ Rust Staining',1120,13),
 (81,'Damage',7000,13),
 (82,'Corrosion',1000,14),
 (83,'Fatigue Crack (Steel/Other)',1010,14),
 (84,'Connection',1020,14),
 (85,'Distortion',1900,14),
 (86,'Damage',7000,14),
 (87,'Delamination/ Spall/ Patched Area',1080,15),
 (88,'Exposed Rebar',1090,15),
 (89,'Efflorescence/ Rust Staining',1120,15),
 (90,'Cracking (RC and Other)',1130,15),
 (91,'Abrasion/Wear (PSC/RC)',1190,15),
 (92,'Damage',7000,15),
 (93,'Connection',1020,16),
 (94,'Decay/Section Loss',1140,16),
 (95,'Check/Shake',1150,16),
 (96,'Crack (Timber)',1160,16),
 (97,'Split/Delamination (Timber)',1170,16),
 (98,'Abrasion/Wear (Timber)',1180,16),
 (99,'Damage',7000,16),
 (100,'Corrosion',1000,17),
 (101,'Fatigue Crack (Steel/Other)',1010,17),
 (102,'Connection',1020,17),
 (103,'Efflorescence/ Rust Staining',1120,17),
 (104,'Cracking (RC and Other)',1130,17),
 (105,'Abrasion/Wear (PSC/RC)',1190,17),
 (106,'Delamination/ Spall/ Patched Area',1080,17),
 (107,'Exposed Rebar',1090,17),
 (108,'Deterioration (Other)',1220,17),
 (109,'Distortion',1900,17),
 (110,'Damage',7000,17),
 (111,'Efflorescence/ Rust Staining',1120,18),
 (112,'Mortar Breakdown (Masonry)',1610,18),
 (113,'Delamination/ Spall/ Patched Area',1080,18),
 (114,'Split/Spall (Masonry)',1620,18),
 (115,'Patched Area (Masonry)',1630,18),
 (116,'Masonry Displacement',1640,18),
 (117,'Distortion',1900,18),
 (118,'Damage',7000,18),
 (119,'Corrosion',1000,19),
 (120,'Fatigue Crack (Steel/Other)',1010,19),
 (121,'Connection',1020,19),
 (122,'Distortion',1900,19),
 (123,'Damage',7000,19),
 (124,'Delamination/ Spall/ Patched Area',1080,20),
 (125,'Exposed Rebar',1090,20),
 (126,'Exposed Prestressing',1100,20),
 (127,'Cracking (PSC)',1110,20),
 (128,'Efflorescence/ Rust Staining',1120,20),
 (129,'Damage',7000,20),
 (130,'Delamination/ Spall/ Patched Area',1080,21),
 (131,'Exposed Rebar',1090,21),
 (132,'Efflorescence/ Rust Staining',1120,21),
 (133,'Cracking (RC and Other)',1130,21),
 (134,'Damage',7000,21),
 (135,'Corrosion',1000,22),
 (136,'Fatigue Crack (Steel/Other)',1010,22),
 (137,'Connection',1020,22),
 (138,'Delamination/ Spall/ Patched Area',1080,22),
 (139,'Efflorescence/ Rust Staining',1120,22),
 (140,'Cracking (RC and Other)',1130,22),
 (141,'Deterioration (Other)',1220,22),
 (142,'Distortion',1900,22),
 (143,'Damage',7000,22),
 (144,'Corrosion',1000,23),
 (145,'Fatigue Crack (Steel/Other)',1010,23),
 (146,'Connection',1020,23),
 (147,'Distortion',1900,23),
 (148,'Damage',7000,23),
 (149,'Delamination/ Spall/ Patched Area',1080,24),
 (150,'Exposed Rebar',1090,24),
 (151,'Exposed Prestressing',1100,24),
 (152,'Cracking (PSC)',1110,24),
 (153,'Efflorescence/ Rust Staining',1120,24),
 (154,'Damage',7000,24),
 (155,'Delamination/ Spall/ Patched Area',1080,25),
 (156,'Exposed Rebar',1090,25),
 (157,'Efflorescence/ Rust Staining',1120,25),
 (158,'Cracking (RC and Other)',1130,25),
 (159,'Damage',7000,25),
 (160,'Connection',1020,26),
 (161,'Decay/Section Loss',1140,26),
 (162,'Check/Shake',1150,26),
 (163,'Crack (Timber)',1160,26),
 (164,'Split/Delamination (Timber)',1170,26),
 (165,'Abrasion/Wear (Timber)',1180,26),
 (166,'Damage',7000,26),
 (167,'Corrosion',1000,27),
 (168,'Fatigue Crack (Steel/Other)',1010,27),
 (169,'Connection',1020,27),
 (170,'Delamination/ Spall/ Patched Area',1080,27),
 (171,'Efflorescence/ Rust Staining',1120,27),
 (172,'Cracking (RC and Other)',1130,27),
 (173,'Deterioration (Other)',1220,27),
 (174,'Distortion',1900,27),
 (175,'Damage',7000,27),
 (176,'Corrosion',1000,28),
 (177,'Fatigue Crack (Steel/Other)',1010,28),
 (178,'Connection',1020,28),
 (179,'Distortion',1900,28),
 (180,'Damage',7000,28),
 (181,'Connection',1020,29),
 (182,'Decay/Section Loss',1140,29),
 (183,'Check/Shake',1150,29),
 (184,'Crack (Timber)',1160,29),
 (185,'Split/Delamination (Timber)',1170,29),
 (186,'Abrasion/Wear (Timber)',1180,29),
 (187,'Damage',7000,29),
 (188,'Corrosion',1000,30),
 (189,'Fatigue Crack (Steel/Other)',1010,30),
 (190,'Connection',1020,30),
 (191,'Delamination/ Spall/ Patched Area',1080,30),
 (192,'Efflorescence/ Rust Staining',1120,30),
 (193,'Cracking (RC and Other)',1130,30),
 (194,'Deterioration (Other)',1220,30),
 (195,'Distortion',1900,30),
 (196,'Damage',7000,30),
 (197,'Corrosion',1000,31),
 (198,'Fatigue Crack (Steel/Other)',1010,31),
 (199,'Connection',1020,31),
 (200,'Distortion',1900,31),
 (201,'Damage',7000,31),
 (202,'Corrosion',1000,32),
 (203,'Fatigue Crack (Steel/Other)',1010,32),
 (204,'Connection',1020,32),
 (205,'Cracking (RC and Other)',1130,32),
 (206,'Deterioration (Other)',1220,32),
 (207,'Distortion',1900,32),
 (208,'Delamination/ Spall/ Patched Area',1080,32),
 (209,'Efflorescence/ Rust Staining',1120,32),
 (210,'Damage',7000,32),
 (211,'Delamination/ Spall/ Patched Area',1080,33),
 (212,'Exposed Rebar',1090,33),
 (213,'Exposed Prestressing',1100,33),
 (214,'Cracking (PSC)',1110,33),
 (215,'Efflorescence/ Rust Staining',1120,33),
 (216,'Abrasion/Wear (PSC/RC)',1190,33),
 (217,'Damage',7000,33),
 (218,'Delamination/ Spall/ Patched Area',1080,34),
 (219,'Exposed Rebar',1090,34),
 (220,'Efflorescence/ Rust Staining',1120,34),
 (221,'Cracking (RC and Other)',1130,34),
 (222,'Abrasion/Wear (PSC/RC)',1190,34),
 (223,'Damage',7000,34),
 (224,'Efflorescence/ Rust Staining',1120,35),
 (225,'Mortar Breakdown (Masonry)',1610,35),
 (226,'Split/Spall (Masonry)',1620,35),
 (227,'Patched Area (Masonry)',1630,35),
 (228,'Masonry Displacement',1640,35),
 (229,'Damage',7000,35),
 (230,'Connection',1020,36),
 (231,'Decay/Section Loss',1140,36),
 (232,'Check/Shake',1150,36),
 (233,'Crack (Timber)',1160,36),
 (234,'Split/Delamination (Timber)',1170,36),
 (235,'Abrasion/Wear (Timber)',1180,36),
 (236,'Damage',7000,36),
 (237,'Corrosion',1000,37),
 (238,'Fatigue Crack (Steel/Other)',1010,37),
 (239,'Connection',1020,37),
 (240,'Distortion',1900,37),
 (241,'Damage',7000,37),
 (242,'Delamination/ Spall/ Patched Area',1080,38),
 (243,'Exposed Rebar',1090,38),
 (244,'Exposed Prestressing',1100,38),
 (245,'Cracking (PSC)',1110,38),
 (246,'Efflorescence/ Rust Staining',1120,38),
 (247,'Damage',7000,38),
 (248,'Delamination/ Spall/ Patched Area',1080,39),
 (249,'Exposed Rebar',1090,39),
 (250,'Efflorescence/ Rust Staining',1120,39),
 (251,'Cracking (RC and Other)',1130,39),
 (252,'Damage',7000,39),
 (253,'Connection',1020,40),
 (254,'Decay/Section Loss',1140,40),
 (255,'Check/Shake',1150,40),
 (256,'Crack (Timber)',1160,40),
 (257,'Split/Delamination (Timber)',1170,40),
 (258,'Abrasion/Wear (Timber)',1180,40),
 (259,'Damage',7000,40),
 (260,'Corrosion',1000,41),
 (261,'Fatigue Crack (Steel/Other)',1010,41),
 (262,'Connection',1020,41),
 (263,'Delamination/ Spall/ Patched Area',1080,41),
 (264,'Efflorescence/ Rust Staining',1120,41),
 (265,'Cracking (RC and Other)',1130,41),
 (266,'Deterioration (Other)',1220,41),
 (267,'Distortion',1900,41),
 (268,'Damage',7000,41),
 (269,'Corrosion',1000,42),
 (270,'Fatigue Crack (Steel/Other)',1010,42),
 (271,'Connection',1020,42),
 (272,'Distortion',1900,42),
 (273,'Damage',7000,42),
 (274,'Delamination/ Spall/ Patched Area',1080,43),
 (275,'Exposed Rebar',1090,43),
 (276,'Exposed Prestressing',1100,43),
 (277,'Cracking (PSC)',1110,43),
 (278,'Efflorescence/ Rust Staining',1120,43),
 (279,'Damage',7000,43),
 (280,'Delamination/ Spall/ Patched Area',1080,44),
 (281,'Exposed Rebar',1090,44),
 (282,'Efflorescence/ Rust Staining',1120,44),
 (283,'Cracking (RC and Other)',1130,44),
 (284,'Damage',7000,44),
 (285,'Connection',1020,45),
 (286,'Decay/Section Loss',1140,45),
 (287,'Check/Shake',1150,45),
 (288,'Crack (Timber)',1160,45),
 (289,'Split/Delamination (Timber)',1170,45),
 (290,'Abrasion/Wear (Timber)',1180,45),
 (291,'Damage',7000,45),
 (292,'Corrosion',1000,46),
 (293,'Fatigue Crack (Steel/Other)',1010,46),
 (294,'Connection',1020,46),
 (295,'Delamination/ Spall/ Patched Area',1080,46),
 (296,'Efflorescence/ Rust Staining',1120,46),
 (297,'Cracking (RC and Other)',1130,46),
 (298,'Deterioration (Other)',1220,46),
 (299,'Distortion',1900,46),
 (300,'Damage',7000,46),
 (301,'Corrosion',1000,47),
 (302,'Fatigue Crack (Steel/Other)',1010,47),
 (303,'Connection',1020,47),
 (304,'Distortion',1900,47),
 (305,'Damage',7000,47),
 (306,'Corrosion',1000,48),
 (307,'Fatigue Crack (Steel/Other)',1010,48),
 (308,'Connection',1020,48),
 (309,'Distortion',1900,48),
 (310,'Damage',7000,48),
 (311,'Corrosion',1000,49),
 (312,'Fatigue Crack (Steel/Other)',1010,49),
 (313,'Connection',1020,49),
 (314,'Deterioration (Other)',1220,49),
 (315,'Distortion',1900,49),
 (316,'Damage',7000,49),
 (317,'Corrosion',1000,50),
 (318,'Fatigue Crack (Steel/Other)',1010,50),
 (319,'Connection',1020,50),
 (320,'Distortion',1900,50),
 (321,'Damage',7000,50),
 (322,'Corrosion',1000,51),
 (323,'Fatigue Crack (Steel/Other)',1010,51),
 (324,'Connection',1020,51),
 (325,'Distortion',1900,51),
 (326,'Damage',7000,51),
 (327,'Corrosion',1000,52),
 (328,'Fatigue Crack (Steel/Other)',1010,52),
 (329,'Connection',1020,52),
 (330,'Distortion',1900,52),
 (331,'Damage',7000,52),
 (332,'Corrosion',1000,53),
 (333,'Fatigue Crack (Steel/Other)',1010,53),
 (334,'Connection',1020,53),
 (335,'Distortion',1900,53),
 (336,'Damage',7000,53),
 (337,'Corrosion',1000,54),
 (338,'Fatigue Crack (Steel/Other)',1010,54),
 (339,'Connection',1020,54),
 (340,'Distortion',1900,54),
 (341,'Cable Slack',1025,54),
 (342,'Damage',7000,54),
 (343,'Corrosion',1000,55),
 (344,'Fatigue Crack (Steel/Other)',1010,55),
 (345,'Connection',1020,55),
 (346,'Distortion',1900,55),
 (347,'Cable Slack',1025,55),
 (348,'Damage',7000,55),
 (349,'Corrosion',1000,56),
 (350,'Fatigue Crack (Steel/Other)',1010,56),
 (351,'Connection',1020,56),
 (352,'Distortion',1900,56),
 (353,'Cable Slack',1025,56),
 (354,'Damage',7000,56),
 (355,'Corrosion',1000,57),
 (356,'Connection',1020,57),
 (357,'Movement',2210,57),
 (358,'Alignment',2220,57),
 (359,'Bulging, Splitting or Tearing',2230,57),
 (360,'Loss of Bearing Area',2240,57),
 (361,'Damage',7000,57),
 (362,'Corrosion',1000,58),
 (363,'Connection',1020,58),
 (364,'Movement',2210,58),
 (365,'Alignment',2220,58),
 (366,'Loss of Bearing Area',2240,58),
 (367,'Damage',7000,58),
 (368,'Corrosion',1000,59),
 (369,'Connection',1020,59),
 (370,'Movement',2210,59),
 (371,'Alignment',2220,59),
 (372,'Loss of Bearing Area',2240,59),
 (373,'Damage',7000,59),
 (374,'Corrosion',1000,60),
 (375,'Connection',1020,60),
 (376,'Movement',2210,60),
 (377,'Alignment',2220,60),
 (378,'Loss of Bearing Area',2240,60),
 (379,'Damage',7000,60),
 (380,'Corrosion',1000,61),
 (381,'Connection',1020,61),
 (382,'Movement',2210,61),
 (383,'Alignment',2220,61),
 (384,'Bulging, Splitting or Tearing',2230,61),
 (385,'Loss of Bearing Area',2240,61),
 (386,'Damage',7000,61),
 (387,'Corrosion',1000,62),
 (388,'Connection',1020,62),
 (389,'Movement',2210,62),
 (390,'Alignment',2220,62),
 (391,'Loss of Bearing Area',2240,62),
 (392,'Damage',7000,62),
 (393,'Corrosion',1000,63),
 (394,'Connection',1020,63),
 (395,'Movement',2210,63),
 (396,'Alignment',2220,63),
 (397,'Loss of Bearing Area',2240,63),
 (398,'Damage',7000,63),
 (399,'Delamination/ Spall/ Patched Area',1080,64),
 (400,'Exposed Rebar',1090,64),
 (401,'Efflorescence/ Rust Staining',1120,64),
 (402,'Cracking (RC and Other)',1130,64),
 (403,'Abrasion/Wear (PSC/RC)',1190,64),
 (404,'Settlement',4000,64),
 (405,'Scour',6000,64),
 (406,'Damage',7000,64),
 (407,'Connection',1020,65),
 (408,'Decay/Section Loss',1140,65),
 (409,'Check/Shake',1150,65),
 (410,'Crack (Timber)',1160,65),
 (411,'Split/Delamination (Timber)',1170,65),
 (412,'Abrasion/Wear (Timber)',1180,65),
 (413,'Settlement',4000,65),
 (414,'Scour',6000,65),
 (415,'Damage',7000,65),
 (416,'Efflorescence/ Rust Staining',1120,66),
 (417,'Mortar Breakdown (Masonry)',1610,66),
 (418,'Split/Spall (Masonry)',1620,66),
 (419,'Patched Area (Masonry)',1630,66),
 (420,'Masonry Displacement',1640,66),
 (421,'Settlement',4000,66),
 (422,'Scour',6000,66),
 (423,'Damage',7000,66),
 (424,'Corrosion',1000,67),
 (425,'Fatigue Crack (Steel/Other)',1010,67),
 (426,'Connection',1020,67),
 (427,'Cracking (RC and Other)',1130,67),
 (428,'Deterioration (Other)',1220,67),
 (429,'Distortion',1900,67),
 (430,'Delamination/ Spall/ Patched Area',1080,67),
 (431,'Efflorescence/ Rust Staining',1120,67),
 (432,'Settlement',4000,67),
 (433,'Scour',6000,67),
 (434,'Damage',7000,67),
 (435,'Corrosion',1000,68),
 (436,'Fatigue Crack (Steel/Other)',1010,68),
 (437,'Connection',1020,68),
 (438,'Distortion',1900,68),
 (439,'Settlement',4000,68),
 (440,'Scour',6000,68),
 (441,'Damage',7000,68),
 (442,'Corrosion',1000,69),
 (443,'Fatigue Crack (Steel/Other)',1010,69),
 (444,'Connection',1020,69),
 (445,'Distortion',1900,69),
 (446,'Damage',7000,69),
 (447,'Delamination/ Spall/ Patched Area',1080,70),
 (448,'Exposed Rebar',1090,70),
 (449,'Exposed Prestressing',1100,70),
 (450,'Cracking (PSC)',1110,70),
 (451,'Efflorescence/ Rust Staining',1120,70),
 (452,'Damage',7000,70),
 (453,'Delamination/ Spall/ Patched Area',1080,71),
 (454,'Exposed Rebar',1090,71),
 (455,'Efflorescence/ Rust Staining',1120,71),
 (456,'Cracking (RC and Other)',1130,71),
 (457,'Damage',7000,71),
 (458,'Connection',1020,72),
 (459,'Decay/Section Loss',1140,72),
 (460,'Check/Shake',1150,72),
 (461,'Crack (Timber)',1160,72),
 (462,'Split/Delamination (Timber)',1170,72),
 (463,'Abrasion/Wear (Timber)',1180,72),
 (464,'Damage',7000,72),
 (465,'Corrosion',1000,73),
 (466,'Fatigue Crack (Steel/Other)',1010,73),
 (467,'Connection',1020,73),
 (468,'Cracking (RC and Other)',1130,73),
 (469,'Deterioration (Other)',1220,73),
 (470,'Distortion',1900,73),
 (471,'Delamination/ Spall/ Patched Area',1080,73),
 (472,'Efflorescence/ Rust Staining',1120,73),
 (473,'Damage',7000,73),
 (474,'Corrosion',1000,74),
 (475,'Fatigue Crack (Steel/Other)',1010,74),
 (476,'Connection',1020,74),
 (477,'Distortion',1900,74),
 (478,'Settlement',4000,74),
 (479,'Scour',6000,74),
 (480,'Damage',7000,74),
 (481,'Corrosion',1000,75),
 (482,'Fatigue Crack (Steel/Other)',1010,75),
 (483,'Connection',1020,75),
 (484,'Cracking (RC and Other)',1130,75),
 (485,'Deterioration (Other)',1220,75),
 (486,'Distortion',1900,75),
 (487,'Settlement',4000,75),
 (488,'Delamination/ Spall/ Patched Area',1080,75),
 (489,'Efflorescence/ Rust Staining',1120,75),
 (490,'Scour',6000,75),
 (491,'Damage',7000,75),
 (492,'Delamination/ Spall/ Patched Area',1080,76),
 (493,'Exposed Rebar',1090,76),
 (494,'Exposed Prestressing',1100,76),
 (495,'Cracking (PSC)',1110,76),
 (496,'Efflorescence/ Rust Staining',1120,76),
 (497,'Abrasion/Wear (PSC/RC)',1190,76),
 (498,'Settlement',4000,76),
 (499,'Scour',6000,76),
 (500,'Damage',7000,76),
 (501,'Delamination/ Spall/ Patched Area',1080,77),
 (502,'Exposed Rebar',1090,77),
 (503,'Efflorescence/ Rust Staining',1120,77),
 (504,'Cracking (RC and Other)',1130,77),
 (505,'Abrasion/Wear (PSC/RC)',1190,77),
 (506,'Settlement',4000,77),
 (507,'Scour',6000,77),
 (508,'Damage',7000,77),
 (509,'Connection',1020,78),
 (510,'Decay/Section Loss',1140,78),
 (511,'Check/Shake',1150,78),
 (512,'Crack (Timber)',1160,78),
 (513,'Split/Delamination (Timber)',1170,78),
 (514,'Abrasion/Wear (Timber)',1180,78),
 (515,'Settlement',4000,78),
 (516,'Scour',6000,78),
 (517,'Damage',7000,78),
 (518,'Corrosion',1000,79),
 (519,'Fatigue Crack (Steel/Other)',1010,79),
 (520,'Connection',1020,79),
 (521,'Distortion',1900,79),
 (522,'Settlement',4000,79),
 (523,'Scour',6000,79),
 (524,'Damage',7000,79),
 (525,'Connection',1020,80),
 (526,'Decay/Section Loss',1140,80),
 (527,'Check/Shake',1150,80),
 (528,'Crack (Timber)',1160,80),
 (529,'Split/Delamination (Timber)',1170,80),
 (530,'Abrasion/Wear (Timber)',1180,80),
 (531,'Settlement',4000,80),
 (532,'Scour',6000,80),
 (533,'Damage',7000,80),
 (534,'Delamination/ Spall/ Patched Area',1080,81),
 (535,'Exposed Rebar',1090,81),
 (536,'Efflorescence/ Rust Staining',1120,81),
 (537,'Cracking (RC and Other)',1130,81),
 (538,'Abrasion/Wear (PSC/RC)',1190,81),
 (539,'Settlement',4000,81),
 (540,'Scour',6000,81),
 (541,'Damage',7000,81),
 (542,'Corrosion',1000,82),
 (543,'Fatigue Crack (Steel/Other)',1010,82),
 (544,'Connection',1020,82),
 (545,'Cracking (RC and Other)',1130,82),
 (546,'Deterioration (Other)',1220,82),
 (547,'Distortion',1900,82),
 (548,'Settlement',4000,82),
 (549,'Delamination/ Spall/ Patched Area',1080,82),
 (550,'Efflorescence/ Rust Staining',1120,82),
 (551,'Scour',6000,82),
 (552,'Damage',7000,82),
 (553,'Connection',1020,83),
 (554,'Decay/Section Loss',1140,83),
 (555,'Check/Shake',1150,83),
 (556,'Crack (Timber)',1160,83),
 (557,'Split/Delamination (Timber)',1170,83),
 (558,'Abrasion/Wear (Timber)',1180,83),
 (559,'Settlement',4000,83),
 (560,'Scour',6000,83),
 (561,'Damage',7000,83),
 (562,'Efflorescence/ Rust Staining',1120,84),
 (563,'Mortar Breakdown (Masonry)',1610,84),
 (564,'Split/Spall (Masonry)',1620,84),
 (565,'Patched Area (Masonry)',1630,84),
 (566,'Masonry Displacement',1640,84),
 (567,'Settlement',4000,84),
 (568,'Scour',6000,84),
 (569,'Damage',7000,84),
 (570,'Delamination/ Spall/ Patched Area',1080,85),
 (571,'Exposed Rebar',1090,85),
 (572,'Efflorescence/ Rust Staining',1120,85),
 (573,'Cracking (RC and Other)',1130,85),
 (574,'Abrasion/Wear (PSC/RC)',1190,85),
 (575,'Settlement',4000,85),
 (576,'Scour',6000,85),
 (577,'Damage',7000,85),
 (578,'Distortion',1900,86),
 (579,'Settlement',4000,86),
 (580,'Fatigue Crack (Steel/Other)',1010,86),
 (581,'Scour',6000,86),
 (582,'Corrosion',1000,86),
 (583,'Connection',1020,86),
 (584,'Damage',7000,86),
 (585,'Delamination/ Spall/ Patched Area',1080,87),
 (586,'Exposed Rebar',1090,87),
 (587,'Exposed Prestressing',1100,87),
 (588,'Abrasion/Wear (PSC/RC)',1190,87),
 (589,'Settlement',4000,87),
 (590,'Cracking (PSC)',1110,87),
 (591,'Efflorescence/ Rust Staining',1120,87),
 (592,'Scour',6000,87),
 (593,'Damage',7000,87),
 (594,'Delamination/ Spall/ Patched Area',1080,88),
 (595,'Exposed Rebar',1090,88),
 (596,'Efflorescence/ Rust Staining',1120,88),
 (597,'Cracking (RC and Other)',1130,88),
 (598,'Abrasion/Wear (PSC/RC)',1190,88),
 (599,'Settlement',4000,88),
 (600,'Scour',6000,88),
 (601,'Damage',7000,88),
 (602,'Connection',1020,89),
 (603,'Decay/Section Loss',1140,89),
 (604,'Check/Shake',1150,89),
 (605,'Crack (Timber)',1160,89),
 (606,'Split/Delamination (Timber)',1170,89),
 (607,'Abrasion/Wear (Timber)',1180,89),
 (608,'Settlement',4000,89),
 (609,'Scour',6000,89),
 (610,'Damage',7000,89),
 (611,'Corrosion',1000,90),
 (612,'Fatigue Crack (Steel/Other)',1010,90),
 (613,'Connection',1020,90),
 (614,'Cracking (RC and Other)',1130,90),
 (615,'Deterioration (Other)',1220,90),
 (616,'Distortion',1900,90),
 (617,'Delamination/ Spall/ Patched Area',1080,90),
 (618,'Efflorescence/ Rust Staining',1120,90),
 (619,'Settlement',4000,90),
 (620,'Scour',6000,90),
 (621,'Damage',7000,90),
 (622,'Corrosion',1000,91),
 (623,'Fatigue Crack (Steel/Other)',1010,91),
 (624,'Connection',1020,91),
 (625,'Distortion',1900,91),
 (626,'Settlement',4000,91),
 (627,'Scour',6000,91),
 (628,'Damage',7000,91),
 (629,'Corrosion',1000,92),
 (630,'Cracking (RC and Other)',1130,92),
 (631,'Settlement',4000,92),
 (632,'Distortion',1900,92),
 (633,'Scour',6000,92),
 (634,'Damage',7000,92),
 (635,'Corrosion',1000,93),
 (636,'Fatigue Crack (Steel/Other)',1010,93),
 (637,'Connection',1020,93),
 (638,'Distortion',1900,93),
 (639,'Damage',7000,93),
 (640,'Corrosion',1000,94),
 (641,'Fatigue Crack (Steel/Other)',1010,94),
 (642,'Connection',1020,94),
 (643,'Distortion',1900,94),
 (644,'Damage',7000,94),
 (645,'Delamination/ Spall/ Patched Area',1080,95),
 (646,'Exposed Rebar',1090,95),
 (647,'Deterioration (Other)',1220,95),
 (648,'Cracking (RC and Other)',1130,95),
 (649,'Settlement',4000,95),
 (650,'Scour',6000,95),
 (651,'Damage',7000,95),
 (652,'Distortion',1900,96),
 (653,'Settlement',4000,96),
 (654,'Fatigue Crack (Steel/Other)',1010,96),
 (655,'Scour',6000,96),
 (656,'Corrosion',1000,96),
 (657,'Connection',1020,96),
 (658,'Damage',7000,96),
 (659,'Delamination/ Spall/ Patched Area',1080,97),
 (660,'Exposed Rebar',1090,97),
 (661,'Efflorescence/ Rust Staining',1120,97),
 (662,'Cracking (RC and Other)',1130,97),
 (663,'Abrasion/Wear (PSC/RC)',1190,97),
 (664,'Distortion',1900,97),
 (665,'Settlement',4000,97),
 (666,'Scour',6000,97),
 (667,'Damage',7000,97),
 (668,'Connection',1020,98),
 (669,'Decay/Section Loss',1140,98),
 (670,'Check/Shake',1150,98),
 (671,'Crack (Timber)',1160,98),
 (672,'Split/Delamination (Timber)',1170,98),
 (673,'Abrasion/Wear (Timber)',1180,98),
 (674,'Distortion',1900,98),
 (675,'Settlement',4000,98),
 (676,'Scour',6000,98),
 (677,'Damage',7000,98),
 (678,'Corrosion',1000,99),
 (679,'Fatigue Crack (Steel/Other)',1010,99),
 (680,'Connection',1020,99),
 (681,'Delamination/ Spall/ Patched Area',1080,99),
 (682,'Efflorescence/ Rust Staining',1120,99),
 (683,'Cracking (RC and Other)',1130,99),
 (684,'Deterioration (Other)',1220,99),
 (685,'Distortion',1900,99),
 (686,'Settlement',4000,99),
 (687,'Scour',6000,99),
 (688,'Damage',7000,99),
 (689,'Efflorescence/ Rust Staining',1120,100),
 (690,'Mortar Breakdown (Masonry)',1610,100),
 (691,'Split/Spall (Masonry)',1620,100),
 (692,'Patched Area (Masonry)',1630,100),
 (693,'Masonry Displacement',1640,100),
 (694,'Distortion',1900,100),
 (695,'Settlement',4000,100),
 (696,'Scour',6000,100),
 (697,'Damage',7000,100),
 (698,'Delamination/ Spall/ Patched Area',1080,101),
 (699,'Exposed Rebar',1090,101),
 (700,'Exposed Prestressing',1100,101),
 (701,'Cracking (PSC)',1110,101),
 (702,'Efflorescence/ Rust Staining',1120,101),
 (703,'Abrasion/Wear (PSC/RC)',1190,101),
 (704,'Distortion',1900,101),
 (705,'Settlement',4000,101),
 (706,'Scour',6000,101),
 (707,'Damage',7000,101),
 (708,'Leakage',2310,102),
 (709,'Seal Adhesion',2320,102),
 (710,'Seal Damage',2330,102),
 (711,'Seal Cracking',2340,102),
 (712,'Debris Impaction',2350,102),
 (713,'Adjacent Deck or Header',2360,102),
 (714,'Metal Deterioration or Damage',2370,102),
 (715,'Damage',7000,102),
 (716,'Leakage',2310,103),
 (717,'Seal Adhesion',2320,103),
 (718,'Seal Damage',2330,103),
 (719,'Seal Cracking',2340,103),
 (720,'Debris Impaction',2350,103),
 (721,'Adjacent Deck or Header',2360,103),
 (722,'Damage',7000,103),
 (723,'Leakage',2310,104),
 (724,'Seal Adhesion',2320,104),
 (725,'Seal Damage',2330,104),
 (726,'Seal Cracking',2340,104),
 (727,'Debris Impaction',2350,104),
 (728,'Adjacent Deck or Header',2360,104),
 (729,'Damage',7000,104),
 (730,'Leakage',2310,105),
 (731,'Seal Adhesion',2320,105),
 (732,'Seal Damage',2330,105),
 (733,'Seal Cracking',2340,105),
 (734,'Debris Impaction',2350,105),
 (735,'Adjacent Deck or Header',2360,105),
 (736,'Metal Deterioration or Damage',2370,105),
 (737,'Damage',7000,105),
 (738,'Debris Impaction',2350,106),
 (739,'Adjacent Deck or Header',2360,106),
 (740,'Damage',7000,106),
 (741,'Debris Impaction',2350,107),
 (742,'Adjacent Deck or Header',2360,107),
 (743,'Metal Deterioration or Damage',2370,107),
 (744,'Damage',7000,107),
 (745,'Leakage',2310,108),
 (746,'Debris Impaction',2350,108),
 (747,'Adjacent Deck or Header',2360,108),
 (748,'Metal Deterioration or Damage',2370,108),
 (749,'Damage',7000,108),
 (750,'Leakage',2310,109),
 (751,'Seal Adhesion',2320,109),
 (752,'Seal Adhesion',2320,109),
 (753,'Damage',7000,109),
 (754,'Debris Impaction',2350,110),
 (755,'Adjacent Deck or Header',2360,110),
 (756,'Metal Deterioration or Damage',2370,110),
 (757,'Damage',7000,110),
 (758,'Debris Impaction',2350,111),
 (759,'Adjacent Deck or Header',2360,111),
 (760,'Metal Deterioration or Damage',2370,111),
 (761,'Damage',7000,111),
 (762,'Delamination/ Spall/ Patched Area',1080,112),
 (763,'Exposed Rebar',1090,112),
 (764,'Exposed Prestressing',1100,112),
 (765,'Cracking (PSC)',1110,112),
 (766,'Abrasion/Wear (PSC/RC)',1190,112),
 (767,'Settlement',4000,112),
 (768,'Damage',7000,112),
 (769,'Delamination/ Spall/ Patched Area',1080,113),
 (770,'Exposed Rebar',1090,113),
 (771,'Cracking (RC and Other)',1130,113),
 (772,'Abrasion/Wear (PSC/RC)',1190,113),
 (773,'Settlement',4000,113),
 (774,'Damage',7000,113),
 (775,'Delamination/ Patched Area/ Pothole (Wearing Surfaces)',3210,114),
 (776,'Crack (Wearing Surface)',3220,114),
 (777,'Effectiveness (Wearing Surface)',3230,114),
 (778,'Damage',7000,114),
 (779,'Delamination/ Patched Area/ Pothole (Wearing Surfaces)',3210,115),
 (780,'Crack (Wearing Surface)',3220,115),
 (781,'Effectiveness (Wearing Surface)',3230,115),
 (782,'Damage',7000,115),
 (783,'Delamination/ Patched Area/ Pothole (Wearing Surfaces)',3210,116),
 (784,'Crack (Wearing Surface)',3220,116),
 (785,'Effectiveness (Wearing Surface)',3230,116),
 (786,'Damage',7000,116),
 (787,'Connection',1020,117),
 (788,'Decay/Section Loss',1140,117),
 (789,'Check/Shake',1150,117),
 (790,'Crack (Timber)',1160,117),
 (791,'Split/Delamination (Timber)',1170,117),
 (792,'Abrasion/Wear (Timber)',1180,117),
 (793,'Damage',7000,117),
 (794,'Chalking
(Steel Protective Coatings)',3410,118),
 (795,'Peeling/Bubbling/Cracking (Steel Protective Coatings)',3420,118),
 (796,'Effectiveness
(Steel Protective Coatings)',3440,118),
 (797,'Damage',7000,118),
 (798,'Peeling/Bubbling/Cracking (Steel Protective Coatings)',3420,119),
 (799,'Oxide Film Degradation Color/ Texture Adherence (Steel Protective Coatings)',3430,119),
 (800,'Effectiveness
(Steel Protective Coatings)',3440,119),
 (801,'Damage',7000,119),
 (802,'Peeling/Bubbling/Cracking (Steel Protective Coatings)',3420,120),
 (803,'Oxide Film Degradation Color/ Texture Adherence (Steel Protective Coatings)',3430,120),
 (804,'Effectiveness
(Steel Protective Coatings)',3440,120),
 (805,'Damage',7000,120),
 (806,'Effectiveness (Rebar Protective System- Coating/Cathodic)',3600,121),
 (807,'Damage',7000,121),
 (808,'Wear
(Concrete Protective Coatings)',3510,122),
 (809,'Effectiveness (Concrete Protective Coatings)',3540,122),
 (810,'Damage',7000,122),
 (811,'Wear
(Concrete Protective Coatings)',3510,123),
 (812,'Effectiveness (Concrete Protective Coatings)',3540,123),
 (813,'Damage',7000,123),
 (814,'Corrosion',NULL,124),
 (815,'Cracking',NULL,124),
 (816,'Connection',NULL,124),
 (817,'Distortion',NULL,124),
 (818,'Leakage',NULL,124),
 (819,'Delamination/ Spall/ Patched area',NULL,125),
 (820,'Exposed Rebar',NULL,125),
 (821,'Efflorescence/ Rust Staining',NULL,125),
 (822,'Cracking (Liners)',NULL,125),
 (823,'Distortion',NULL,125),
 (824,'Leakage',NULL,125),
 (825,'Delamination/ Spall/ Patched area',NULL,126),
 (826,'Exposed Rebar',NULL,126),
 (827,'Efflorescence/ Rust Staining',NULL,126),
 (828,'Cracking (Liners)',NULL,126),
 (829,'Distortion',NULL,126),
 (830,'Leakage',NULL,126),
 (831,'Delamination/ Spall/ Patched area',NULL,127),
 (832,'Exposed Rebar',NULL,127),
 (833,'Efflorescence/ Rust Staining',NULL,127),
 (834,'Cracking (Liners)',NULL,127),
 (835,'Distortion',NULL,127),
 (836,'Leakage',NULL,127),
 (837,'Decay or Rot',NULL,128),
 (838,'Voids',NULL,128),
 (839,'Cracks/ Splits/ Checks/',NULL,128),
 (840,'Timber Distortion',NULL,128),
 (841,'Insect Infestation',NULL,128),
 (842,'Loose or Missing Connectors',NULL,128),
 (843,'Leakage',NULL,128),
 (844,'Efflorescence/ Rust Staining',NULL,129),
 (845,'Mortar Breakdown',NULL,129),
 (846,'Split/Spall',NULL,129),
 (847,'Patched Area',NULL,129),
 (848,'Masonry Displacement',NULL,129),
 (849,'Distortion',NULL,129),
 (850,'Leakage',NULL,129),
 (851,'Rockfall',NULL,130),
 (852,'Patched Areas',NULL,130),
 (853,'Leakage',NULL,130),
 (854,'Loose Bolt/Dowel Misalignment',NULL,131),
 (855,'Deformation or Cracking',NULL,131),
 (856,'Cracking',NULL,132),
 (857,'Distortion',NULL,132),
 (858,'Patched Areas',NULL,132),
 (859,'Leakage',NULL,132),
 (860,'Corrosion',NULL,133),
 (861,'Cracking',NULL,133),
 (862,'Connection',NULL,133),
 (863,'Distortion',NULL,133),
 (864,'Delamination/ Spall/ Patched area',NULL,134),
 (865,'Exposed Rebar',NULL,134),
 (866,'Efflorescence/ Rust Staining',NULL,134),
 (867,'Cracking',NULL,134),
 (868,'Delamination/ Spall/ Patched area',NULL,135),
 (869,'Exposed Rebar',NULL,135),
 (870,'Exposed Prestressing',NULL,135),
 (871,'Cracking',NULL,135),
 (872,'Efflorescence/ Rust Staining',NULL,135),
 (873,'General Condition',NULL,136),
 (874,'Corrosion',NULL,137),
 (875,'Cracking',NULL,137),
 (876,'Connection',NULL,137),
 (877,'Distortion',NULL,137),
 (878,'Delamination/ Spall/ Patched area',NULL,138),
 (879,'Exposed Rebar',NULL,138),
 (880,'Efflorescence/ Rust Staining',NULL,138),
 (881,'Cracking',NULL,138),
 (882,'General Condition',NULL,139),
 (883,'Corrosion',NULL,140),
 (884,'Cracking',NULL,140),
 (885,'Connection',NULL,140),
 (886,'Distortion',NULL,140),
 (887,'Leakage',NULL,140),
 (888,'Delamination/ Spall/ Patched area',NULL,141),
 (889,'Exposed Rebar',NULL,141),
 (890,'Efflorescence/ Rust Staining',NULL,141),
 (891,'Cracking (Liners)',NULL,141),
 (892,'Distortion',NULL,141),
 (893,'Leakage',NULL,141),
 (894,'Delamination/ Spall/ Patched area',NULL,142),
 (895,'Exposed Rebar',NULL,142),
 (896,'Efflorescence/ Rust Staining',NULL,142),
 (897,'Cracking (Liners)',NULL,142),
 (898,'Distortion',NULL,142),
 (899,'Leakage',NULL,142),
 (900,'Decay or Rot',NULL,143),
 (901,'Voids',NULL,143),
 (902,'Cracks/ Splits/ Checks/',NULL,143),
 (903,'Timber Distortion',NULL,143),
 (904,'Insect Infestation',NULL,143),
 (905,'Loose or Missing Connectors',NULL,143),
 (906,'Leakage',NULL,143),
 (907,'Efflorescence/ Rust Staining',NULL,144),
 (908,'Mortar Breakdown',NULL,144),
 (909,'Split/Spall',NULL,144),
 (910,'Patched Area',NULL,144),
 (911,'Masonry Displacement',NULL,144),
 (912,'Distortion',NULL,144),
 (913,'Leakage',NULL,144),
 (914,'Rockfall',NULL,145),
 (915,'Patched Areas',NULL,145),
 (916,'Leakage',NULL,145),
 (917,'Cracking',NULL,146),
 (918,'Distortion',NULL,146),
 (919,'Patched Areas',NULL,146),
 (920,'Leakage',NULL,146),
 (921,'Delamination/ Spall/ Patched area',NULL,147),
 (922,'Exposed Rebar',NULL,147),
 (923,'Efflorescence/ Rust Staining',NULL,147),
 (924,'Cracking (Liners)',NULL,147),
 (925,'General Condition',NULL,148),
 (926,'Delamination/ Spall/ Patched area',NULL,149),
 (927,'Exposed Rebar',NULL,149),
 (928,'Efflorescence/ Rust Staining',NULL,149),
 (929,'Cracking (Liners)',NULL,149),
 (930,'Settlement',NULL,149),
 (931,'Efflorescence/ Rust Staining',NULL,150),
 (932,'Mortar Breakdown',NULL,150),
 (933,'Split/Spall',NULL,150),
 (934,'Patched Area',NULL,150),
 (935,'Masonry Displacement',NULL,150),
 (936,'Settlement',NULL,150),
 (937,'General Condition',NULL,151),
 (938,'Settlement',NULL,151),
 (939,'Delamination/ Spall/ Patched area',NULL,152),
 (940,'Exposed Rebar',NULL,152),
 (941,'Efflorescence',NULL,152),
 (942,'Cracking',NULL,152),
 (943,'General Condition',NULL,153),
 (944,'Corrosion',NULL,154),
 (945,'Cracking',NULL,154),
 (946,'Connection',NULL,154),
 (947,'Distortion',NULL,154),
 (948,'Delamination/ Spall/ Patched area',NULL,155),
 (949,'Exposed Rebar',NULL,155),
 (950,'Efflorescence/ Rust Staining',NULL,155),
 (951,'Cracking',NULL,155),
 (952,'Delamination/ Spall/ Patched area',NULL,156),
 (953,'Exposed Rebar',NULL,156),
 (954,'Exposed Prestressing',NULL,156),
 (955,'Cracking',NULL,156),
 (956,'Efflorescence/ Rust Staining',NULL,156),
 (957,'General Condition',NULL,157),
 (958,'Corrosion',NULL,158),
 (959,'Cracking',NULL,158),
 (960,'Connection',NULL,158),
 (961,'Bowing and Elongation',NULL,158),
 (962,'Creep',NULL,158),
 (963,'Anchorage area',NULL,158),
 (964,'General Condition',NULL,159),
 (965,'Connections',NULL,159),
 (966,'Bowing and Elongation',NULL,159),
 (967,'Creep',NULL,159),
 (968,'Anchorage area',NULL,159),
 (969,'Corrosion',NULL,160),
 (970,'Cracking',NULL,160),
 (971,'Connection',NULL,160),
 (972,'Distortion',NULL,160),
 (973,'Delamination/ Spall/ Patched area',NULL,161),
 (974,'Exposed Rebar',NULL,161),
 (975,'Efflorescence/ Rust Staining',NULL,161),
 (976,'Cracking',NULL,161),
 (977,'General Condition',NULL,162),
 (978,'Delamination/ Spall/ Patched area',NULL,163),
 (979,'Exposed Rebar',NULL,163),
 (980,'Efflorescence/ Rust Staining',NULL,163),
 (981,'Cracking',NULL,163),
 (982,'General Condition',NULL,164),
 (983,'Delamination/ Spall/ Patched area',NULL,165),
 (984,'Exposed Rebar',NULL,165),
 (985,'Cracking',NULL,165),
 (986,'Settlement',NULL,165),
 (987,'General Condition',NULL,166),
 (988,'Settlement',NULL,166),
 (989,'Corrosion',NULL,167),
 (990,'Cracking',NULL,167),
 (991,'Connection',NULL,167),
 (992,'Distortion',NULL,167),
 (993,'Delamination/ Spall/ Patched area',NULL,168),
 (994,'Exposed Rebar',NULL,168),
 (995,'Efflorescence',NULL,168),
 (996,'Cracking',NULL,168),
 (997,'Delamination/ Spall/ Patched area',NULL,169),
 (998,'Exposed Rebar',NULL,169),
 (999,'Exposed Prestressing',NULL,169),
 (1000,'Cracking',NULL,169),
 (1001,'Efflorescence/ Rust Staining',NULL,169),
 (1002,'General Condition',NULL,170),
 (1003,'Leakage',NULL,171),
 (1004,'Seal Adhesion',NULL,171),
 (1005,'Seal Damage',NULL,171),
 (1006,'Seal Cracking',NULL,171),
 (1007,'Debris Impaction',NULL,171),
 (1008,'Adjacent Deck or Header',NULL,171),
 (1009,'Metal Deterioration or Damage',NULL,171),
 (1010,'Leakage',NULL,172),
 (1011,'Seal Adhesion',NULL,172),
 (1012,'Seal Damage',NULL,172),
 (1013,'Seal Cracking',NULL,172),
 (1014,'Debris Impaction',NULL,172),
 (1015,'Adjacent Deck or Header',NULL,172),
 (1016,'Leakage',NULL,173),
 (1017,'Seal Adhesion',NULL,173),
 (1018,'Seal Damage',NULL,173),
 (1019,'Seal Cracking',NULL,173),
 (1020,'Debris Impaction',NULL,173),
 (1021,'Adjacent Deck or Header',NULL,173),
 (1022,'Leakage',NULL,174),
 (1023,'Seal Adhesion',NULL,174),
 (1024,'Seal Damage',NULL,174),
 (1025,'Seal Cracking',NULL,174),
 (1026,'Debris Impaction',NULL,174),
 (1027,'Adjacent Deck or Header',NULL,174),
 (1028,'Metal Deterioration or Damage',NULL,174),
 (1029,'Debris Impaction',NULL,175),
 (1030,'Adjacent Deck or Header',NULL,175),
 (1031,'Debris Impaction',NULL,176),
 (1032,'Adjacent Deck or Header',NULL,176),
 (1033,'Metal Deterioration or Damage',NULL,176),
 (1034,'Leakage',NULL,177),
 (1035,'Debris Impaction',NULL,177),
 (1036,'Adjacent Deck or Header',NULL,177),
 (1037,'Metal Deterioration or Damage',NULL,177),
 (1038,'Leakage',NULL,178),
 (1039,'Seal Adhesion',NULL,178),
 (1040,'Seal Damage',NULL,178),
 (1041,'Seal Cracking',NULL,178),
 (1042,'Debris Impaction',NULL,178),
 (1043,'Adjacent Deck or Header',NULL,178),
 (1044,'Metal Deterioration or Damage',NULL,178);
INSERT INTO conditions ("id","description","type","defect_id") VALUES (1,'None','GOOD',1),
 (2,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',1),
 (3,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',1),
 (4,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',1),
 (5,'None','GOOD',2),
 (6,'Present without measurable section loss.','FAIR',2),
 (7,'Present with measurable section loss, but does not warrant structural review.','POOR',2),
 (8,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',2),
 (9,'None','GOOD',3),
 (10,'Surface white without build-up or leaching without rust staining.','FAIR',3),
 (11,'Heavy build-up with rust staining.','POOR',3),
 (12,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',3),
 (13,'None or insignificant cracks.','GOOD',4),
 (14,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',4),
 (15,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',4),
 (16,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',4),
 (17,'No abrasion or wearing.','GOOD',5),
 (18,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',5),
 (19,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',5),
 (20,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',5),
 (21,'Not applicable','GOOD',6),
 (22,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',6),
 (23,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',6),
 (24,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',6),
 (25,'None','GOOD',7),
 (26,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',7),
 (27,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',7),
 (28,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',7),
 (29,'None','GOOD',8),
 (30,'Present without measurable section loss.','FAIR',8),
 (31,'Present with measurable section loss, but does not warrant structural review.','POOR',8),
 (32,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',8),
 (33,'None','GOOD',9),
 (34,'Present without section loss.','FAIR',9),
 (35,'Present with section loss, but does not warrant structural review.','POOR',9),
 (36,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',9),
 (37,'None or insignificant cracks.','GOOD',10),
 (38,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',10),
 (39,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',10),
 (40,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',10),
 (41,'None','GOOD',11),
 (42,'Surface white without build-up or leaching without rust staining.','FAIR',11),
 (43,'Heavy build-up with rust staining.','POOR',11),
 (44,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',11),
 (45,'No abrasion or wearing.','GOOD',12),
 (46,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',12),
 (47,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',12),
 (48,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',12),
 (49,'Not applicable','GOOD',13),
 (50,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',13),
 (51,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',13),
 (52,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',13),
 (53,'None','GOOD',14),
 (54,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',14),
 (55,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',14),
 (56,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',14),
 (57,'None','GOOD',15),
 (58,'Present without measurable section loss.','FAIR',15),
 (59,'Present with measurable section loss, but does not warrant structural review.','POOR',15),
 (60,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',15),
 (61,'None','GOOD',16),
 (62,'Present without section loss.','FAIR',16),
 (63,'Present with section loss, but does not warrant structural review.','POOR',16),
 (64,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',16),
 (65,'None or insignificant cracks.','GOOD',17),
 (66,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',17),
 (67,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',17),
 (68,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',17),
 (69,'None','GOOD',18),
 (70,'Surface white without build-up or leaching without rust staining.','FAIR',18),
 (71,'Heavy build-up with rust staining.','POOR',18),
 (72,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',18),
 (73,'No abrasion or wearing.','GOOD',19),
 (74,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',19),
 (75,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',19),
 (76,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',19),
 (77,'Not applicable','GOOD',20),
 (78,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',20),
 (79,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',20),
 (80,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',20),
 (81,'None','GOOD',21),
 (82,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',21),
 (83,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',21),
 (84,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',21),
 (85,'None','GOOD',22),
 (86,'Present without measurable section loss.','FAIR',22),
 (87,'Present with measurable section loss, but does not warrant structural review.','POOR',22),
 (88,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',22),
 (89,'None','GOOD',23),
 (90,'Surface white without build-up or leaching without rust staining.','FAIR',23),
 (91,'Heavy build-up with rust staining.','POOR',23),
 (92,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',23),
 (93,'None or insignificant cracks.','GOOD',24),
 (94,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',24),
 (95,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',24),
 (96,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',24),
 (97,'No abrasion or wearing.','GOOD',25),
 (98,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',25),
 (99,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',25),
 (100,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',25),
 (101,'Not applicable','GOOD',26),
 (102,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',26),
 (103,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',26),
 (104,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',26),
 (105,'None','GOOD',27),
 (106,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',27),
 (107,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',27),
 (108,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',27),
 (109,'None','GOOD',28),
 (110,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',28),
 (111,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',28),
 (112,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',28),
 (113,'Connection is in place and functioning as intended.','GOOD',29),
 (114,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',29),
 (115,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',29),
 (116,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',29),
 (117,'Not applicable','GOOD',30),
 (118,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',30),
 (119,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',30),
 (120,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',30),
 (121,'None','GOOD',31),
 (122,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',31),
 (123,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',31),
 (124,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',31),
 (125,'None','GOOD',32),
 (126,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',32),
 (127,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',32),
 (128,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',32),
 (129,'Connection is in place and functioning as intended.','GOOD',33),
 (130,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',33),
 (131,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',33),
 (132,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',33),
 (133,'Not applicable','GOOD',34),
 (134,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',34),
 (135,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',34),
 (136,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',34),
 (137,'None','GOOD',35),
 (138,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',35),
 (139,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',35),
 (140,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',35),
 (141,'None','GOOD',36),
 (142,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',36),
 (143,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',36),
 (144,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',36),
 (145,'Connection is in place and functioning as intended.','GOOD',37),
 (146,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',37),
 (147,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',37),
 (148,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',37),
 (149,'Not applicable','GOOD',38),
 (150,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',38),
 (151,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',38),
 (152,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',38),
 (153,'Connection is in place and functioning as intended.','GOOD',39),
 (154,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',39),
 (155,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',39),
 (156,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',39),
 (157,'None','GOOD',40),
 (158,'Affects less than 10% of the member section.','FAIR',40),
 (159,'Affects 10% or more of the member but does not warrant structural review.','POOR',40),
 (160,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',40),
 (161,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',41),
 (162,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',41),
 (163,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',41),
 (164,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',41),
 (165,'None','GOOD',42),
 (166,'Crack that has been arrested through effective measures.','FAIR',42),
 (167,'Identified crack exists that is not arrested, but does not require structural review','POOR',42),
 (168,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',42),
 (169,'None','GOOD',43),
 (170,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',43),
 (171,'Length equal to or greater than the member depth, but does not require structural review.','POOR',43),
 (172,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',43),
 (173,'None or no measurable section loss.','GOOD',44),
 (174,'Section loss less than 10% of the member thickness.','FAIR',44),
 (175,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',44),
 (176,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',44),
 (177,'Not applicable','GOOD',45),
 (178,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',45),
 (179,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',45),
 (180,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',45),
 (181,'None','GOOD',46),
 (182,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',46),
 (183,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',46),
 (184,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',46),
 (185,'None','GOOD',47),
 (186,'Present without measurable section loss.','FAIR',47),
 (187,'Present with measurable section loss, but does not warrant structural review.','POOR',47),
 (188,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',47),
 (189,'None','GOOD',48),
 (190,'Surface white without build-up or leaching without rust staining.','FAIR',48),
 (191,'Heavy build-up with rust staining.','POOR',48),
 (192,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',48),
 (193,'None or insignificant cracks.','GOOD',49),
 (194,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',49),
 (195,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',49),
 (196,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',49),
 (197,'No abrasion or wearing.','GOOD',50),
 (198,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',50),
 (199,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',50),
 (200,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',50),
 (201,'Not applicable','GOOD',51),
 (202,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',51),
 (203,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',51),
 (204,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',51),
 (205,'None','GOOD',52),
 (206,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',52),
 (207,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',52),
 (208,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',52),
 (209,'None','GOOD',53),
 (210,'Present without measurable section loss.','FAIR',53),
 (211,'Present with measurable section loss, but does not warrant structural review.','POOR',53),
 (212,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',53),
 (213,'None','GOOD',54),
 (214,'Present without section loss.','FAIR',54),
 (215,'Present with section loss, but does not warrant structural review.','POOR',54),
 (216,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',54),
 (217,'None or insignificant cracks.','GOOD',55),
 (218,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',55),
 (219,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',55),
 (220,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',55),
 (221,'None','GOOD',56),
 (222,'Surface white without build-up or leaching without rust staining.','FAIR',56),
 (223,'Heavy build-up with rust staining.','POOR',56),
 (224,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',56),
 (225,'No abrasion or wearing.','GOOD',57),
 (226,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',57),
 (227,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',57),
 (228,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',57),
 (229,'Not applicable','GOOD',58),
 (230,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',58),
 (231,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',58),
 (232,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',58),
 (233,'Connection is in place and functioning as intended.','GOOD',59),
 (234,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',59),
 (235,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',59),
 (236,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',59),
 (237,'None','GOOD',60),
 (238,'Affects less than 10% of the member section.','FAIR',60),
 (239,'Affects 10% or more of the member but does not warrant structural review.','POOR',60),
 (240,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',60),
 (241,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',61),
 (242,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',61),
 (243,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',61),
 (244,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',61),
 (245,'None','GOOD',62),
 (246,'Crack that has been arrested through effective measures.','FAIR',62),
 (247,'Identified crack exists that is not arrested, but does not require structural review','POOR',62),
 (248,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',62),
 (249,'None','GOOD',63),
 (250,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',63),
 (251,'Length equal to or greater than the member depth, but does not require structural review.','POOR',63),
 (252,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',63),
 (253,'None or no measurable section loss.','GOOD',64),
 (254,'Section loss less than 10% of the member thickness.','FAIR',64),
 (255,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',64),
 (256,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',64),
 (257,'Not applicable','GOOD',65),
 (258,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',65),
 (259,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',65),
 (260,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',65),
 (261,'None','GOOD',66),
 (262,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',66),
 (263,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',66),
 (264,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',66),
 (265,'None','GOOD',67),
 (266,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',67),
 (267,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',67),
 (268,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',67),
 (269,'Connection is in place and functioning as intended.','GOOD',68),
 (270,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',68),
 (271,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',68),
 (272,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',68),
 (273,'None or insignificant cracks.','GOOD',69),
 (274,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',69),
 (275,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',69),
 (276,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',69),
 (277,'None','GOOD',70),
 (278,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',70),
 (279,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',70),
 (280,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',70),
 (281,'None','GOOD',71),
 (282,'Surface white without build-up or leaching without rust staining.','FAIR',71),
 (283,'Heavy build-up with rust staining.','POOR',71),
 (284,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',71),
 (285,'None','GOOD',72),
 (286,'Initiated breakdown or deterioration.','FAIR',72),
 (287,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',72),
 (288,'','SEVERE',72),
 (289,'Not applicable','GOOD',73),
 (290,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',73),
 (291,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',73),
 (292,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',73),
 (293,'None','GOOD',74),
 (294,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',74),
 (295,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',74),
 (296,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',74),
 (297,'None','GOOD',75),
 (298,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',75),
 (299,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',75),
 (300,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',75),
 (301,'Connection is in place and functioning as intended.','GOOD',76),
 (302,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',76),
 (303,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',76),
 (304,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',76),
 (305,'None','GOOD',77),
 (306,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',77),
 (307,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',77),
 (308,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',77),
 (309,'None or insignificant cracks.','GOOD',78),
 (310,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',78),
 (311,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',78),
 (312,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',78),
 (313,'None','GOOD',79),
 (314,'Initiated breakdown or deterioration.','FAIR',79),
 (315,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',79),
 (316,'','SEVERE',79),
 (317,'None','GOOD',80),
 (318,'Surface white without build-up or leaching without rust staining.','FAIR',80),
 (319,'Heavy build-up with rust staining.','POOR',80),
 (320,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',80),
 (321,'Not applicable','GOOD',81),
 (322,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',81),
 (323,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',81),
 (324,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',81),
 (325,'None','GOOD',82),
 (326,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',82),
 (327,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',82),
 (328,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',82),
 (329,'None','GOOD',83),
 (330,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',83),
 (331,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',83),
 (332,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',83),
 (333,'Connection is in place and functioning as intended.','GOOD',84),
 (334,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',84),
 (335,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',84),
 (336,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',84),
 (337,'None','GOOD',85),
 (338,'Distortion not requiring mitigation or mitigated distortion.','FAIR',85),
 (339,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',85),
 (340,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',85),
 (341,'Not applicable','GOOD',86),
 (342,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',86),
 (343,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',86),
 (344,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',86),
 (345,'None','GOOD',87),
 (346,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',87),
 (347,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',87),
 (348,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',87),
 (349,'None','GOOD',88),
 (350,'Present without measurable section loss.','FAIR',88),
 (351,'Present with measurable section loss, but does not warrant structural review.','POOR',88),
 (352,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',88),
 (353,'None','GOOD',89),
 (354,'Surface white without build-up or leaching without rust staining.','FAIR',89),
 (355,'Heavy build-up with rust staining.','POOR',89),
 (356,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',89),
 (357,'None or insignificant cracks.','GOOD',90),
 (358,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',90),
 (359,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',90),
 (360,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',90),
 (361,'No abrasion or wearing.','GOOD',91),
 (362,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',91),
 (363,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',91),
 (364,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',91),
 (365,'Not applicable','GOOD',92),
 (366,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',92),
 (367,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',92),
 (368,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',92),
 (369,'Connection is in place and functioning as intended.','GOOD',93),
 (370,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',93),
 (371,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',93),
 (372,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',93),
 (373,'None','GOOD',94),
 (374,'Affects less than 10% of the member section.','FAIR',94),
 (375,'Affects 10% or more of the member but does not warrant structural review.','POOR',94),
 (376,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',94),
 (377,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',95),
 (378,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',95),
 (379,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',95),
 (380,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',95),
 (381,'None','GOOD',96),
 (382,'Crack that has been arrested through effective measures.','FAIR',96),
 (383,'Identified crack exists that is not arrested, but does not require structural review','POOR',96),
 (384,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',96),
 (385,'None','GOOD',97),
 (386,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',97),
 (387,'Length equal to or greater than the member depth, but does not require structural review.','POOR',97),
 (388,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',97),
 (389,'None or no measurable section loss.','GOOD',98),
 (390,'Section loss less than 10% of the member thickness.','FAIR',98),
 (391,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',98),
 (392,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',98),
 (393,'Not applicable','GOOD',99),
 (394,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',99),
 (395,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',99),
 (396,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',99),
 (397,'None','GOOD',100),
 (398,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',100),
 (399,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',100),
 (400,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',100),
 (401,'None','GOOD',101),
 (402,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',101),
 (403,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',101),
 (404,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',101),
 (405,'Connection is in place and functioning as intended.','GOOD',102),
 (406,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',102),
 (407,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',102),
 (408,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',102),
 (409,'None','GOOD',103),
 (410,'Surface white without build-up or leaching without rust staining.','FAIR',103),
 (411,'Heavy build-up with rust staining.','POOR',103),
 (412,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',103),
 (413,'None or insignificant cracks.','GOOD',104),
 (414,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',104),
 (415,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',104),
 (416,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',104),
 (417,'No abrasion or wearing.','GOOD',105),
 (418,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',105),
 (419,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',105),
 (420,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',105),
 (421,'None','GOOD',106),
 (422,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',106),
 (423,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',106),
 (424,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',106),
 (425,'None','GOOD',107),
 (426,'Present without measurable section loss.','FAIR',107),
 (427,'Present with measurable section loss, but does not warrant structural review.','POOR',107),
 (428,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',107),
 (429,'None','GOOD',108),
 (430,'Initiated breakdown or deterioration.','FAIR',108),
 (431,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',108),
 (432,'','SEVERE',108),
 (433,'None','GOOD',109),
 (434,'Distortion not requiring mitigation or mitigated distortion.','FAIR',109),
 (435,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',109),
 (436,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',109),
 (437,'Not applicable','GOOD',110),
 (438,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',110),
 (439,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',110),
 (440,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',110),
 (441,'None','GOOD',111),
 (442,'Surface white without build-up or leaching without rust staining.','FAIR',111),
 (443,'Heavy build-up with rust staining.','POOR',111),
 (444,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',111),
 (445,'None','GOOD',112),
 (446,'Cracking or voids in less than 10% of joints.','FAIR',112),
 (447,'Cracking or voids in 10% or more of the of joints','POOR',112),
 (448,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',112),
 (449,'None','GOOD',113),
 (450,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',113),
 (451,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',113),
 (452,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',113),
 (453,'None','GOOD',114),
 (454,'Block or stone has split or spalled with no shifting.','FAIR',114),
 (455,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',114),
 (456,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',114),
 (457,'None','GOOD',115),
 (458,'Sound Patch','FAIR',115),
 (459,'Unsound Patch','POOR',115),
 (460,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',115),
 (461,'None','GOOD',116),
 (462,'Block or stone has shifted slightly out of alignment.','FAIR',116),
 (463,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',116),
 (464,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',116),
 (465,'None','GOOD',117),
 (466,'Distortion not requiring mitigation or mitigated distortion.','FAIR',117),
 (467,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',117),
 (468,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',117),
 (469,'Not applicable','GOOD',118),
 (470,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',118),
 (471,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',118),
 (472,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',118),
 (473,'None','GOOD',119),
 (474,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',119),
 (475,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',119),
 (476,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',119),
 (477,'None','GOOD',120),
 (478,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',120),
 (479,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',120),
 (480,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',120),
 (481,'Connection is in place and functioning as intended.','GOOD',121),
 (482,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',121),
 (483,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',121),
 (484,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',121),
 (485,'None','GOOD',122),
 (486,'Distortion not requiring mitigation or mitigated distortion.','FAIR',122),
 (487,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',122),
 (488,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',122),
 (489,'Not applicable','GOOD',123),
 (490,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',123),
 (491,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',123),
 (492,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',123),
 (493,'None','GOOD',124),
 (494,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',124),
 (495,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',124),
 (496,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',124),
 (497,'None','GOOD',125),
 (498,'Present without measurable section loss.','FAIR',125),
 (499,'Present with measurable section loss, but does not warrant structural review.','POOR',125),
 (500,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',125),
 (501,'None','GOOD',126),
 (502,'Present without section loss.','FAIR',126),
 (503,'Present with section loss, but does not warrant structural review.','POOR',126),
 (504,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',126),
 (505,'None or insignificant cracks.','GOOD',127),
 (506,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',127),
 (507,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',127),
 (508,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',127),
 (509,'None','GOOD',128),
 (510,'Surface white without build-up or leaching without rust staining.','FAIR',128),
 (511,'Heavy build-up with rust staining.','POOR',128),
 (512,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',128),
 (513,'Not applicable','GOOD',129),
 (514,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',129),
 (515,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',129),
 (516,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',129),
 (517,'None','GOOD',130),
 (518,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',130),
 (519,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',130),
 (520,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',130),
 (521,'None','GOOD',131),
 (522,'Present without measurable section loss.','FAIR',131),
 (523,'Present with measurable section loss, but does not warrant structural review.','POOR',131),
 (524,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',131),
 (525,'None','GOOD',132),
 (526,'Surface white without build-up or leaching without rust staining.','FAIR',132),
 (527,'Heavy build-up with rust staining.','POOR',132),
 (528,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',132),
 (529,'None or insignificant cracks.','GOOD',133),
 (530,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',133),
 (531,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',133),
 (532,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',133),
 (533,'Not applicable','GOOD',134),
 (534,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',134),
 (535,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',134),
 (536,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',134),
 (537,'None','GOOD',135),
 (538,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',135),
 (539,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',135),
 (540,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',135),
 (541,'None','GOOD',136),
 (542,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',136),
 (543,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',136),
 (544,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',136),
 (545,'Connection is in place and functioning as intended.','GOOD',137),
 (546,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',137),
 (547,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',137),
 (548,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',137),
 (549,'None','GOOD',138),
 (550,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',138),
 (551,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',138),
 (552,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',138),
 (553,'None','GOOD',139),
 (554,'Surface white without build-up or leaching without rust staining.','FAIR',139),
 (555,'Heavy build-up with rust staining.','POOR',139),
 (556,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',139),
 (557,'None or insignificant cracks.','GOOD',140),
 (558,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',140),
 (559,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',140),
 (560,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',140),
 (561,'None','GOOD',141),
 (562,'Initiated breakdown or deterioration.','FAIR',141),
 (563,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',141),
 (564,'','SEVERE',141),
 (565,'None','GOOD',142),
 (566,'Distortion not requiring mitigation or mitigated distortion.','FAIR',142),
 (567,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',142),
 (568,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',142),
 (569,'Not applicable','GOOD',143),
 (570,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',143),
 (571,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',143),
 (572,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',143),
 (573,'None','GOOD',144),
 (574,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',144),
 (575,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',144),
 (576,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',144),
 (577,'None','GOOD',145),
 (578,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',145),
 (579,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',145),
 (580,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',145),
 (581,'Connection is in place and functioning as intended.','GOOD',146),
 (582,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',146),
 (583,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',146),
 (584,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',146),
 (585,'None','GOOD',147),
 (586,'Distortion not requiring mitigation or mitigated distortion.','FAIR',147),
 (587,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',147),
 (588,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',147),
 (589,'Not applicable','GOOD',148),
 (590,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',148),
 (591,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',148),
 (592,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',148),
 (593,'None','GOOD',149),
 (594,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',149),
 (595,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',149),
 (596,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',149),
 (597,'None','GOOD',150),
 (598,'Present without measurable section loss.','FAIR',150),
 (599,'Present with measurable section loss, but does not warrant structural review.','POOR',150),
 (600,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',150),
 (601,'None','GOOD',151),
 (602,'Present without section loss.','FAIR',151),
 (603,'Present with section loss, but does not warrant structural review.','POOR',151),
 (604,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',151),
 (605,'None or insignificant cracks.','GOOD',152),
 (606,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',152),
 (607,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',152),
 (608,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',152),
 (609,'None','GOOD',153),
 (610,'Surface white without build-up or leaching without rust staining.','FAIR',153),
 (611,'Heavy build-up with rust staining.','POOR',153),
 (612,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',153),
 (613,'Not applicable','GOOD',154),
 (614,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',154),
 (615,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',154),
 (616,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',154),
 (617,'None','GOOD',155),
 (618,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',155),
 (619,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',155),
 (620,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',155),
 (621,'None','GOOD',156),
 (622,'Present without measurable section loss.','FAIR',156),
 (623,'Present with measurable section loss, but does not warrant structural review.','POOR',156),
 (624,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',156),
 (625,'None','GOOD',157),
 (626,'Surface white without build-up or leaching without rust staining.','FAIR',157),
 (627,'Heavy build-up with rust staining.','POOR',157),
 (628,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',157),
 (629,'None or insignificant cracks.','GOOD',158),
 (630,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',158),
 (631,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',158),
 (632,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',158),
 (633,'Not applicable','GOOD',159),
 (634,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',159),
 (635,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',159),
 (636,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',159),
 (637,'Connection is in place and functioning as intended.','GOOD',160),
 (638,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',160),
 (639,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',160),
 (640,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',160),
 (641,'None','GOOD',161),
 (642,'Affects less than 10% of the member section.','FAIR',161),
 (643,'Affects 10% or more of the member but does not warrant structural review.','POOR',161),
 (644,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',161),
 (645,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',162),
 (646,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',162),
 (647,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',162),
 (648,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',162),
 (649,'None','GOOD',163),
 (650,'Crack that has been arrested through effective measures.','FAIR',163),
 (651,'Identified crack exists that is not arrested, but does not require structural review','POOR',163),
 (652,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',163),
 (653,'None','GOOD',164),
 (654,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',164),
 (655,'Length equal to or greater than the member depth, but does not require structural review.','POOR',164),
 (656,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',164),
 (657,'None or no measurable section loss.','GOOD',165),
 (658,'Section loss less than 10% of the member thickness.','FAIR',165),
 (659,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',165),
 (660,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',165),
 (661,'Not applicable','GOOD',166),
 (662,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',166),
 (663,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',166),
 (664,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',166),
 (665,'None','GOOD',167),
 (666,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',167),
 (667,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',167),
 (668,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',167),
 (669,'None','GOOD',168),
 (670,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',168),
 (671,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',168),
 (672,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',168),
 (673,'Connection is in place and functioning as intended.','GOOD',169),
 (674,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',169),
 (675,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',169),
 (676,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',169),
 (677,'None','GOOD',170),
 (678,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',170),
 (679,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',170),
 (680,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',170),
 (681,'None','GOOD',171),
 (682,'Surface white without build-up or leaching without rust staining.','FAIR',171),
 (683,'Heavy build-up with rust staining.','POOR',171),
 (684,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',171),
 (685,'None or insignificant cracks.','GOOD',172),
 (686,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',172),
 (687,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',172),
 (688,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',172),
 (689,'None','GOOD',173),
 (690,'Initiated breakdown or deterioration.','FAIR',173),
 (691,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',173),
 (692,'','SEVERE',173),
 (693,'None','GOOD',174),
 (694,'Distortion not requiring mitigation or mitigated distortion.','FAIR',174),
 (695,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',174),
 (696,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',174),
 (697,'Not applicable','GOOD',175),
 (698,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',175),
 (699,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',175),
 (700,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',175),
 (701,'None','GOOD',176),
 (702,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',176),
 (703,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',176),
 (704,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',176),
 (705,'None','GOOD',177),
 (706,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',177),
 (707,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',177),
 (708,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',177),
 (709,'Connection is in place and functioning as intended.','GOOD',178),
 (710,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',178),
 (711,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',178),
 (712,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',178),
 (713,'None','GOOD',179),
 (714,'Distortion not requiring mitigation or mitigated distortion.','FAIR',179),
 (715,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',179),
 (716,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',179),
 (717,'Not applicable','GOOD',180),
 (718,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',180),
 (719,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',180),
 (720,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',180),
 (721,'Connection is in place and functioning as intended.','GOOD',181),
 (722,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',181),
 (723,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',181),
 (724,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',181),
 (725,'None','GOOD',182),
 (726,'Affects less than 10% of the member section.','FAIR',182),
 (727,'Affects 10% or more of the member but does not warrant structural review.','POOR',182),
 (728,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',182),
 (729,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',183),
 (730,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',183),
 (731,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',183),
 (732,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',183),
 (733,'None','GOOD',184),
 (734,'Crack that has been arrested through effective measures.','FAIR',184),
 (735,'Identified crack exists that is not arrested, but does not require structural review','POOR',184),
 (736,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',184),
 (737,'None','GOOD',185),
 (738,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',185),
 (739,'Length equal to or greater than the member depth, but does not require structural review.','POOR',185),
 (740,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',185),
 (741,'None or no measurable section loss.','GOOD',186),
 (742,'Section loss less than 10% of the member thickness.','FAIR',186),
 (743,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',186),
 (744,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',186),
 (745,'Not applicable','GOOD',187),
 (746,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',187),
 (747,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',187),
 (748,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',187),
 (749,'None','GOOD',188),
 (750,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',188),
 (751,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',188),
 (752,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',188),
 (753,'None','GOOD',189),
 (754,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',189),
 (755,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',189),
 (756,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',189),
 (757,'Connection is in place and functioning as intended.','GOOD',190),
 (758,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',190),
 (759,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',190),
 (760,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',190),
 (761,'None','GOOD',191),
 (762,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',191),
 (763,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',191),
 (764,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',191),
 (765,'None','GOOD',192),
 (766,'Surface white without build-up or leaching without rust staining.','FAIR',192),
 (767,'Heavy build-up with rust staining.','POOR',192),
 (768,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',192),
 (769,'None or insignificant cracks.','GOOD',193),
 (770,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',193),
 (771,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',193),
 (772,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',193),
 (773,'None','GOOD',194),
 (774,'Initiated breakdown or deterioration.','FAIR',194),
 (775,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',194),
 (776,'','SEVERE',194),
 (777,'None','GOOD',195),
 (778,'Distortion not requiring mitigation or mitigated distortion.','FAIR',195),
 (779,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',195),
 (780,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',195),
 (781,'Not applicable','GOOD',196),
 (782,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',196),
 (783,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',196),
 (784,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',196),
 (785,'None','GOOD',197),
 (786,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',197),
 (787,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',197),
 (788,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',197),
 (789,'None','GOOD',198),
 (790,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',198),
 (791,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',198),
 (792,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',198),
 (793,'Connection is in place and functioning as intended.','GOOD',199),
 (794,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',199),
 (795,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',199),
 (796,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',199),
 (797,'None','GOOD',200),
 (798,'Distortion not requiring mitigation or mitigated distortion.','FAIR',200),
 (799,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',200),
 (800,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',200),
 (801,'Not applicable','GOOD',201),
 (802,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',201),
 (803,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',201),
 (804,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',201),
 (805,'None','GOOD',202),
 (806,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',202),
 (807,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',202),
 (808,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',202),
 (809,'None','GOOD',203),
 (810,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',203),
 (811,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',203),
 (812,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',203),
 (813,'Connection is in place and functioning as intended.','GOOD',204),
 (814,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',204),
 (815,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',204),
 (816,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',204),
 (817,'None or insignificant cracks.','GOOD',205),
 (818,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',205),
 (819,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',205),
 (820,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',205),
 (821,'None','GOOD',206),
 (822,'Initiated breakdown or deterioration.','FAIR',206),
 (823,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',206),
 (824,'','SEVERE',206),
 (825,'None','GOOD',207),
 (826,'Distortion not requiring mitigation or mitigated distortion.','FAIR',207),
 (827,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',207),
 (828,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',207),
 (829,'None','GOOD',208),
 (830,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',208),
 (831,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',208),
 (832,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',208),
 (833,'None','GOOD',209),
 (834,'Surface white without build-up or leaching without rust staining.','FAIR',209),
 (835,'Heavy build-up with rust staining.','POOR',209),
 (836,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',209),
 (837,'Not applicable','GOOD',210),
 (838,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',210),
 (839,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',210),
 (840,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',210),
 (841,'None','GOOD',211),
 (842,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',211),
 (843,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',211),
 (844,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',211),
 (845,'None','GOOD',212),
 (846,'Present without measurable section loss.','FAIR',212),
 (847,'Present with measurable section loss, but does not warrant structural review.','POOR',212),
 (848,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',212),
 (849,'None','GOOD',213),
 (850,'Present without section loss.','FAIR',213),
 (851,'Present with section loss, but does not warrant structural review.','POOR',213),
 (852,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',213),
 (853,'None or insignificant cracks.','GOOD',214),
 (854,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',214),
 (855,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',214),
 (856,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',214),
 (857,'None','GOOD',215),
 (858,'Surface white without build-up or leaching without rust staining.','FAIR',215),
 (859,'Heavy build-up with rust staining.','POOR',215),
 (860,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',215),
 (861,'No abrasion or wearing.','GOOD',216),
 (862,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',216),
 (863,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',216),
 (864,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',216),
 (865,'Not applicable','GOOD',217),
 (866,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',217),
 (867,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',217),
 (868,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',217),
 (869,'None','GOOD',218),
 (870,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',218),
 (871,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',218),
 (872,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',218),
 (873,'None','GOOD',219),
 (874,'Present without measurable section loss.','FAIR',219),
 (875,'Present with measurable section loss, but does not warrant structural review.','POOR',219),
 (876,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',219),
 (877,'None','GOOD',220),
 (878,'Surface white without build-up or leaching without rust staining.','FAIR',220),
 (879,'Heavy build-up with rust staining.','POOR',220),
 (880,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',220),
 (881,'None or insignificant cracks.','GOOD',221),
 (882,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',221),
 (883,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',221),
 (884,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',221),
 (885,'No abrasion or wearing.','GOOD',222),
 (886,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',222),
 (887,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',222),
 (888,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',222),
 (889,'Not applicable','GOOD',223),
 (890,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',223),
 (891,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',223),
 (892,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',223),
 (893,'None','GOOD',224),
 (894,'Surface white without build-up or leaching without rust staining.','FAIR',224),
 (895,'Heavy build-up with rust staining.','POOR',224),
 (896,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',224),
 (897,'None','GOOD',225),
 (898,'Cracking or voids in less than 10% of joints.','FAIR',225),
 (899,'Cracking or voids in 10% or more of the of joints','POOR',225),
 (900,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',225),
 (901,'None','GOOD',226),
 (902,'Block or stone has split or spalled with no shifting.','FAIR',226),
 (903,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',226),
 (904,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',226),
 (905,'None','GOOD',227),
 (906,'Sound Patch','FAIR',227),
 (907,'Unsound Patch','POOR',227),
 (908,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',227),
 (909,'None','GOOD',228),
 (910,'Block or stone has shifted slightly out of alignment.','FAIR',228),
 (911,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',228),
 (912,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',228),
 (913,'Not applicable','GOOD',229),
 (914,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',229),
 (915,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',229),
 (916,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',229),
 (917,'Connection is in place and functioning as intended.','GOOD',230),
 (918,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',230),
 (919,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',230),
 (920,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',230),
 (921,'None','GOOD',231),
 (922,'Affects less than 10% of the member section.','FAIR',231),
 (923,'Affects 10% or more of the member but does not warrant structural review.','POOR',231),
 (924,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',231),
 (925,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',232),
 (926,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',232),
 (927,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',232),
 (928,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',232),
 (929,'None','GOOD',233),
 (930,'Crack that has been arrested through effective measures.','FAIR',233),
 (931,'Identified crack exists that is not arrested, but does not require structural review','POOR',233),
 (932,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',233),
 (933,'None','GOOD',234),
 (934,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',234),
 (935,'Length equal to or greater than the member depth, but does not require structural review.','POOR',234),
 (936,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',234),
 (937,'None or no measurable section loss.','GOOD',235),
 (938,'Section loss less than 10% of the member thickness.','FAIR',235),
 (939,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',235),
 (940,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',235),
 (941,'Not applicable','GOOD',236),
 (942,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',236),
 (943,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',236),
 (944,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',236),
 (945,'None','GOOD',237),
 (946,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',237),
 (947,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',237),
 (948,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',237),
 (949,'None','GOOD',238),
 (950,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',238),
 (951,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',238),
 (952,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',238),
 (953,'Connection is in place and functioning as intended.','GOOD',239),
 (954,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',239),
 (955,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',239),
 (956,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',239),
 (957,'None','GOOD',240),
 (958,'Distortion not requiring mitigation or mitigated distortion.','FAIR',240),
 (959,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',240),
 (960,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',240),
 (961,'Not applicable','GOOD',241),
 (962,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',241),
 (963,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',241),
 (964,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',241),
 (965,'None','GOOD',242),
 (966,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',242),
 (967,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',242),
 (968,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',242),
 (969,'None','GOOD',243),
 (970,'Present without measurable section loss.','FAIR',243),
 (971,'Present with measurable section loss, but does not warrant structural review.','POOR',243),
 (972,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',243),
 (973,'None','GOOD',244),
 (974,'Present without section loss.','FAIR',244),
 (975,'Present with section loss, but does not warrant structural review.','POOR',244),
 (976,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',244),
 (977,'None or insignificant cracks.','GOOD',245),
 (978,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',245),
 (979,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',245),
 (980,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',245),
 (981,'None','GOOD',246),
 (982,'Surface white without build-up or leaching without rust staining.','FAIR',246),
 (983,'Heavy build-up with rust staining.','POOR',246),
 (984,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',246),
 (985,'Not applicable','GOOD',247),
 (986,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',247),
 (987,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',247),
 (988,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',247),
 (989,'None','GOOD',248),
 (990,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',248),
 (991,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',248),
 (992,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',248),
 (993,'None','GOOD',249),
 (994,'Present without measurable section loss.','FAIR',249),
 (995,'Present with measurable section loss, but does not warrant structural review.','POOR',249),
 (996,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',249),
 (997,'None','GOOD',250),
 (998,'Surface white without build-up or leaching without rust staining.','FAIR',250),
 (999,'Heavy build-up with rust staining.','POOR',250),
 (1000,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',250),
 (1001,'None or insignificant cracks.','GOOD',251),
 (1002,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',251),
 (1003,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',251),
 (1004,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',251),
 (1005,'Not applicable','GOOD',252),
 (1006,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',252),
 (1007,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',252),
 (1008,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',252),
 (1009,'Connection is in place and functioning as intended.','GOOD',253),
 (1010,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',253),
 (1011,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',253),
 (1012,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',253),
 (1013,'None','GOOD',254),
 (1014,'Affects less than 10% of the member section.','FAIR',254),
 (1015,'Affects 10% or more of the member but does not warrant structural review.','POOR',254),
 (1016,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',254),
 (1017,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',255),
 (1018,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',255),
 (1019,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',255),
 (1020,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',255),
 (1021,'None','GOOD',256),
 (1022,'Crack that has been arrested through effective measures.','FAIR',256),
 (1023,'Identified crack exists that is not arrested, but does not require structural review','POOR',256),
 (1024,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',256),
 (1025,'None','GOOD',257),
 (1026,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',257),
 (1027,'Length equal to or greater than the member depth, but does not require structural review.','POOR',257),
 (1028,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',257),
 (1029,'None or no measurable section loss.','GOOD',258),
 (1030,'Section loss less than 10% of the member thickness.','FAIR',258),
 (1031,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',258),
 (1032,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',258),
 (1033,'Not applicable','GOOD',259),
 (1034,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',259),
 (1035,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',259),
 (1036,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',259),
 (1037,'None','GOOD',260),
 (1038,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',260),
 (1039,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',260),
 (1040,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',260),
 (1041,'None','GOOD',261),
 (1042,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',261),
 (1043,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',261),
 (1044,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',261),
 (1045,'Connection is in place and functioning as intended.','GOOD',262),
 (1046,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',262),
 (1047,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',262),
 (1048,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',262),
 (1049,'None','GOOD',263),
 (1050,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',263),
 (1051,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',263),
 (1052,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',263),
 (1053,'None','GOOD',264),
 (1054,'Surface white without build-up or leaching without rust staining.','FAIR',264),
 (1055,'Heavy build-up with rust staining.','POOR',264),
 (1056,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',264),
 (1057,'None or insignificant cracks.','GOOD',265),
 (1058,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',265),
 (1059,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',265),
 (1060,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',265),
 (1061,'None','GOOD',266),
 (1062,'Initiated breakdown or deterioration.','FAIR',266),
 (1063,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',266),
 (1064,'','SEVERE',266),
 (1065,'None','GOOD',267),
 (1066,'Distortion not requiring mitigation or mitigated distortion.','FAIR',267),
 (1067,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',267),
 (1068,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',267),
 (1069,'Not applicable','GOOD',268),
 (1070,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',268),
 (1071,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',268),
 (1072,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',268),
 (1073,'None','GOOD',269),
 (1074,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',269),
 (1075,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',269),
 (1076,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',269),
 (1077,'None','GOOD',270),
 (1078,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',270),
 (1079,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',270),
 (1080,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',270),
 (1081,'Connection is in place and functioning as intended.','GOOD',271),
 (1082,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',271),
 (1083,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',271),
 (1084,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',271),
 (1085,'None','GOOD',272),
 (1086,'Distortion not requiring mitigation or mitigated distortion.','FAIR',272),
 (1087,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',272),
 (1088,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',272),
 (1089,'Not applicable','GOOD',273),
 (1090,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',273),
 (1091,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',273),
 (1092,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',273),
 (1093,'None','GOOD',274),
 (1094,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',274),
 (1095,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',274),
 (1096,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',274),
 (1097,'None','GOOD',275),
 (1098,'Present without measurable section loss.','FAIR',275),
 (1099,'Present with measurable section loss, but does not warrant structural review.','POOR',275),
 (1100,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',275),
 (1101,'None','GOOD',276),
 (1102,'Present without section loss.','FAIR',276),
 (1103,'Present with section loss, but does not warrant structural review.','POOR',276),
 (1104,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',276),
 (1105,'None or insignificant cracks.','GOOD',277),
 (1106,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',277),
 (1107,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',277),
 (1108,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',277),
 (1109,'None','GOOD',278),
 (1110,'Surface white without build-up or leaching without rust staining.','FAIR',278),
 (1111,'Heavy build-up with rust staining.','POOR',278),
 (1112,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',278),
 (1113,'Not applicable','GOOD',279),
 (1114,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',279),
 (1115,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',279),
 (1116,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',279),
 (1117,'None','GOOD',280),
 (1118,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',280),
 (1119,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',280),
 (1120,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',280),
 (1121,'None','GOOD',281),
 (1122,'Present without measurable section loss.','FAIR',281),
 (1123,'Present with measurable section loss, but does not warrant structural review.','POOR',281),
 (1124,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',281),
 (1125,'None','GOOD',282),
 (1126,'Surface white without build-up or leaching without rust staining.','FAIR',282),
 (1127,'Heavy build-up with rust staining.','POOR',282),
 (1128,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',282),
 (1129,'None or insignificant cracks.','GOOD',283),
 (1130,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',283),
 (1131,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',283),
 (1132,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',283),
 (1133,'Not applicable','GOOD',284),
 (1134,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',284),
 (1135,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',284),
 (1136,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',284),
 (1137,'Connection is in place and functioning as intended.','GOOD',285),
 (1138,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',285),
 (1139,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',285),
 (1140,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',285),
 (1141,'None','GOOD',286),
 (1142,'Affects less than 10% of the member section.','FAIR',286),
 (1143,'Affects 10% or more of the member but does not warrant structural review.','POOR',286),
 (1144,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',286),
 (1145,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',287),
 (1146,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',287),
 (1147,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',287),
 (1148,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',287),
 (1149,'None','GOOD',288),
 (1150,'Crack that has been arrested through effective measures.','FAIR',288),
 (1151,'Identified crack exists that is not arrested, but does not require structural review','POOR',288),
 (1152,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',288),
 (1153,'None','GOOD',289),
 (1154,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',289),
 (1155,'Length equal to or greater than the member depth, but does not require structural review.','POOR',289),
 (1156,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',289),
 (1157,'None or no measurable section loss.','GOOD',290),
 (1158,'Section loss less than 10% of the member thickness.','FAIR',290),
 (1159,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',290),
 (1160,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',290),
 (1161,'Not applicable','GOOD',291),
 (1162,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',291),
 (1163,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',291),
 (1164,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',291),
 (1165,'None','GOOD',292),
 (1166,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',292),
 (1167,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',292),
 (1168,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',292),
 (1169,'None','GOOD',293),
 (1170,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',293),
 (1171,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',293),
 (1172,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',293),
 (1173,'Connection is in place and functioning as intended.','GOOD',294),
 (1174,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',294),
 (1175,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',294),
 (1176,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',294),
 (1177,'None','GOOD',295),
 (1178,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',295),
 (1179,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',295),
 (1180,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',295),
 (1181,'None','GOOD',296),
 (1182,'Surface white without build-up or leaching without rust staining.','FAIR',296),
 (1183,'Heavy build-up with rust staining.','POOR',296),
 (1184,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',296),
 (1185,'None or insignificant cracks.','GOOD',297),
 (1186,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',297),
 (1187,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',297),
 (1188,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',297),
 (1189,'None','GOOD',298),
 (1190,'Initiated breakdown or deterioration.','FAIR',298),
 (1191,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',298),
 (1192,'','SEVERE',298),
 (1193,'None','GOOD',299),
 (1194,'Distortion not requiring mitigation or mitigated distortion.','FAIR',299),
 (1195,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',299),
 (1196,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',299),
 (1197,'Not applicable','GOOD',300),
 (1198,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',300),
 (1199,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',300),
 (1200,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',300),
 (1201,'None','GOOD',301),
 (1202,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',301),
 (1203,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',301),
 (1204,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',301),
 (1205,'None','GOOD',302),
 (1206,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',302),
 (1207,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',302),
 (1208,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',302),
 (1209,'Connection is in place and functioning as intended.','GOOD',303),
 (1210,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',303),
 (1211,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',303),
 (1212,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',303),
 (1213,'None','GOOD',304),
 (1214,'Distortion not requiring mitigation or mitigated distortion.','FAIR',304),
 (1215,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',304),
 (1216,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',304),
 (1217,'Not applicable','GOOD',305),
 (1218,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',305),
 (1219,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',305),
 (1220,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',305),
 (1221,'None','GOOD',306),
 (1222,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',306),
 (1223,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',306),
 (1224,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',306),
 (1225,'None','GOOD',307),
 (1226,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',307),
 (1227,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',307),
 (1228,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',307),
 (1229,'Connection is in place and functioning as intended.','GOOD',308),
 (1230,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',308),
 (1231,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',308),
 (1232,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',308),
 (1233,'None','GOOD',309),
 (1234,'Distortion not requiring mitigation or mitigated distortion.','FAIR',309),
 (1235,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',309),
 (1236,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',309),
 (1237,'Not applicable','GOOD',310),
 (1238,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',310),
 (1239,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',310),
 (1240,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',310),
 (1241,'None','GOOD',311),
 (1242,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',311),
 (1243,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',311),
 (1244,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',311),
 (1245,'None','GOOD',312),
 (1246,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',312),
 (1247,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',312),
 (1248,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',312),
 (1249,'Connection is in place and functioning as intended.','GOOD',313),
 (1250,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',313),
 (1251,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',313),
 (1252,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',313),
 (1253,'None','GOOD',314),
 (1254,'Initiated breakdown or deterioration.','FAIR',314),
 (1255,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',314),
 (1256,'','SEVERE',314),
 (1257,'None','GOOD',315),
 (1258,'Distortion not requiring mitigation or mitigated distortion.','FAIR',315),
 (1259,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',315),
 (1260,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',315),
 (1261,'Not applicable','GOOD',316),
 (1262,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',316),
 (1263,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',316),
 (1264,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',316),
 (1265,'None','GOOD',317),
 (1266,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',317),
 (1267,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',317),
 (1268,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',317),
 (1269,'None','GOOD',318),
 (1270,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',318),
 (1271,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',318),
 (1272,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',318),
 (1273,'Connection is in place and functioning as intended.','GOOD',319),
 (1274,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',319),
 (1275,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',319),
 (1276,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',319),
 (1277,'None','GOOD',320),
 (1278,'Distortion not requiring mitigation or mitigated distortion.','FAIR',320),
 (1279,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',320),
 (1280,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',320),
 (1281,'Not applicable','GOOD',321),
 (1282,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',321),
 (1283,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',321),
 (1284,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',321),
 (1285,'None','GOOD',322),
 (1286,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',322),
 (1287,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',322),
 (1288,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',322),
 (1289,'None','GOOD',323),
 (1290,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',323),
 (1291,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',323),
 (1292,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',323),
 (1293,'Connection is in place and functioning as intended.','GOOD',324),
 (1294,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',324),
 (1295,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',324),
 (1296,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',324),
 (1297,'None','GOOD',325),
 (1298,'Distortion not requiring mitigation or mitigated distortion.','FAIR',325),
 (1299,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',325),
 (1300,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',325),
 (1301,'Not applicable','GOOD',326),
 (1302,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',326),
 (1303,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',326),
 (1304,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',326),
 (1305,'None','GOOD',327),
 (1306,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',327),
 (1307,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',327),
 (1308,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',327),
 (1309,'None','GOOD',328),
 (1310,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',328),
 (1311,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',328),
 (1312,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',328),
 (1313,'Connection is in place and functioning as intended.','GOOD',329),
 (1314,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',329),
 (1315,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',329),
 (1316,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',329),
 (1317,'None','GOOD',330),
 (1318,'Distortion not requiring mitigation or mitigated distortion.','FAIR',330),
 (1319,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',330),
 (1320,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',330),
 (1321,'Not applicable','GOOD',331),
 (1322,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',331),
 (1323,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',331),
 (1324,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',331),
 (1325,'None','GOOD',332),
 (1326,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',332),
 (1327,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',332),
 (1328,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',332),
 (1329,'None','GOOD',333),
 (1330,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',333),
 (1331,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',333),
 (1332,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',333),
 (1333,'Connection is in place and functioning as intended.','GOOD',334),
 (1334,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',334),
 (1335,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',334),
 (1336,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',334),
 (1337,'None','GOOD',335),
 (1338,'Distortion not requiring mitigation or mitigated distortion.','FAIR',335),
 (1339,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',335),
 (1340,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',335),
 (1341,'Not applicable','GOOD',336),
 (1342,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',336),
 (1343,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',336),
 (1344,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',336),
 (1345,'None','GOOD',337),
 (1346,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',337),
 (1347,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',337),
 (1348,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',337),
 (1349,'None','GOOD',338),
 (1350,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',338),
 (1351,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',338),
 (1352,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',338),
 (1353,'Connection is in place and functioning as intended.','GOOD',339),
 (1354,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',339),
 (1355,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',339),
 (1356,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',339),
 (1357,'None','GOOD',340),
 (1358,'Distortion not requiring mitigation or mitigated distortion.','FAIR',340),
 (1359,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',340),
 (1360,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',340),
 (1361,'Restraint system is functional and installed as designed.','GOOD',341),
 (1362,'Less than 20% of the restraint system is set improperly (excessive slack or tightness).','FAIR',341),
 (1363,'Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).','POOR',341),
 (1364,'More than 50% of the restraint system is set improperly (excessive slack or tightness).','SEVERE',341),
 (1365,'Not applicable','GOOD',342),
 (1366,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',342),
 (1367,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',342),
 (1368,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',342),
 (1369,'None','GOOD',343),
 (1370,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',343),
 (1371,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',343),
 (1372,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',343),
 (1373,'None','GOOD',344),
 (1374,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',344),
 (1375,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',344),
 (1376,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',344),
 (1377,'Connection is in place and functioning as intended.','GOOD',345),
 (1378,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',345),
 (1379,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',345),
 (1380,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',345),
 (1381,'None','GOOD',346),
 (1382,'Distortion not requiring mitigation or mitigated distortion.','FAIR',346),
 (1383,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',346),
 (1384,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',346),
 (1385,'Restraint system is functional and installed as designed.','GOOD',347),
 (1386,'Less than 20% of the restraint system is set improperly (excessive slack or tightness).','FAIR',347),
 (1387,'Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).','POOR',347),
 (1388,'More than 50% of the restraint system is set improperly (excessive slack or tightness).','SEVERE',347),
 (1389,'Not applicable','GOOD',348),
 (1390,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',348),
 (1391,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',348),
 (1392,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',348),
 (1393,'None','GOOD',349),
 (1394,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',349),
 (1395,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',349),
 (1396,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',349),
 (1397,'None','GOOD',350),
 (1398,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',350),
 (1399,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',350),
 (1400,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',350),
 (1401,'Connection is in place and functioning as intended.','GOOD',351),
 (1402,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',351),
 (1403,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',351),
 (1404,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',351),
 (1405,'None','GOOD',352),
 (1406,'Distortion not requiring mitigation or mitigated distortion.','FAIR',352),
 (1407,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',352),
 (1408,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',352),
 (1409,'Restraint system is functional and installed as designed.','GOOD',353),
 (1410,'Less than 20% of the restraint system is set improperly (excessive slack or tightness).','FAIR',353),
 (1411,'Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).','POOR',353),
 (1412,'More than 50% of the restraint system is set improperly (excessive slack or tightness).','SEVERE',353),
 (1413,'Not applicable','GOOD',354),
 (1414,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',354),
 (1415,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',354),
 (1416,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',354),
 (1417,'None','GOOD',355),
 (1418,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',355),
 (1419,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',355),
 (1420,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',355),
 (1421,'Connection is in place and functioning as intended.','GOOD',356),
 (1422,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',356),
 (1423,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',356),
 (1424,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',356),
 (1425,'Free to Move.','GOOD',357),
 (1426,'Minor Restriction','FAIR',357),
 (1427,'Restricted, but not warranting structural review.','POOR',357),
 (1428,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',357),
 (1429,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',358),
 (1430,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',358),
 (1431,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',358),
 (1432,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',358),
 (1433,'None','GOOD',359),
 (1434,'Bulging less than 15% of the thickness.','FAIR',359),
 (1435,'Bulging 15% or more of the thickness.
Splitting or tearing.
Bearing''s surfaces are not parallel.
Does not warrant structural review.','POOR',359),
 (1436,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',359),
 (1437,'None','GOOD',360),
 (1438,'Less than 10%','FAIR',360),
 (1439,'10% or more, but does not warrant structural review.','POOR',360),
 (1440,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',360),
 (1441,'Not applicable','GOOD',361),
 (1442,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',361),
 (1443,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',361),
 (1444,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',361),
 (1445,'None','GOOD',362),
 (1446,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',362),
 (1447,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',362),
 (1448,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',362),
 (1449,'Connection is in place and functioning as intended.','GOOD',363),
 (1450,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',363),
 (1451,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',363),
 (1452,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',363),
 (1453,'Free to Move.','GOOD',364),
 (1454,'Minor Restriction','FAIR',364),
 (1455,'Restricted, but not warranting structural review.','POOR',364),
 (1456,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',364),
 (1457,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',365),
 (1458,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',365),
 (1459,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',365),
 (1460,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',365),
 (1461,'None','GOOD',366),
 (1462,'Less than 10%','FAIR',366),
 (1463,'10% or more, but does not warrant structural review.','POOR',366),
 (1464,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',366),
 (1465,'Not applicable','GOOD',367),
 (1466,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',367),
 (1467,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',367),
 (1468,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',367),
 (1469,'None','GOOD',368),
 (1470,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',368),
 (1471,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',368),
 (1472,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',368),
 (1473,'Connection is in place and functioning as intended.','GOOD',369),
 (1474,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',369),
 (1475,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',369),
 (1476,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',369),
 (1477,'Free to Move.','GOOD',370),
 (1478,'Minor Restriction','FAIR',370),
 (1479,'Restricted, but not warranting structural review.','POOR',370),
 (1480,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',370),
 (1481,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',371),
 (1482,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',371),
 (1483,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',371),
 (1484,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',371),
 (1485,'None','GOOD',372),
 (1486,'Less than 10%','FAIR',372),
 (1487,'10% or more, but does not warrant structural review.','POOR',372),
 (1488,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',372),
 (1489,'Not applicable','GOOD',373),
 (1490,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',373),
 (1491,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',373),
 (1492,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',373),
 (1493,'None','GOOD',374),
 (1494,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',374),
 (1495,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',374),
 (1496,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',374),
 (1497,'Connection is in place and functioning as intended.','GOOD',375),
 (1498,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',375),
 (1499,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',375),
 (1500,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',375),
 (1501,'Free to Move.','GOOD',376),
 (1502,'Minor Restriction','FAIR',376),
 (1503,'Restricted, but not warranting structural review.','POOR',376),
 (1504,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',376),
 (1505,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',377),
 (1506,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',377),
 (1507,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',377),
 (1508,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',377),
 (1509,'None','GOOD',378),
 (1510,'Less than 10%','FAIR',378),
 (1511,'10% or more, but does not warrant structural review.','POOR',378),
 (1512,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',378),
 (1513,'Not applicable','GOOD',379),
 (1514,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',379),
 (1515,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',379),
 (1516,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',379),
 (1517,'None','GOOD',380),
 (1518,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',380),
 (1519,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',380),
 (1520,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',380),
 (1521,'Connection is in place and functioning as intended.','GOOD',381),
 (1522,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',381),
 (1523,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',381),
 (1524,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',381),
 (1525,'Free to Move.','GOOD',382),
 (1526,'Minor Restriction','FAIR',382),
 (1527,'Restricted, but not warranting structural review.','POOR',382),
 (1528,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',382),
 (1529,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',383),
 (1530,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',383),
 (1531,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',383),
 (1532,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',383),
 (1533,'None','GOOD',384),
 (1534,'Bulging less than 15% of the thickness.','FAIR',384),
 (1535,'Bulging 15% or more of the thickness.
Splitting or tearing.
Bearing''s surfaces are not parallel.
Does not warrant structural review.','POOR',384),
 (1536,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',384),
 (1537,'None','GOOD',385),
 (1538,'Less than 10%','FAIR',385),
 (1539,'10% or more, but does not warrant structural review.','POOR',385),
 (1540,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',385),
 (1541,'Not applicable','GOOD',386),
 (1542,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',386),
 (1543,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',386),
 (1544,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',386),
 (1545,'None','GOOD',387),
 (1546,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',387),
 (1547,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',387),
 (1548,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',387),
 (1549,'Connection is in place and functioning as intended.','GOOD',388),
 (1550,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',388),
 (1551,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',388),
 (1552,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',388),
 (1553,'Free to Move.','GOOD',389),
 (1554,'Minor Restriction','FAIR',389),
 (1555,'Restricted, but not warranting structural review.','POOR',389),
 (1556,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',389),
 (1557,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',390),
 (1558,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',390),
 (1559,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',390),
 (1560,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',390),
 (1561,'None','GOOD',391),
 (1562,'Less than 10%','FAIR',391),
 (1563,'10% or more, but does not warrant structural review.','POOR',391),
 (1564,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',391),
 (1565,'Not applicable','GOOD',392),
 (1566,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',392),
 (1567,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',392),
 (1568,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',392),
 (1569,'None','GOOD',393),
 (1570,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',393),
 (1571,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',393),
 (1572,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',393),
 (1573,'Connection is in place and functioning as intended.','GOOD',394),
 (1574,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',394),
 (1575,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',394),
 (1576,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',394),
 (1577,'Free to Move.','GOOD',395),
 (1578,'Minor Restriction','FAIR',395),
 (1579,'Restricted, but not warranting structural review.','POOR',395),
 (1580,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',395),
 (1581,'Lateral and vertical alignment is as expected for the temperature conditions.','GOOD',396),
 (1582,'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.','FAIR',396),
 (1583,'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.','POOR',396),
 (1584,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',396),
 (1585,'None','GOOD',397),
 (1586,'Less than 10%','FAIR',397),
 (1587,'10% or more, but does not warrant structural review.','POOR',397),
 (1588,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',397),
 (1589,'Not applicable','GOOD',398),
 (1590,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',398),
 (1591,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',398),
 (1592,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',398),
 (1593,'None','GOOD',399),
 (1594,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',399),
 (1595,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',399),
 (1596,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',399),
 (1597,'None','GOOD',400),
 (1598,'Present without measurable section loss.','FAIR',400),
 (1599,'Present with measurable section loss, but does not warrant structural review.','POOR',400),
 (1600,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',400),
 (1601,'None','GOOD',401),
 (1602,'Surface white without build-up or leaching without rust staining.','FAIR',401),
 (1603,'Heavy build-up with rust staining.','POOR',401),
 (1604,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',401),
 (1605,'None or insignificant cracks.','GOOD',402),
 (1606,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',402),
 (1607,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',402),
 (1608,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',402),
 (1609,'No abrasion or wearing.','GOOD',403),
 (1610,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',403),
 (1611,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',403),
 (1612,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',403),
 (1613,'None','GOOD',404),
 (1614,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',404),
 (1615,'Exceeds tolerable limits, but does not warrant structural review.','POOR',404),
 (1616,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',404),
 (1617,'None','GOOD',405),
 (1618,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',405),
 (1619,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',405),
 (1620,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',405),
 (1621,'Not applicable','GOOD',406),
 (1622,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',406),
 (1623,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',406),
 (1624,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',406),
 (1625,'Connection is in place and functioning as intended.','GOOD',407),
 (1626,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',407),
 (1627,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',407),
 (1628,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',407),
 (1629,'None','GOOD',408),
 (1630,'Affects less than 10% of the member section.','FAIR',408),
 (1631,'Affects 10% or more of the member but does not warrant structural review.','POOR',408),
 (1632,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',408),
 (1633,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',409),
 (1634,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',409),
 (1635,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',409),
 (1636,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',409),
 (1637,'None','GOOD',410),
 (1638,'Crack that has been arrested through effective measures.','FAIR',410),
 (1639,'Identified crack exists that is not arrested, but does not require structural review','POOR',410),
 (1640,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',410),
 (1641,'None','GOOD',411),
 (1642,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',411),
 (1643,'Length equal to or greater than the member depth, but does not require structural review.','POOR',411),
 (1644,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',411),
 (1645,'None or no measurable section loss.','GOOD',412),
 (1646,'Section loss less than 10% of the member thickness.','FAIR',412),
 (1647,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',412),
 (1648,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',412),
 (1649,'None','GOOD',413),
 (1650,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',413),
 (1651,'Exceeds tolerable limits, but does not warrant structural review.','POOR',413),
 (1652,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',413),
 (1653,'None','GOOD',414),
 (1654,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',414),
 (1655,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',414),
 (1656,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',414),
 (1657,'Not applicable','GOOD',415),
 (1658,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',415),
 (1659,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',415),
 (1660,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',415),
 (1661,'None','GOOD',416),
 (1662,'Surface white without build-up or leaching without rust staining.','FAIR',416),
 (1663,'Heavy build-up with rust staining.','POOR',416),
 (1664,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',416),
 (1665,'None','GOOD',417),
 (1666,'Cracking or voids in less than 10% of joints.','FAIR',417),
 (1667,'Cracking or voids in 10% or more of the of joints','POOR',417),
 (1668,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',417),
 (1669,'None','GOOD',418),
 (1670,'Block or stone has split or spalled with no shifting.','FAIR',418),
 (1671,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',418),
 (1672,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',418),
 (1673,'None','GOOD',419),
 (1674,'Sound Patch','FAIR',419),
 (1675,'Unsound Patch','POOR',419),
 (1676,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',419),
 (1677,'None','GOOD',420),
 (1678,'Block or stone has shifted slightly out of alignment.','FAIR',420),
 (1679,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',420),
 (1680,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',420),
 (1681,'None','GOOD',421),
 (1682,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',421),
 (1683,'Exceeds tolerable limits, but does not warrant structural review.','POOR',421),
 (1684,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',421),
 (1685,'None','GOOD',422),
 (1686,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',422),
 (1687,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',422),
 (1688,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',422),
 (1689,'Not applicable','GOOD',423),
 (1690,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',423),
 (1691,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',423),
 (1692,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',423),
 (1693,'None','GOOD',424),
 (1694,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',424),
 (1695,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',424),
 (1696,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',424),
 (1697,'None','GOOD',425),
 (1698,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',425),
 (1699,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',425),
 (1700,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',425),
 (1701,'Connection is in place and functioning as intended.','GOOD',426),
 (1702,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',426),
 (1703,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',426),
 (1704,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',426),
 (1705,'None or insignificant cracks.','GOOD',427),
 (1706,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',427),
 (1707,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',427),
 (1708,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',427),
 (1709,'None','GOOD',428),
 (1710,'Initiated breakdown or deterioration.','FAIR',428),
 (1711,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',428),
 (1712,'','SEVERE',428),
 (1713,'None','GOOD',429),
 (1714,'Distortion not requiring mitigation or mitigated distortion.','FAIR',429),
 (1715,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',429),
 (1716,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',429),
 (1717,'None','GOOD',430),
 (1718,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',430),
 (1719,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',430),
 (1720,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',430),
 (1721,'None','GOOD',431),
 (1722,'Surface white without build-up or leaching without rust staining.','FAIR',431),
 (1723,'Heavy build-up with rust staining.','POOR',431),
 (1724,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',431),
 (1725,'None','GOOD',432),
 (1726,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',432),
 (1727,'Exceeds tolerable limits, but does not warrant structural review.','POOR',432),
 (1728,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',432),
 (1729,'None','GOOD',433),
 (1730,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',433),
 (1731,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',433),
 (1732,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',433),
 (1733,'Not applicable','GOOD',434),
 (1734,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',434),
 (1735,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',434),
 (1736,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',434),
 (1737,'None','GOOD',435),
 (1738,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',435),
 (1739,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',435),
 (1740,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',435),
 (1741,'None','GOOD',436),
 (1742,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',436),
 (1743,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',436),
 (1744,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',436),
 (1745,'Connection is in place and functioning as intended.','GOOD',437),
 (1746,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',437),
 (1747,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',437),
 (1748,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',437),
 (1749,'None','GOOD',438),
 (1750,'Distortion not requiring mitigation or mitigated distortion.','FAIR',438),
 (1751,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',438),
 (1752,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',438),
 (1753,'None','GOOD',439),
 (1754,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',439),
 (1755,'Exceeds tolerable limits, but does not warrant structural review.','POOR',439),
 (1756,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',439),
 (1757,'None','GOOD',440),
 (1758,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',440),
 (1759,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',440),
 (1760,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',440),
 (1761,'Not applicable','GOOD',441),
 (1762,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',441),
 (1763,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',441),
 (1764,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',441),
 (1765,'None','GOOD',442),
 (1766,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',442),
 (1767,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',442),
 (1768,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',442),
 (1769,'None','GOOD',443),
 (1770,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',443),
 (1771,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',443),
 (1772,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',443),
 (1773,'Connection is in place and functioning as intended.','GOOD',444),
 (1774,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',444),
 (1775,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',444),
 (1776,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',444),
 (1777,'None','GOOD',445),
 (1778,'Distortion not requiring mitigation or mitigated distortion.','FAIR',445),
 (1779,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',445),
 (1780,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',445),
 (1781,'Not applicable','GOOD',446),
 (1782,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',446),
 (1783,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',446),
 (1784,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',446),
 (1785,'None','GOOD',447),
 (1786,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',447),
 (1787,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',447),
 (1788,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',447),
 (1789,'None','GOOD',448),
 (1790,'Present without measurable section loss.','FAIR',448),
 (1791,'Present with measurable section loss, but does not warrant structural review.','POOR',448),
 (1792,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',448),
 (1793,'None','GOOD',449),
 (1794,'Present without section loss.','FAIR',449),
 (1795,'Present with section loss, but does not warrant structural review.','POOR',449),
 (1796,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',449),
 (1797,'None or insignificant cracks.','GOOD',450),
 (1798,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',450),
 (1799,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',450),
 (1800,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',450),
 (1801,'None','GOOD',451),
 (1802,'Surface white without build-up or leaching without rust staining.','FAIR',451),
 (1803,'Heavy build-up with rust staining.','POOR',451),
 (1804,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',451),
 (1805,'Not applicable','GOOD',452),
 (1806,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',452),
 (1807,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',452),
 (1808,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',452),
 (1809,'None','GOOD',453),
 (1810,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',453),
 (1811,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',453),
 (1812,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',453),
 (1813,'None','GOOD',454),
 (1814,'Present without measurable section loss.','FAIR',454),
 (1815,'Present with measurable section loss, but does not warrant structural review.','POOR',454),
 (1816,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',454),
 (1817,'None','GOOD',455),
 (1818,'Surface white without build-up or leaching without rust staining.','FAIR',455),
 (1819,'Heavy build-up with rust staining.','POOR',455),
 (1820,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',455),
 (1821,'None or insignificant cracks.','GOOD',456),
 (1822,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',456),
 (1823,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',456),
 (1824,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',456),
 (1825,'Not applicable','GOOD',457),
 (1826,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',457),
 (1827,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',457),
 (1828,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',457),
 (1829,'Connection is in place and functioning as intended.','GOOD',458),
 (1830,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',458),
 (1831,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',458),
 (1832,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',458),
 (1833,'None','GOOD',459),
 (1834,'Affects less than 10% of the member section.','FAIR',459),
 (1835,'Affects 10% or more of the member but does not warrant structural review.','POOR',459),
 (1836,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',459),
 (1837,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',460),
 (1838,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',460),
 (1839,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',460),
 (1840,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',460),
 (1841,'None','GOOD',461),
 (1842,'Crack that has been arrested through effective measures.','FAIR',461),
 (1843,'Identified crack exists that is not arrested, but does not require structural review','POOR',461),
 (1844,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',461),
 (1845,'None','GOOD',462),
 (1846,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',462),
 (1847,'Length equal to or greater than the member depth, but does not require structural review.','POOR',462),
 (1848,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',462),
 (1849,'None or no measurable section loss.','GOOD',463),
 (1850,'Section loss less than 10% of the member thickness.','FAIR',463),
 (1851,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',463),
 (1852,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',463),
 (1853,'Not applicable','GOOD',464),
 (1854,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',464),
 (1855,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',464),
 (1856,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',464),
 (1857,'None','GOOD',465),
 (1858,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',465),
 (1859,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',465),
 (1860,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',465),
 (1861,'None','GOOD',466),
 (1862,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',466),
 (1863,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',466),
 (1864,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',466),
 (1865,'Connection is in place and functioning as intended.','GOOD',467),
 (1866,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',467),
 (1867,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',467),
 (1868,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',467),
 (1869,'None or insignificant cracks.','GOOD',468),
 (1870,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',468),
 (1871,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',468),
 (1872,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',468),
 (1873,'None','GOOD',469),
 (1874,'Initiated breakdown or deterioration.','FAIR',469),
 (1875,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',469),
 (1876,'','SEVERE',469),
 (1877,'None','GOOD',470),
 (1878,'Distortion not requiring mitigation or mitigated distortion.','FAIR',470),
 (1879,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',470),
 (1880,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',470),
 (1881,'None','GOOD',471),
 (1882,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',471),
 (1883,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',471),
 (1884,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',471),
 (1885,'None','GOOD',472),
 (1886,'Surface white without build-up or leaching without rust staining.','FAIR',472),
 (1887,'Heavy build-up with rust staining.','POOR',472),
 (1888,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',472),
 (1889,'Not applicable','GOOD',473),
 (1890,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',473),
 (1891,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',473),
 (1892,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',473),
 (1893,'None','GOOD',474),
 (1894,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',474),
 (1895,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',474),
 (1896,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',474),
 (1897,'None','GOOD',475),
 (1898,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',475),
 (1899,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',475),
 (1900,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',475),
 (1901,'Connection is in place and functioning as intended.','GOOD',476),
 (1902,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',476),
 (1903,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',476),
 (1904,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',476),
 (1905,'None','GOOD',477),
 (1906,'Distortion not requiring mitigation or mitigated distortion.','FAIR',477),
 (1907,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',477),
 (1908,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',477),
 (1909,'None','GOOD',478),
 (1910,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',478),
 (1911,'Exceeds tolerable limits, but does not warrant structural review.','POOR',478),
 (1912,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',478),
 (1913,'None','GOOD',479),
 (1914,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',479),
 (1915,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',479),
 (1916,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',479),
 (1917,'Not applicable','GOOD',480),
 (1918,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',480),
 (1919,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',480),
 (1920,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',480),
 (1921,'None','GOOD',481),
 (1922,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',481),
 (1923,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',481),
 (1924,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',481),
 (1925,'None','GOOD',482),
 (1926,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',482),
 (1927,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',482),
 (1928,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',482),
 (1929,'Connection is in place and functioning as intended.','GOOD',483),
 (1930,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',483),
 (1931,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',483),
 (1932,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',483),
 (1933,'None or insignificant cracks.','GOOD',484),
 (1934,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',484),
 (1935,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',484),
 (1936,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',484),
 (1937,'None','GOOD',485),
 (1938,'Initiated breakdown or deterioration.','FAIR',485),
 (1939,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',485),
 (1940,'','SEVERE',485),
 (1941,'None','GOOD',486),
 (1942,'Distortion not requiring mitigation or mitigated distortion.','FAIR',486),
 (1943,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',486),
 (1944,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',486),
 (1945,'None','GOOD',487),
 (1946,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',487),
 (1947,'Exceeds tolerable limits, but does not warrant structural review.','POOR',487),
 (1948,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',487),
 (1949,'None','GOOD',488),
 (1950,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',488),
 (1951,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',488),
 (1952,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',488),
 (1953,'None','GOOD',489),
 (1954,'Surface white without build-up or leaching without rust staining.','FAIR',489),
 (1955,'Heavy build-up with rust staining.','POOR',489),
 (1956,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',489),
 (1957,'None','GOOD',490),
 (1958,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',490),
 (1959,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',490),
 (1960,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',490),
 (1961,'Not applicable','GOOD',491),
 (1962,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',491),
 (1963,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',491),
 (1964,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',491),
 (1965,'None','GOOD',492),
 (1966,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',492),
 (1967,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',492),
 (1968,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',492),
 (1969,'None','GOOD',493),
 (1970,'Present without measurable section loss.','FAIR',493),
 (1971,'Present with measurable section loss, but does not warrant structural review.','POOR',493),
 (1972,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',493),
 (1973,'None','GOOD',494),
 (1974,'Present without section loss.','FAIR',494),
 (1975,'Present with section loss, but does not warrant structural review.','POOR',494),
 (1976,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',494),
 (1977,'None or insignificant cracks.','GOOD',495),
 (1978,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',495),
 (1979,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',495),
 (1980,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',495),
 (1981,'None','GOOD',496),
 (1982,'Surface white without build-up or leaching without rust staining.','FAIR',496),
 (1983,'Heavy build-up with rust staining.','POOR',496),
 (1984,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',496),
 (1985,'No abrasion or wearing.','GOOD',497),
 (1986,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',497),
 (1987,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',497),
 (1988,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',497),
 (1989,'None','GOOD',498),
 (1990,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',498),
 (1991,'Exceeds tolerable limits, but does not warrant structural review.','POOR',498),
 (1992,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',498),
 (1993,'None','GOOD',499),
 (1994,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',499),
 (1995,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',499),
 (1996,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',499),
 (1997,'Not applicable','GOOD',500),
 (1998,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',500),
 (1999,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',500),
 (2000,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',500),
 (2001,'None','GOOD',501),
 (2002,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',501),
 (2003,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',501),
 (2004,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',501),
 (2005,'None','GOOD',502),
 (2006,'Present without measurable section loss.','FAIR',502),
 (2007,'Present with measurable section loss, but does not warrant structural review.','POOR',502),
 (2008,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',502),
 (2009,'None','GOOD',503),
 (2010,'Surface white without build-up or leaching without rust staining.','FAIR',503),
 (2011,'Heavy build-up with rust staining.','POOR',503),
 (2012,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',503),
 (2013,'None or insignificant cracks.','GOOD',504),
 (2014,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',504),
 (2015,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',504),
 (2016,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',504),
 (2017,'No abrasion or wearing.','GOOD',505),
 (2018,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',505),
 (2019,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',505),
 (2020,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',505),
 (2021,'None','GOOD',506),
 (2022,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',506),
 (2023,'Exceeds tolerable limits, but does not warrant structural review.','POOR',506),
 (2024,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',506),
 (2025,'None','GOOD',507),
 (2026,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',507),
 (2027,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',507),
 (2028,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',507),
 (2029,'Not applicable','GOOD',508),
 (2030,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',508),
 (2031,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',508),
 (2032,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',508),
 (2033,'Connection is in place and functioning as intended.','GOOD',509),
 (2034,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',509),
 (2035,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',509),
 (2036,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',509),
 (2037,'None','GOOD',510),
 (2038,'Affects less than 10% of the member section.','FAIR',510),
 (2039,'Affects 10% or more of the member but does not warrant structural review.','POOR',510),
 (2040,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',510),
 (2041,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',511),
 (2042,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',511),
 (2043,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',511),
 (2044,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',511),
 (2045,'None','GOOD',512),
 (2046,'Crack that has been arrested through effective measures.','FAIR',512),
 (2047,'Identified crack exists that is not arrested, but does not require structural review','POOR',512),
 (2048,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',512),
 (2049,'None','GOOD',513),
 (2050,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',513),
 (2051,'Length equal to or greater than the member depth, but does not require structural review.','POOR',513),
 (2052,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',513),
 (2053,'None or no measurable section loss.','GOOD',514),
 (2054,'Section loss less than 10% of the member thickness.','FAIR',514),
 (2055,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',514),
 (2056,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',514),
 (2057,'None','GOOD',515),
 (2058,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',515),
 (2059,'Exceeds tolerable limits, but does not warrant structural review.','POOR',515),
 (2060,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',515),
 (2061,'None','GOOD',516),
 (2062,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',516),
 (2063,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',516),
 (2064,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',516),
 (2065,'Not applicable','GOOD',517),
 (2066,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',517),
 (2067,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',517),
 (2068,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',517),
 (2069,'None','GOOD',518),
 (2070,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',518),
 (2071,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',518),
 (2072,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',518),
 (2073,'None','GOOD',519),
 (2074,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',519),
 (2075,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',519),
 (2076,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',519),
 (2077,'Connection is in place and functioning as intended.','GOOD',520),
 (2078,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',520),
 (2079,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',520),
 (2080,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',520),
 (2081,'None','GOOD',521),
 (2082,'Distortion not requiring mitigation or mitigated distortion.','FAIR',521),
 (2083,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',521),
 (2084,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',521),
 (2085,'None','GOOD',522),
 (2086,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',522),
 (2087,'Exceeds tolerable limits, but does not warrant structural review.','POOR',522),
 (2088,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',522),
 (2089,'None','GOOD',523),
 (2090,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',523),
 (2091,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',523),
 (2092,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',523),
 (2093,'Not applicable','GOOD',524),
 (2094,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',524),
 (2095,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',524),
 (2096,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',524),
 (2097,'Connection is in place and functioning as intended.','GOOD',525),
 (2098,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',525),
 (2099,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',525),
 (2100,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',525),
 (2101,'None','GOOD',526),
 (2102,'Affects less than 10% of the member section.','FAIR',526),
 (2103,'Affects 10% or more of the member but does not warrant structural review.','POOR',526),
 (2104,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',526),
 (2105,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',527),
 (2106,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',527),
 (2107,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',527),
 (2108,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',527),
 (2109,'None','GOOD',528),
 (2110,'Crack that has been arrested through effective measures.','FAIR',528),
 (2111,'Identified crack exists that is not arrested, but does not require structural review','POOR',528),
 (2112,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',528),
 (2113,'None','GOOD',529),
 (2114,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',529),
 (2115,'Length equal to or greater than the member depth, but does not require structural review.','POOR',529),
 (2116,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',529),
 (2117,'None or no measurable section loss.','GOOD',530),
 (2118,'Section loss less than 10% of the member thickness.','FAIR',530),
 (2119,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',530),
 (2120,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',530),
 (2121,'None','GOOD',531),
 (2122,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',531),
 (2123,'Exceeds tolerable limits, but does not warrant structural review.','POOR',531),
 (2124,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',531),
 (2125,'None','GOOD',532),
 (2126,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',532),
 (2127,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',532),
 (2128,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',532),
 (2129,'Not applicable','GOOD',533),
 (2130,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',533),
 (2131,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',533),
 (2132,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',533),
 (2133,'None','GOOD',534),
 (2134,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',534),
 (2135,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',534),
 (2136,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',534),
 (2137,'None','GOOD',535),
 (2138,'Present without measurable section loss.','FAIR',535),
 (2139,'Present with measurable section loss, but does not warrant structural review.','POOR',535),
 (2140,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',535),
 (2141,'None','GOOD',536),
 (2142,'Surface white without build-up or leaching without rust staining.','FAIR',536),
 (2143,'Heavy build-up with rust staining.','POOR',536),
 (2144,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',536),
 (2145,'None or insignificant cracks.','GOOD',537),
 (2146,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',537),
 (2147,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',537),
 (2148,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',537),
 (2149,'No abrasion or wearing.','GOOD',538),
 (2150,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',538),
 (2151,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',538),
 (2152,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',538),
 (2153,'None','GOOD',539),
 (2154,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',539),
 (2155,'Exceeds tolerable limits, but does not warrant structural review.','POOR',539),
 (2156,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',539),
 (2157,'None','GOOD',540),
 (2158,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',540),
 (2159,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',540),
 (2160,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',540),
 (2161,'Not applicable','GOOD',541),
 (2162,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',541),
 (2163,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',541),
 (2164,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',541),
 (2165,'None','GOOD',542),
 (2166,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',542),
 (2167,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',542),
 (2168,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',542),
 (2169,'None','GOOD',543),
 (2170,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',543),
 (2171,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',543),
 (2172,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',543),
 (2173,'Connection is in place and functioning as intended.','GOOD',544),
 (2174,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',544),
 (2175,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',544),
 (2176,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',544),
 (2177,'None or insignificant cracks.','GOOD',545),
 (2178,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',545),
 (2179,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',545),
 (2180,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',545),
 (2181,'None','GOOD',546),
 (2182,'Initiated breakdown or deterioration.','FAIR',546),
 (2183,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',546),
 (2184,'','SEVERE',546),
 (2185,'None','GOOD',547),
 (2186,'Distortion not requiring mitigation or mitigated distortion.','FAIR',547),
 (2187,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',547),
 (2188,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',547),
 (2189,'None','GOOD',548),
 (2190,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',548),
 (2191,'Exceeds tolerable limits, but does not warrant structural review.','POOR',548),
 (2192,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',548),
 (2193,'None','GOOD',549),
 (2194,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',549),
 (2195,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',549),
 (2196,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',549),
 (2197,'None','GOOD',550),
 (2198,'Surface white without build-up or leaching without rust staining.','FAIR',550),
 (2199,'Heavy build-up with rust staining.','POOR',550),
 (2200,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',550),
 (2201,'None','GOOD',551),
 (2202,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',551),
 (2203,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',551),
 (2204,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',551),
 (2205,'Not applicable','GOOD',552),
 (2206,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',552),
 (2207,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',552),
 (2208,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',552),
 (2209,'Connection is in place and functioning as intended.','GOOD',553),
 (2210,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',553),
 (2211,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',553),
 (2212,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',553),
 (2213,'None','GOOD',554),
 (2214,'Affects less than 10% of the member section.','FAIR',554),
 (2215,'Affects 10% or more of the member but does not warrant structural review.','POOR',554),
 (2216,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',554),
 (2217,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',555),
 (2218,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',555),
 (2219,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',555),
 (2220,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',555),
 (2221,'None','GOOD',556),
 (2222,'Crack that has been arrested through effective measures.','FAIR',556),
 (2223,'Identified crack exists that is not arrested, but does not require structural review','POOR',556),
 (2224,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',556),
 (2225,'None','GOOD',557),
 (2226,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',557),
 (2227,'Length equal to or greater than the member depth, but does not require structural review.','POOR',557),
 (2228,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',557),
 (2229,'None or no measurable section loss.','GOOD',558),
 (2230,'Section loss less than 10% of the member thickness.','FAIR',558),
 (2231,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',558),
 (2232,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',558),
 (2233,'None','GOOD',559),
 (2234,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',559),
 (2235,'Exceeds tolerable limits, but does not warrant structural review.','POOR',559),
 (2236,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',559),
 (2237,'None','GOOD',560),
 (2238,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',560),
 (2239,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',560),
 (2240,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',560),
 (2241,'Not applicable','GOOD',561),
 (2242,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',561),
 (2243,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',561),
 (2244,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',561),
 (2245,'None','GOOD',562),
 (2246,'Surface white without build-up or leaching without rust staining.','FAIR',562),
 (2247,'Heavy build-up with rust staining.','POOR',562),
 (2248,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',562),
 (2249,'None','GOOD',563),
 (2250,'Cracking or voids in less than 10% of joints.','FAIR',563),
 (2251,'Cracking or voids in 10% or more of the of joints','POOR',563),
 (2252,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',563),
 (2253,'None','GOOD',564),
 (2254,'Block or stone has split or spalled with no shifting.','FAIR',564),
 (2255,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',564),
 (2256,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',564),
 (2257,'None','GOOD',565),
 (2258,'Sound Patch','FAIR',565),
 (2259,'Unsound Patch','POOR',565),
 (2260,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',565),
 (2261,'None','GOOD',566),
 (2262,'Block or stone has shifted slightly out of alignment.','FAIR',566),
 (2263,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',566),
 (2264,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',566),
 (2265,'None','GOOD',567),
 (2266,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',567),
 (2267,'Exceeds tolerable limits, but does not warrant structural review.','POOR',567),
 (2268,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',567),
 (2269,'None','GOOD',568),
 (2270,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',568),
 (2271,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',568),
 (2272,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',568),
 (2273,'Not applicable','GOOD',569),
 (2274,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',569),
 (2275,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',569),
 (2276,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',569),
 (2277,'None','GOOD',570),
 (2278,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',570),
 (2279,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',570),
 (2280,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',570),
 (2281,'None','GOOD',571),
 (2282,'Present without measurable section loss.','FAIR',571),
 (2283,'Present with measurable section loss, but does not warrant structural review.','POOR',571),
 (2284,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',571),
 (2285,'None','GOOD',572),
 (2286,'Surface white without build-up or leaching without rust staining.','FAIR',572),
 (2287,'Heavy build-up with rust staining.','POOR',572),
 (2288,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',572),
 (2289,'None or insignificant cracks.','GOOD',573),
 (2290,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',573),
 (2291,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',573),
 (2292,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',573),
 (2293,'No abrasion or wearing.','GOOD',574),
 (2294,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',574),
 (2295,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',574),
 (2296,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',574),
 (2297,'None','GOOD',575),
 (2298,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',575),
 (2299,'Exceeds tolerable limits, but does not warrant structural review.','POOR',575),
 (2300,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',575),
 (2301,'None','GOOD',576),
 (2302,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',576),
 (2303,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',576),
 (2304,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',576),
 (2305,'Not applicable','GOOD',577),
 (2306,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',577),
 (2307,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',577),
 (2308,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',577),
 (2309,'None','GOOD',578),
 (2310,'Distortion not requiring mitigation or mitigated distortion.','FAIR',578),
 (2311,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',578),
 (2312,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',578),
 (2313,'None','GOOD',579),
 (2314,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',579),
 (2315,'Exceeds tolerable limits, but does not warrant structural review.','POOR',579),
 (2316,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',579),
 (2317,'None','GOOD',580),
 (2318,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',580),
 (2319,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',580),
 (2320,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',580),
 (2321,'None','GOOD',581),
 (2322,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',581),
 (2323,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',581),
 (2324,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',581),
 (2325,'None','GOOD',582),
 (2326,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',582),
 (2327,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',582),
 (2328,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',582),
 (2329,'Connection is in place and functioning as intended.','GOOD',583),
 (2330,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',583),
 (2331,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',583),
 (2332,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',583),
 (2333,'Not applicable','GOOD',584),
 (2334,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',584),
 (2335,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',584),
 (2336,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',584),
 (2337,'None','GOOD',585),
 (2338,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',585),
 (2339,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',585),
 (2340,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',585),
 (2341,'None','GOOD',586),
 (2342,'Present without measurable section loss.','FAIR',586),
 (2343,'Present with measurable section loss, but does not warrant structural review.','POOR',586),
 (2344,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',586),
 (2345,'None','GOOD',587),
 (2346,'Present without section loss.','FAIR',587),
 (2347,'Present with section loss, but does not warrant structural review.','POOR',587),
 (2348,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',587),
 (2349,'No abrasion or wearing.','GOOD',588),
 (2350,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',588),
 (2351,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',588),
 (2352,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',588),
 (2353,'None','GOOD',589),
 (2354,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',589),
 (2355,'Exceeds tolerable limits, but does not warrant structural review.','POOR',589),
 (2356,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',589),
 (2357,'None or insignificant cracks.','GOOD',590),
 (2358,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',590),
 (2359,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',590),
 (2360,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',590),
 (2361,'None','GOOD',591),
 (2362,'Surface white without build-up or leaching without rust staining.','FAIR',591),
 (2363,'Heavy build-up with rust staining.','POOR',591),
 (2364,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',591),
 (2365,'None','GOOD',592),
 (2366,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',592),
 (2367,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',592),
 (2368,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',592),
 (2369,'Not applicable','GOOD',593),
 (2370,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',593),
 (2371,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',593),
 (2372,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',593),
 (2373,'None','GOOD',594),
 (2374,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',594),
 (2375,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',594),
 (2376,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',594),
 (2377,'None','GOOD',595),
 (2378,'Present without measurable section loss.','FAIR',595),
 (2379,'Present with measurable section loss, but does not warrant structural review.','POOR',595),
 (2380,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',595),
 (2381,'None','GOOD',596),
 (2382,'Surface white without build-up or leaching without rust staining.','FAIR',596),
 (2383,'Heavy build-up with rust staining.','POOR',596),
 (2384,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',596),
 (2385,'None or insignificant cracks.','GOOD',597),
 (2386,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',597),
 (2387,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',597),
 (2388,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',597),
 (2389,'No abrasion or wearing.','GOOD',598),
 (2390,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',598),
 (2391,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',598),
 (2392,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',598),
 (2393,'None','GOOD',599),
 (2394,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',599),
 (2395,'Exceeds tolerable limits, but does not warrant structural review.','POOR',599),
 (2396,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',599),
 (2397,'None','GOOD',600),
 (2398,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',600),
 (2399,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',600),
 (2400,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',600),
 (2401,'Not applicable','GOOD',601),
 (2402,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',601),
 (2403,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',601),
 (2404,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',601),
 (2405,'Connection is in place and functioning as intended.','GOOD',602),
 (2406,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',602),
 (2407,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',602),
 (2408,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',602),
 (2409,'None','GOOD',603),
 (2410,'Affects less than 10% of the member section.','FAIR',603),
 (2411,'Affects 10% or more of the member but does not warrant structural review.','POOR',603),
 (2412,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',603),
 (2413,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',604),
 (2414,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',604),
 (2415,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',604),
 (2416,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',604),
 (2417,'None','GOOD',605),
 (2418,'Crack that has been arrested through effective measures.','FAIR',605),
 (2419,'Identified crack exists that is not arrested, but does not require structural review','POOR',605),
 (2420,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',605),
 (2421,'None','GOOD',606),
 (2422,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',606),
 (2423,'Length equal to or greater than the member depth, but does not require structural review.','POOR',606),
 (2424,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',606),
 (2425,'None or no measurable section loss.','GOOD',607),
 (2426,'Section loss less than 10% of the member thickness.','FAIR',607),
 (2427,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',607),
 (2428,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',607),
 (2429,'None','GOOD',608),
 (2430,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',608),
 (2431,'Exceeds tolerable limits, but does not warrant structural review.','POOR',608),
 (2432,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',608),
 (2433,'None','GOOD',609),
 (2434,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',609),
 (2435,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',609),
 (2436,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',609),
 (2437,'Not applicable','GOOD',610),
 (2438,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',610),
 (2439,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',610),
 (2440,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',610),
 (2441,'None','GOOD',611),
 (2442,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',611),
 (2443,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',611),
 (2444,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',611),
 (2445,'None','GOOD',612),
 (2446,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',612),
 (2447,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',612),
 (2448,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',612),
 (2449,'Connection is in place and functioning as intended.','GOOD',613),
 (2450,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',613),
 (2451,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',613),
 (2452,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',613),
 (2453,'None or insignificant cracks.','GOOD',614),
 (2454,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',614),
 (2455,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',614),
 (2456,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',614),
 (2457,'None','GOOD',615),
 (2458,'Initiated breakdown or deterioration.','FAIR',615),
 (2459,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',615),
 (2460,'','SEVERE',615),
 (2461,'None','GOOD',616),
 (2462,'Distortion not requiring mitigation or mitigated distortion.','FAIR',616),
 (2463,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',616),
 (2464,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',616),
 (2465,'None','GOOD',617),
 (2466,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',617),
 (2467,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',617),
 (2468,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',617),
 (2469,'None','GOOD',618),
 (2470,'Surface white without build-up or leaching without rust staining.','FAIR',618),
 (2471,'Heavy build-up with rust staining.','POOR',618),
 (2472,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',618),
 (2473,'None','GOOD',619),
 (2474,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',619),
 (2475,'Exceeds tolerable limits, but does not warrant structural review.','POOR',619),
 (2476,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',619),
 (2477,'None','GOOD',620),
 (2478,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',620),
 (2479,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',620),
 (2480,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',620),
 (2481,'Not applicable','GOOD',621),
 (2482,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',621),
 (2483,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',621),
 (2484,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',621),
 (2485,'None','GOOD',622),
 (2486,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',622),
 (2487,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',622),
 (2488,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',622),
 (2489,'None','GOOD',623),
 (2490,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',623),
 (2491,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',623),
 (2492,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',623),
 (2493,'Connection is in place and functioning as intended.','GOOD',624),
 (2494,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',624),
 (2495,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',624),
 (2496,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',624),
 (2497,'None','GOOD',625),
 (2498,'Distortion not requiring mitigation or mitigated distortion.','FAIR',625),
 (2499,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',625),
 (2500,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',625),
 (2501,'None','GOOD',626),
 (2502,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',626),
 (2503,'Exceeds tolerable limits, but does not warrant structural review.','POOR',626),
 (2504,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',626),
 (2505,'None','GOOD',627),
 (2506,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',627),
 (2507,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',627),
 (2508,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',627),
 (2509,'Not applicable','GOOD',628),
 (2510,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',628),
 (2511,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',628),
 (2512,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',628),
 (2513,'None','GOOD',629),
 (2514,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',629),
 (2515,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',629),
 (2516,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',629),
 (2517,'None or insignificant cracks.','GOOD',630),
 (2518,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',630),
 (2519,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',630),
 (2520,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',630),
 (2521,'None','GOOD',631),
 (2522,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',631),
 (2523,'Exceeds tolerable limits, but does not warrant structural review.','POOR',631),
 (2524,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',631),
 (2525,'None','GOOD',632),
 (2526,'Distortion not requiring mitigation or mitigated distortion.','FAIR',632),
 (2527,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',632),
 (2528,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',632),
 (2529,'None','GOOD',633),
 (2530,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',633),
 (2531,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',633),
 (2532,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',633),
 (2533,'Not applicable','GOOD',634),
 (2534,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',634),
 (2535,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',634),
 (2536,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',634),
 (2537,'None','GOOD',635),
 (2538,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',635),
 (2539,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',635),
 (2540,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',635),
 (2541,'None','GOOD',636),
 (2542,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',636),
 (2543,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',636),
 (2544,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',636),
 (2545,'Connection is in place and functioning as intended.','GOOD',637),
 (2546,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',637),
 (2547,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',637),
 (2548,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',637),
 (2549,'None','GOOD',638),
 (2550,'Distortion not requiring mitigation or mitigated distortion.','FAIR',638),
 (2551,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',638),
 (2552,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',638),
 (2553,'Not applicable','GOOD',639),
 (2554,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',639),
 (2555,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',639),
 (2556,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',639),
 (2557,'None','GOOD',640),
 (2558,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',640),
 (2559,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',640),
 (2560,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',640),
 (2561,'None','GOOD',641),
 (2562,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',641),
 (2563,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',641),
 (2564,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',641),
 (2565,'Connection is in place and functioning as intended.','GOOD',642),
 (2566,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',642),
 (2567,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',642),
 (2568,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',642),
 (2569,'None','GOOD',643),
 (2570,'Distortion not requiring mitigation or mitigated distortion.','FAIR',643),
 (2571,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',643),
 (2572,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',643),
 (2573,'Not applicable','GOOD',644),
 (2574,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',644),
 (2575,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',644),
 (2576,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',644),
 (2577,'None','GOOD',645),
 (2578,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',645),
 (2579,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',645),
 (2580,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',645),
 (2581,'None','GOOD',646),
 (2582,'Present without measurable section loss.','FAIR',646),
 (2583,'Present with measurable section loss, but does not warrant structural review.','POOR',646),
 (2584,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',646),
 (2585,'None','GOOD',647),
 (2586,'Initiated breakdown or deterioration.','FAIR',647),
 (2587,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',647),
 (2588,'','SEVERE',647),
 (2589,'None or insignificant cracks.','GOOD',648),
 (2590,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',648),
 (2591,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',648),
 (2592,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',648),
 (2593,'None','GOOD',649),
 (2594,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',649),
 (2595,'Exceeds tolerable limits, but does not warrant structural review.','POOR',649),
 (2596,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',649),
 (2597,'None','GOOD',650),
 (2598,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',650),
 (2599,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',650),
 (2600,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',650),
 (2601,'Not applicable','GOOD',651),
 (2602,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',651),
 (2603,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',651),
 (2604,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',651),
 (2605,'None','GOOD',652),
 (2606,'Distortion not requiring mitigation or mitigated distortion.','FAIR',652),
 (2607,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',652),
 (2608,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',652),
 (2609,'None','GOOD',653),
 (2610,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',653),
 (2611,'Exceeds tolerable limits, but does not warrant structural review.','POOR',653),
 (2612,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',653),
 (2613,'None','GOOD',654),
 (2614,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',654),
 (2615,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',654),
 (2616,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',654),
 (2617,'None','GOOD',655),
 (2618,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',655),
 (2619,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',655),
 (2620,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',655),
 (2621,'None','GOOD',656),
 (2622,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',656),
 (2623,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',656),
 (2624,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',656),
 (2625,'Connection is in place and functioning as intended.','GOOD',657),
 (2626,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',657),
 (2627,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',657),
 (2628,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',657),
 (2629,'Not applicable','GOOD',658),
 (2630,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',658),
 (2631,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',658),
 (2632,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',658),
 (2633,'None','GOOD',659),
 (2634,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',659),
 (2635,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',659),
 (2636,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',659),
 (2637,'None','GOOD',660),
 (2638,'Present without measurable section loss.','FAIR',660),
 (2639,'Present with measurable section loss, but does not warrant structural review.','POOR',660),
 (2640,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',660),
 (2641,'None','GOOD',661),
 (2642,'Surface white without build-up or leaching without rust staining.','FAIR',661),
 (2643,'Heavy build-up with rust staining.','POOR',661),
 (2644,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',661),
 (2645,'None or insignificant cracks.','GOOD',662),
 (2646,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',662),
 (2647,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',662),
 (2648,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',662),
 (2649,'No abrasion or wearing.','GOOD',663),
 (2650,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',663),
 (2651,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',663),
 (2652,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',663),
 (2653,'None','GOOD',664),
 (2654,'Distortion not requiring mitigation or mitigated distortion.','FAIR',664),
 (2655,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',664),
 (2656,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',664),
 (2657,'None','GOOD',665),
 (2658,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',665),
 (2659,'Exceeds tolerable limits, but does not warrant structural review.','POOR',665),
 (2660,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',665),
 (2661,'None','GOOD',666),
 (2662,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',666),
 (2663,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',666),
 (2664,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',666),
 (2665,'Not applicable','GOOD',667),
 (2666,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',667),
 (2667,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',667),
 (2668,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',667),
 (2669,'Connection is in place and functioning as intended.','GOOD',668),
 (2670,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',668),
 (2671,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',668),
 (2672,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',668),
 (2673,'None','GOOD',669),
 (2674,'Affects less than 10% of the member section.','FAIR',669),
 (2675,'Affects 10% or more of the member but does not warrant structural review.','POOR',669),
 (2676,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',669),
 (2677,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',670),
 (2678,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',670),
 (2679,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',670),
 (2680,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',670),
 (2681,'None','GOOD',671),
 (2682,'Crack that has been arrested through effective measures.','FAIR',671),
 (2683,'Identified crack exists that is not arrested, but does not require structural review','POOR',671),
 (2684,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',671),
 (2685,'None','GOOD',672),
 (2686,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',672),
 (2687,'Length equal to or greater than the member depth, but does not require structural review.','POOR',672),
 (2688,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',672),
 (2689,'None or no measurable section loss.','GOOD',673),
 (2690,'Section loss less than 10% of the member thickness.','FAIR',673),
 (2691,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',673),
 (2692,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',673),
 (2693,'None','GOOD',674),
 (2694,'Distortion not requiring mitigation or mitigated distortion.','FAIR',674),
 (2695,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',674),
 (2696,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',674),
 (2697,'None','GOOD',675),
 (2698,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',675),
 (2699,'Exceeds tolerable limits, but does not warrant structural review.','POOR',675),
 (2700,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',675),
 (2701,'None','GOOD',676),
 (2702,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',676),
 (2703,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',676),
 (2704,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',676),
 (2705,'Not applicable','GOOD',677),
 (2706,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',677),
 (2707,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',677),
 (2708,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',677),
 (2709,'None','GOOD',678),
 (2710,'Freckled Rust.
Corrosion of the steel has initiated.','FAIR',678),
 (2711,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',678),
 (2712,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',678),
 (2713,'None','GOOD',679),
 (2714,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',679),
 (2715,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',679),
 (2716,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',679),
 (2717,'Connection is in place and functioning as intended.','GOOD',680),
 (2718,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',680),
 (2719,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',680),
 (2720,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',680),
 (2721,'None','GOOD',681),
 (2722,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',681),
 (2723,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',681),
 (2724,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',681),
 (2725,'None','GOOD',682),
 (2726,'Surface white without build-up or leaching without rust staining.','FAIR',682),
 (2727,'Heavy build-up with rust staining.','POOR',682),
 (2728,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',682),
 (2729,'None or insignificant cracks.','GOOD',683),
 (2730,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',683),
 (2731,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',683),
 (2732,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',683),
 (2733,'None','GOOD',684),
 (2734,'Initiated breakdown or deterioration.','FAIR',684),
 (2735,'Significant deterioration or breakdown, but does not warrant structural review.','POOR',684),
 (2736,'','SEVERE',684),
 (2737,'None','GOOD',685),
 (2738,'Distortion not requiring mitigation or mitigated distortion.','FAIR',685),
 (2739,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',685),
 (2740,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',685),
 (2741,'None','GOOD',686),
 (2742,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',686),
 (2743,'Exceeds tolerable limits, but does not warrant structural review.','POOR',686),
 (2744,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',686),
 (2745,'None','GOOD',687),
 (2746,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',687),
 (2747,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',687),
 (2748,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',687),
 (2749,'Not applicable','GOOD',688),
 (2750,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',688),
 (2751,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',688),
 (2752,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',688),
 (2753,'None','GOOD',689),
 (2754,'Surface white without build-up or leaching without rust staining.','FAIR',689),
 (2755,'Heavy build-up with rust staining.','POOR',689),
 (2756,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',689),
 (2757,'None','GOOD',690),
 (2758,'Cracking or voids in less than 10% of joints.','FAIR',690),
 (2759,'Cracking or voids in 10% or more of the of joints','POOR',690),
 (2760,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',690),
 (2761,'None','GOOD',691),
 (2762,'Block or stone has split or spalled with no shifting.','FAIR',691),
 (2763,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',691),
 (2764,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',691),
 (2765,'None','GOOD',692),
 (2766,'Sound Patch','FAIR',692),
 (2767,'Unsound Patch','POOR',692),
 (2768,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',692),
 (2769,'None','GOOD',693),
 (2770,'Block or stone has shifted slightly out of alignment.','FAIR',693),
 (2771,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',693),
 (2772,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',693),
 (2773,'None','GOOD',694),
 (2774,'Distortion not requiring mitigation or mitigated distortion.','FAIR',694),
 (2775,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',694),
 (2776,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',694),
 (2777,'None','GOOD',695),
 (2778,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',695),
 (2779,'Exceeds tolerable limits, but does not warrant structural review.','POOR',695),
 (2780,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',695),
 (2781,'None','GOOD',696),
 (2782,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',696),
 (2783,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',696),
 (2784,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',696),
 (2785,'Not applicable','GOOD',697),
 (2786,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',697),
 (2787,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',697),
 (2788,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',697),
 (2789,'None','GOOD',698),
 (2790,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',698),
 (2791,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',698),
 (2792,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',698),
 (2793,'None','GOOD',699),
 (2794,'Present without measurable section loss.','FAIR',699),
 (2795,'Present with measurable section loss, but does not warrant structural review.','POOR',699),
 (2796,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',699),
 (2797,'None','GOOD',700),
 (2798,'Present without section loss.','FAIR',700),
 (2799,'Present with section loss, but does not warrant structural review.','POOR',700),
 (2800,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',700),
 (2801,'None or insignificant cracks.','GOOD',701),
 (2802,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',701),
 (2803,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',701),
 (2804,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',701),
 (2805,'None','GOOD',702),
 (2806,'Surface white without build-up or leaching without rust staining.','FAIR',702),
 (2807,'Heavy build-up with rust staining.','POOR',702),
 (2808,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',702),
 (2809,'No abrasion or wearing.','GOOD',703),
 (2810,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',703),
 (2811,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',703),
 (2812,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',703),
 (2813,'None','GOOD',704),
 (2814,'Distortion not requiring mitigation or mitigated distortion.','FAIR',704),
 (2815,'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.','POOR',704),
 (2816,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',704),
 (2817,'None','GOOD',705),
 (2818,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',705),
 (2819,'Exceeds tolerable limits, but does not warrant structural review.','POOR',705),
 (2820,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',705),
 (2821,'None','GOOD',706),
 (2822,'Exists within tolerable limits or has been arrested with effective countermeasures.','FAIR',706),
 (2823,'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.','POOR',706),
 (2824,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',706),
 (2825,'Not applicable','GOOD',707),
 (2826,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',707),
 (2827,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',707),
 (2828,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',707),
 (2829,'None','GOOD',708),
 (2830,'Minimal.
Minor dripping through the joint.','FAIR',708),
 (2831,'Moderate.
More than a drip and less than free flow of water.','POOR',708),
 (2832,'Free flow of water through the joint.','SEVERE',708),
 (2833,'Fully Adhered','GOOD',709),
 (2834,'Adhered for more than 50% of the joint height.','FAIR',709),
 (2835,'Adhered 50% or less of joint height but still some adhesion','POOR',709),
 (2836,'Complete loss of adhesion','SEVERE',709),
 (2837,'None','GOOD',710),
 (2838,'Seal abrasion without punctures.','FAIR',710),
 (2839,'Punctured or ripped or partially pulled out.','POOR',710),
 (2840,'Punctured completely through, pulled out, or missing.','SEVERE',710),
 (2841,'None','GOOD',711),
 (2842,'Surface crack','FAIR',711),
 (2843,'Crack that partially penetrates the seal.','POOR',711),
 (2844,'Crack that fully penetrates the seal.','SEVERE',711),
 (2845,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',712),
 (2846,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',712),
 (2847,'Completely filled and impacts joint movement.','POOR',712),
 (2848,'Completely filled and prevents joint movement.','SEVERE',712),
 (2849,'Sound.
No spall, delamination or unsound patch.','GOOD',713),
 (2850,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',713),
 (2851,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',713),
 (2852,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',713),
 (2853,'None','GOOD',714),
 (2854,'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.','FAIR',714),
 (2855,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning','POOR',714),
 (2856,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',714),
 (2857,'Not applicable','GOOD',715),
 (2858,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',715),
 (2859,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',715),
 (2860,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',715),
 (2861,'None','GOOD',716),
 (2862,'Minimal.
Minor dripping through the joint.','FAIR',716),
 (2863,'Moderate.
More than a drip and less than free flow of water.','POOR',716),
 (2864,'Free flow of water through the joint.','SEVERE',716),
 (2865,'Fully Adhered','GOOD',717),
 (2866,'Adhered for more than 50% of the joint height.','FAIR',717),
 (2867,'Adhered 50% or less of joint height but still some adhesion','POOR',717),
 (2868,'Complete loss of adhesion','SEVERE',717),
 (2869,'None','GOOD',718),
 (2870,'Seal abrasion without punctures.','FAIR',718),
 (2871,'Punctured or ripped or partially pulled out.','POOR',718),
 (2872,'Punctured completely through, pulled out, or missing.','SEVERE',718),
 (2873,'None','GOOD',719),
 (2874,'Surface crack','FAIR',719),
 (2875,'Crack that partially penetrates the seal.','POOR',719),
 (2876,'Crack that fully penetrates the seal.','SEVERE',719),
 (2877,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',720),
 (2878,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',720),
 (2879,'Completely filled and impacts joint movement.','POOR',720),
 (2880,'Completely filled and prevents joint movement.','SEVERE',720),
 (2881,'Sound.
No spall, delamination or unsound patch.','GOOD',721),
 (2882,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',721),
 (2883,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',721),
 (2884,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',721),
 (2885,'Not applicable','GOOD',722),
 (2886,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',722),
 (2887,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',722),
 (2888,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',722),
 (2889,'None','GOOD',723),
 (2890,'Minimal.
Minor dripping through the joint.','FAIR',723),
 (2891,'Moderate.
More than a drip and less than free flow of water.','POOR',723),
 (2892,'Free flow of water through the joint.','SEVERE',723),
 (2893,'Fully Adhered','GOOD',724),
 (2894,'Adhered for more than 50% of the joint height.','FAIR',724),
 (2895,'Adhered 50% or less of joint height but still some adhesion','POOR',724),
 (2896,'Complete loss of adhesion','SEVERE',724),
 (2897,'None','GOOD',725),
 (2898,'Seal abrasion without punctures.','FAIR',725),
 (2899,'Punctured or ripped or partially pulled out.','POOR',725),
 (2900,'Punctured completely through, pulled out, or missing.','SEVERE',725),
 (2901,'None','GOOD',726),
 (2902,'Surface crack','FAIR',726),
 (2903,'Crack that partially penetrates the seal.','POOR',726),
 (2904,'Crack that fully penetrates the seal.','SEVERE',726),
 (2905,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',727),
 (2906,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',727),
 (2907,'Completely filled and impacts joint movement.','POOR',727),
 (2908,'Completely filled and prevents joint movement.','SEVERE',727),
 (2909,'Sound.
No spall, delamination or unsound patch.','GOOD',728),
 (2910,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',728),
 (2911,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',728),
 (2912,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',728),
 (2913,'Not applicable','GOOD',729),
 (2914,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',729),
 (2915,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',729),
 (2916,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',729),
 (2917,'None','GOOD',730),
 (2918,'Minimal.
Minor dripping through the joint.','FAIR',730),
 (2919,'Moderate.
More than a drip and less than free flow of water.','POOR',730),
 (2920,'Free flow of water through the joint.','SEVERE',730),
 (2921,'Fully Adhered','GOOD',731),
 (2922,'Adhered for more than 50% of the joint height.','FAIR',731),
 (2923,'Adhered 50% or less of joint height but still some adhesion','POOR',731),
 (2924,'Complete loss of adhesion','SEVERE',731),
 (2925,'None','GOOD',732),
 (2926,'Seal abrasion without punctures.','FAIR',732),
 (2927,'Punctured or ripped or partially pulled out.','POOR',732),
 (2928,'Punctured completely through, pulled out, or missing.','SEVERE',732),
 (2929,'None','GOOD',733),
 (2930,'Surface crack','FAIR',733),
 (2931,'Crack that partially penetrates the seal.','POOR',733),
 (2932,'Crack that fully penetrates the seal.','SEVERE',733),
 (2933,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',734),
 (2934,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',734),
 (2935,'Completely filled and impacts joint movement.','POOR',734),
 (2936,'Completely filled and prevents joint movement.','SEVERE',734),
 (2937,'Sound.
No spall, delamination or unsound patch.','GOOD',735),
 (2938,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',735),
 (2939,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',735),
 (2940,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',735),
 (2941,'None','GOOD',736),
 (2942,'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.','FAIR',736),
 (2943,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning','POOR',736),
 (2944,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',736),
 (2945,'Not applicable','GOOD',737),
 (2946,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',737),
 (2947,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',737),
 (2948,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',737),
 (2949,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',738),
 (2950,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',738),
 (2951,'Completely filled and impacts joint movement.','POOR',738),
 (2952,'Completely filled and prevents joint movement.','SEVERE',738),
 (2953,'Sound.
No spall, delamination or unsound patch.','GOOD',739),
 (2954,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',739),
 (2955,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',739),
 (2956,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',739),
 (2957,'Not applicable','GOOD',740),
 (2958,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',740),
 (2959,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',740),
 (2960,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',740),
 (2961,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',741),
 (2962,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',741),
 (2963,'Completely filled and impacts joint movement.','POOR',741),
 (2964,'Completely filled and prevents joint movement.','SEVERE',741),
 (2965,'Sound.
No spall, delamination or unsound patch.','GOOD',742),
 (2966,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',742),
 (2967,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',742),
 (2968,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',742),
 (2969,'None','GOOD',743),
 (2970,'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.','FAIR',743),
 (2971,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning','POOR',743),
 (2972,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',743),
 (2973,'Not applicable','GOOD',744),
 (2974,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',744),
 (2975,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',744),
 (2976,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',744),
 (2977,'None','GOOD',745),
 (2978,'Minimal.
Minor dripping through the joint.','FAIR',745),
 (2979,'Moderate.
More than a drip and less than free flow of water.','POOR',745),
 (2980,'Free flow of water through the joint.','SEVERE',745),
 (2981,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',746),
 (2982,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',746),
 (2983,'Completely filled and impacts joint movement.','POOR',746),
 (2984,'Completely filled and prevents joint movement.','SEVERE',746),
 (2985,'Sound.
No spall, delamination or unsound patch.','GOOD',747),
 (2986,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',747),
 (2987,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',747),
 (2988,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',747),
 (2989,'None','GOOD',748),
 (2990,'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.','FAIR',748),
 (2991,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning','POOR',748),
 (2992,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',748),
 (2993,'Not applicable','GOOD',749),
 (2994,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',749),
 (2995,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',749),
 (2996,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',749),
 (2997,'None','GOOD',750),
 (2998,'Minimal.
Minor dripping through the joint.','FAIR',750),
 (2999,'Moderate.
More than a drip and less than free flow of water.','POOR',750),
 (3000,'Free flow of water through the joint.','SEVERE',750),
 (3001,'Fully Adhered','GOOD',751),
 (3002,'Adhered for more than 50% of the joint height.','FAIR',751),
 (3003,'Adhered 50% or less of joint height but still some adhesion','POOR',751),
 (3004,'Complete loss of adhesion','SEVERE',751),
 (3005,'Fully Adhered','GOOD',752),
 (3006,'Adhered for more than 50% of the joint height.','FAIR',752),
 (3007,'Adhered 50% or less of joint height but still some adhesion','POOR',752),
 (3008,'Complete loss of adhesion','SEVERE',752),
 (3009,'Not applicable','GOOD',753),
 (3010,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',753),
 (3011,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',753),
 (3012,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',753),
 (3013,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',754),
 (3014,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',754),
 (3015,'Completely filled and impacts joint movement.','POOR',754),
 (3016,'Completely filled and prevents joint movement.','SEVERE',754),
 (3017,'Sound.
No spall, delamination or unsound patch.','GOOD',755),
 (3018,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',755),
 (3019,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',755),
 (3020,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',755),
 (3021,'None','GOOD',756),
 (3022,'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.','FAIR',756),
 (3023,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning','POOR',756),
 (3024,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',756),
 (3025,'Not applicable','GOOD',757),
 (3026,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',757),
 (3027,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',757),
 (3028,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',757),
 (3029,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',758),
 (3030,'Partially filled with hard- packed material, but still allowing free movement.','FAIR',758),
 (3031,'Completely filled and impacts joint movement.','POOR',758),
 (3032,'Completely filled and prevents joint movement.','SEVERE',758),
 (3033,'Sound.
No spall, delamination or unsound patch.','GOOD',759),
 (3034,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.','FAIR',759),
 (3035,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.','POOR',759),
 (3036,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',759),
 (3037,'None','GOOD',760),
 (3038,'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.','FAIR',760),
 (3039,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning','POOR',760),
 (3040,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',760),
 (3041,'Not applicable','GOOD',761),
 (3042,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',761),
 (3043,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',761),
 (3044,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',761),
 (3045,'None','GOOD',762),
 (3046,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',762),
 (3047,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',762),
 (3048,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',762),
 (3049,'None','GOOD',763),
 (3050,'Present without measurable section loss.','FAIR',763),
 (3051,'Present with measurable section loss, but does not warrant structural review.','POOR',763),
 (3052,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',763),
 (3053,'None','GOOD',764),
 (3054,'Present without section loss.','FAIR',764),
 (3055,'Present with section loss, but does not warrant structural review.','POOR',764),
 (3056,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',764),
 (3057,'None or insignificant cracks.','GOOD',765),
 (3058,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.','FAIR',765),
 (3059,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.','POOR',765),
 (3060,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',765),
 (3061,'No abrasion or wearing.','GOOD',766),
 (3062,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',766),
 (3063,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',766),
 (3064,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',766),
 (3065,'None','GOOD',767),
 (3066,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',767),
 (3067,'Exceeds tolerable limits, but does not warrant structural review.','POOR',767),
 (3068,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',767),
 (3069,'Not applicable','GOOD',768),
 (3070,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',768),
 (3071,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',768),
 (3072,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',768),
 (3073,'None','GOOD',769),
 (3074,'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.','FAIR',769),
 (3075,'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.','POOR',769),
 (3076,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',769),
 (3077,'None','GOOD',770),
 (3078,'Present without measurable section loss.','FAIR',770),
 (3079,'Present with measurable section loss, but does not warrant structural review.','POOR',770),
 (3080,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',770),
 (3081,'None or insignificant cracks.','GOOD',771),
 (3082,'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.','FAIR',771),
 (3083,'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.','POOR',771),
 (3084,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',771),
 (3085,'No abrasion or wearing.','GOOD',772),
 (3086,'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.','FAIR',772),
 (3087,'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.','POOR',772),
 (3088,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',772),
 (3089,'None','GOOD',773),
 (3090,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',773),
 (3091,'Exceeds tolerable limits, but does not warrant structural review.','POOR',773),
 (3092,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',773),
 (3093,'Not applicable','GOOD',774),
 (3094,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',774),
 (3095,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',774),
 (3096,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',774),
 (3097,'None','GOOD',775),
 (3098,'Patched area that is sound.
Partial depth pothole.','FAIR',775),
 (3099,'Patched area that is unsound or showing distress.
Full depth pothole.','POOR',775),
 (3100,'The wearing surface is no longer effective.','SEVERE',775),
 (3101,'Sealed Cracks','GOOD',776),
 (3102,'Crack width 0.25–0.5 inches wide.','FAIR',776),
 (3103,'Width of more than 0.5 in. wide','POOR',776),
 (3104,'The wearing surface is no longer effective.','SEVERE',776),
 (3105,'Fully effective.
No evidence of leakage or further deterioration of the protected element.','GOOD',777),
 (3106,'Substantially effective.
Deterioration of the protected element has slowed.','FAIR',777),
 (3107,'Limited effectiveness.
Deterioration of the protected element has progressed.','POOR',777),
 (3108,'The wearing surface is no longer effective.','SEVERE',777),
 (3109,'Not applicable','GOOD',778),
 (3110,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',778),
 (3111,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',778),
 (3112,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',778),
 (3113,'None','GOOD',779),
 (3114,'Patched area that is sound.
Partial depth pothole.','FAIR',779),
 (3115,'Patched area that is unsound or showing distress.
Full depth pothole.','POOR',779),
 (3116,'The wearing surface is no longer effective.','SEVERE',779),
 (3117,'Sealed Cracks','GOOD',780),
 (3118,'Crack width 0.25–0.5 inches wide.','FAIR',780),
 (3119,'Width of more than 0.5 in. wide','POOR',780),
 (3120,'The wearing surface is no longer effective.','SEVERE',780),
 (3121,'Fully effective.
No evidence of leakage or further deterioration of the protected element.','GOOD',781),
 (3122,'Substantially effective.
Deterioration of the protected element has slowed.','FAIR',781),
 (3123,'Limited effectiveness.
Deterioration of the protected element has progressed.','POOR',781),
 (3124,'The wearing surface is no longer effective.','SEVERE',781),
 (3125,'Not applicable','GOOD',782),
 (3126,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',782),
 (3127,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',782),
 (3128,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',782),
 (3129,'None','GOOD',783),
 (3130,'Patched area that is sound.
Partial depth pothole.','FAIR',783),
 (3131,'Patched area that is unsound or showing distress.
Full depth pothole.','POOR',783),
 (3132,'The wearing surface is no longer effective.','SEVERE',783),
 (3133,'Sealed Cracks','GOOD',784),
 (3134,'Crack width 0.25–0.5 inches wide.','FAIR',784),
 (3135,'Width of more than 0.5 in. wide','POOR',784),
 (3136,'The wearing surface is no longer effective.','SEVERE',784),
 (3137,'Fully effective.
No evidence of leakage or further deterioration of the protected element.','GOOD',785),
 (3138,'Substantially effective.
Deterioration of the protected element has slowed.','FAIR',785),
 (3139,'Limited effectiveness.
Deterioration of the protected element has progressed.','POOR',785),
 (3140,'The wearing surface is no longer effective.','SEVERE',785),
 (3141,'Not applicable','GOOD',786),
 (3142,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',786),
 (3143,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',786),
 (3144,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',786),
 (3145,'Connection is in place and functioning as intended.','GOOD',787),
 (3146,'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.','FAIR',787),
 (3147,'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.','POOR',787),
 (3148,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',787),
 (3149,'None','GOOD',788),
 (3150,'Affects less than 10% of the member section.','FAIR',788),
 (3151,'Affects 10% or more of the member but does not warrant structural review.','POOR',788),
 (3152,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',788),
 (3153,'Surface penetration less than 5% of the member thickness regardless of location.','GOOD',789),
 (3154,'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.','FAIR',789),
 (3155,'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.','POOR',789),
 (3156,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',789),
 (3157,'None','GOOD',790),
 (3158,'Crack that has been arrested through effective measures.','FAIR',790),
 (3159,'Identified crack exists that is not arrested, but does not require structural review','POOR',790),
 (3160,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',790),
 (3161,'None','GOOD',791),
 (3162,'Length less than the member depth or arrested with effective actions taken to mitigate.','FAIR',791),
 (3163,'Length equal to or greater than the member depth, but does not require structural review.','POOR',791),
 (3164,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',791),
 (3165,'None or no measurable section loss.','GOOD',792),
 (3166,'Section loss less than 10% of the member thickness.','FAIR',792),
 (3167,'Section loss 10% or more of the member thickness, but does not warrant structural review.','POOR',792),
 (3168,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.','SEVERE',792),
 (3169,'Not applicable','GOOD',793),
 (3170,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',793),
 (3171,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',793),
 (3172,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',793),
 (3173,'None','GOOD',794),
 (3174,'Surface Dulling','FAIR',794),
 (3175,'Loss of Pigment','POOR',794),
 (3176,'Not Applicable','SEVERE',794),
 (3177,'None','GOOD',795),
 (3178,'Finish coats only.','FAIR',795),
 (3179,'Finish and primer coats','POOR',795),
 (3180,'Exposure of bare metal','SEVERE',795),
 (3181,'Fully effective','GOOD',796),
 (3182,'Substantially effective','FAIR',796),
 (3183,'Limited effectiveness','POOR',796),
 (3184,'Failed, no protection of the underlying metal','SEVERE',796),
 (3185,'Not applicable','GOOD',797),
 (3186,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',797),
 (3187,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',797),
 (3188,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',797),
 (3189,'None','GOOD',798),
 (3190,'Finish coats only.','FAIR',798),
 (3191,'Finish and primer coats','POOR',798),
 (3192,'Exposure of bare metal','SEVERE',798),
 (3193,'Yellow-orange or light brown for early development.
Chocolate-brown to purple-brown for fully developed.','GOOD',799),
 (3194,'Granular texture.','FAIR',799),
 (3195,'Small flakes, less than 1/2 in. diameter.','POOR',799),
 (3196,'Dark black color.','SEVERE',799),
 (3197,'Fully effective','GOOD',800),
 (3198,'Substantially effective','FAIR',800),
 (3199,'Limited effectiveness','POOR',800),
 (3200,'Failed, no protection of the underlying metal','SEVERE',800),
 (3201,'Not applicable','GOOD',801),
 (3202,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',801),
 (3203,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',801),
 (3204,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',801),
 (3205,'None','GOOD',802),
 (3206,'Finish coats only.','FAIR',802),
 (3207,'Finish and primer coats','POOR',802),
 (3208,'Exposure of bare metal','SEVERE',802),
 (3209,'Yellow-orange or light brown for early development.
Chocolate-brown to purple-brown for fully developed.','GOOD',803),
 (3210,'Granular texture.','FAIR',803),
 (3211,'Small flakes, less than 1/2 in. diameter.','POOR',803),
 (3212,'Dark black color.','SEVERE',803),
 (3213,'Fully effective','GOOD',804),
 (3214,'Substantially effective','FAIR',804),
 (3215,'Limited effectiveness','POOR',804),
 (3216,'Failed, no protection of the underlying metal','SEVERE',804),
 (3217,'Not applicable','GOOD',805),
 (3218,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',805),
 (3219,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',805),
 (3220,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',805),
 (3221,'Fully effective','GOOD',806),
 (3222,'Substantially effective','FAIR',806),
 (3223,'Limited effectiveness','POOR',806),
 (3224,'The protective system has failed or is no longer effective.','SEVERE',806),
 (3225,'Not applicable','GOOD',807),
 (3226,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',807),
 (3227,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',807),
 (3228,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',807),
 (3229,'None','GOOD',808),
 (3230,'Underlying concrete not exposed.
Coating showing wear from UV exposure.
Friction course missing','FAIR',808),
 (3231,'Underlying concrete is not exposed.
Thickness of the coating is reduced.','POOR',808),
 (3232,'Underlying concrete exposed.
Protective coating no longer effective','SEVERE',808),
 (3233,'Fully effective','GOOD',809),
 (3234,'Substantially effective','FAIR',809),
 (3235,'Limited effectiveness','POOR',809),
 (3236,'The protective system has failed or is no longer effective.','SEVERE',809),
 (3237,'Not applicable','GOOD',810),
 (3238,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',810),
 (3239,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',810),
 (3240,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',810),
 (3241,'None','GOOD',811),
 (3242,'Underlying concrete not exposed.
Coating showing wear from UV exposure.
Friction course missing','FAIR',811),
 (3243,'Underlying concrete is not exposed.
Thickness of the coating is reduced.','POOR',811),
 (3244,'Underlying concrete exposed.
Protective coating no longer effective','SEVERE',811),
 (3245,'Fully effective','GOOD',812),
 (3246,'Substantially effective','FAIR',812),
 (3247,'Limited effectiveness','POOR',812),
 (3248,'The protective system has failed or is no longer effective.','SEVERE',812),
 (3249,'Not applicable','GOOD',813),
 (3250,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.','FAIR',813),
 (3251,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.','POOR',813),
 (3252,'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.','SEVERE',813),
 (3253,'None','GOOD',814),
 (3254,'Freckled rust. Corrosion of the steel has initiated.','FAIR',814),
 (3255,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',814),
 (3256,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',814),
 (3257,'None','GOOD',815),
 (3258,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',815),
 (3259,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',815),
 (3260,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',815),
 (3261,'Connection is in place and functioning as intended.','GOOD',816),
 (3262,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',816),
 (3263,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',816),
 (3264,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',816),
 (3265,'None','GOOD',817),
 (3266,'Distortion has received structural review and has been mitigated.','FAIR',817),
 (3267,'Distortion has received structural review and does not require mitigation.','POOR',817),
 (3268,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',817),
 (3269,'Dry surface','GOOD',818),
 (3270,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',818),
 (3271,'Fully saturated surface with seepage.','POOR',818),
 (3272,'Seepage could range from dripping to flowing.','SEVERE',818),
 (3273,'None','GOOD',819),
 (3274,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',819),
 (3275,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',819),
 (3276,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',819),
 (3277,'None','GOOD',820),
 (3278,'Present without measureable section loss.','FAIR',820),
 (3279,'Present with measureable section loss, but does not warrant structural review.','POOR',820),
 (3280,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',820),
 (3281,'None','GOOD',821),
 (3282,'Surface white without build-up or leaching without rust staining.','FAIR',821),
 (3283,'Heavy build-up with rust staining.','POOR',821),
 (3284,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',821),
 (3285,'None','GOOD',822),
 (3286,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',822),
 (3287,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',822),
 (3288,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',822),
 (3289,'None','GOOD',823),
 (3290,'Distortion has received structural review and has been mitigated.','FAIR',823),
 (3291,'Distortion has received structural review and does not require mitigation.','POOR',823),
 (3292,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',823),
 (3293,'Dry surface','GOOD',824),
 (3294,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',824),
 (3295,'Fully saturated surface with seepage.','POOR',824),
 (3296,'Seepage could range from dripping to flowing.','SEVERE',824),
 (3297,'None','GOOD',825),
 (3298,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',825),
 (3299,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',825),
 (3300,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',825),
 (3301,'None','GOOD',826),
 (3302,'Present without measureable section loss.','FAIR',826),
 (3303,'Present with measureable section loss, but does not warrant structural review.','POOR',826),
 (3304,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',826),
 (3305,'None','GOOD',827),
 (3306,'Surface white without build-up or leaching without rust staining.','FAIR',827),
 (3307,'Heavy build-up with rust staining.','POOR',827),
 (3308,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',827),
 (3309,'None','GOOD',828),
 (3310,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',828),
 (3311,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',828),
 (3312,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',828),
 (3313,'None','GOOD',829),
 (3314,'Distortion has received structural review and has been mitigated.','FAIR',829),
 (3315,'Distortion has received structural review and does not require mitigation.','POOR',829),
 (3316,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',829),
 (3317,'Dry surface','GOOD',830),
 (3318,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',830),
 (3319,'Fully saturated surface with seepage.','POOR',830),
 (3320,'Seepage could range from dripping to flowing.','SEVERE',830),
 (3321,'None','GOOD',831),
 (3322,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',831),
 (3323,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',831),
 (3324,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',831),
 (3325,'None','GOOD',832),
 (3326,'Present without measureable section loss.','FAIR',832),
 (3327,'Present with measureable section loss, but does not warrant structural review.','POOR',832),
 (3328,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',832),
 (3329,'None','GOOD',833),
 (3330,'Surface white without build-up or leaching without rust staining.','FAIR',833),
 (3331,'Heavy build-up with rust staining.','POOR',833),
 (3332,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',833),
 (3333,'None','GOOD',834),
 (3334,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',834),
 (3335,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',834),
 (3336,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',834),
 (3337,'None','GOOD',835),
 (3338,'Distortion has received structural review and has been mitigated.','FAIR',835),
 (3339,'Distortion has received structural review and does not require mitigation.','POOR',835),
 (3340,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',835),
 (3341,'Dry surface','GOOD',836),
 (3342,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',836),
 (3343,'Fully saturated surface with seepage.','POOR',836),
 (3344,'Seepage could range from dripping to flowing.','SEVERE',836),
 (3345,'None','GOOD',837),
 (3346,'Decay has started in the timber sets or lagging. No fungus growth or discoloration is present.','FAIR',837),
 (3347,'Decay has resulted in loss of strength, deflection, or crushing of the element but not of a sufficient magnitude to affect the strength and serviceability of the tunnel. Fungus growth and discoloration is present.','POOR',837),
 (3348,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',837),
 (3349,'None','GOOD',838),
 (3350,'Small voids may exist in the annular space behind the lagging.','FAIR',838),
 (3351,'Large voids may exist in the annular space behind the lagging.','POOR',838),
 (3352,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',838),
 (3353,'None','GOOD',839),
 (3354,'Cracks, splits or checks exist in the timber sets or lagging.','FAIR',839),
 (3355,'Cracks, splits or checks exist in the timber sets or lagging and has impacted strength and/or serviceability but does not warrant a structural review.','POOR',839),
 (3356,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',839),
 (3357,'No off-set or misalignment between the timber members (good compression fit).','GOOD',840),
 (3358,'Off-set or misalignment between timber members may exist but is 0.125 in. or less.','FAIR',840),
 (3359,'Off-set or misalignment between timber members may exist and is between 0.125 in and 0.25 in.','POOR',840),
 (3360,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',840),
 (3361,'None','GOOD',841),
 (3362,'Infestation has started in the timber sets or lagging.','FAIR',841),
 (3363,'Infestation exists in the timber sets or lagging and has produced loss of strength or deflection of the element but not of a sufficient magnitude to affect the strength and/or serviceability of the tunnel.','POOR',841),
 (3364,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',841),
 (3365,'None','GOOD',842),
 (3366,'Loose bolts, or fasteners are present but the connection is in place and functioning as intended.','FAIR',842),
 (3367,'Missing bolts or fasteners but does not warrant a structural review.','POOR',842),
 (3368,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',842),
 (3369,'Dry surface','GOOD',843),
 (3370,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',843),
 (3371,'Fully saturated surface with seepage.','POOR',843),
 (3372,'Seepage could range from dripping to flowing.','SEVERE',843),
 (3373,'None','GOOD',844),
 (3374,'Surface white without build-up or leaching without rust staining.','FAIR',844),
 (3375,'Heavy build-up with rust staining.','POOR',844),
 (3376,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',844),
 (3377,'None','GOOD',845),
 (3378,'Cracking or voids in less than 10% of joints.','FAIR',845),
 (3379,'Cracking or voids in 10% or more of the joints.','POOR',845),
 (3380,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',845),
 (3381,'None','GOOD',846),
 (3382,'Block or stone has split or spalled with no shifting.','FAIR',846),
 (3383,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',846),
 (3384,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',846),
 (3385,'None','GOOD',847),
 (3386,'Sound patch.','FAIR',847),
 (3387,'Unsound patch.','POOR',847),
 (3388,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',847),
 (3389,'None','GOOD',848),
 (3390,'Block or stone has shifted slightly out of alignment.','FAIR',848),
 (3391,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',848),
 (3392,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',848),
 (3393,'None','GOOD',849),
 (3394,'Distortion has received structural review and has been mitigated.','FAIR',849),
 (3395,'Distortion has received structural review and does not require mitigation.','POOR',849),
 (3396,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',849),
 (3397,'Dry surface','GOOD',850),
 (3398,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',850),
 (3399,'Fully saturated surface with seepage.','POOR',850),
 (3400,'Seepage could range from dripping to flowing.','SEVERE',850),
 (3401,'No drummy rock. No blocks or slabs apparent. No shear zones are in evidence. No displacements visible along joints, cracks.','GOOD',851),
 (3402,'Any blocks or slabs are tightly interlocked with the surrounding rock and are not in danger of separating from the parent rock mass. Any displacements along shear zones, joints or cracks appear to be old, i.e. to have come about prior to the existence of the tunnel. Drummy areas are less than or equal to 1.0 ft. in diameter.','FAIR',851),
 (3403,'Any blocks or slabs that are not tightly interlocked with the surrounding rock are small, i.e. less than 1 ft. in diameter. Displacements along shear zones, joints or cracks have occurred since was constructed. Drummy areas are greater than 1.0 ft. in diameter.','POOR',851),
 (3404,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',851),
 (3405,'None','GOOD',852),
 (3406,'Sound patches.','FAIR',852),
 (3407,'Unsound patches.','POOR',852),
 (3408,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',852),
 (3409,'Dry surface','GOOD',853),
 (3410,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',853),
 (3411,'Fully saturated surface with seepage.','POOR',853),
 (3412,'Seepage could range from dripping to flowing.','SEVERE',853),
 (3413,'None','GOOD',854),
 (3414,'Loose or missing nuts, but bolt/dowel is in alignment and functioning as intended.','FAIR',854),
 (3415,'Loose or missing nuts; bolt/dowel out of alignment or loose.','POOR',854),
 (3416,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',854),
 (3417,'None','GOOD',855),
 (3418,'Deformation or cracking of liner or supported rock.','FAIR',855),
 (3419,'Deformation or cracking and spalling of liner or supported rock.','POOR',855),
 (3420,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',855),
 (3421,'None','GOOD',856),
 (3422,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',856),
 (3423,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',856),
 (3424,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',856),
 (3425,'None','GOOD',857),
 (3426,'Distortion has received structural review and has been mitigated.','FAIR',857),
 (3427,'Distortion has received structural review and does not require mitigation.','POOR',857),
 (3428,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',857),
 (3429,'None','GOOD',858),
 (3430,'Sound patches.','FAIR',858),
 (3431,'Unsound patches.','POOR',858),
 (3432,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',858),
 (3433,'Dry surface','GOOD',859),
 (3434,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',859),
 (3435,'Fully saturated surface with seepage.','POOR',859),
 (3436,'Seepage could range from dripping to flowing.','SEVERE',859),
 (3437,'None','GOOD',860),
 (3438,'Freckled rust. Corrosion of the steel has initiated.','FAIR',860),
 (3439,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',860),
 (3440,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',860),
 (3441,'None','GOOD',861),
 (3442,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',861),
 (3443,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',861),
 (3444,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',861),
 (3445,'Connection is in place and functioning as intended.','GOOD',862),
 (3446,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',862),
 (3447,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',862),
 (3448,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',862),
 (3449,'None','GOOD',863),
 (3450,'Distortion has received structural review and has been mitigated.','FAIR',863),
 (3451,'Distortion has received structural review and does not require mitigation.','POOR',863),
 (3452,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',863),
 (3453,'None','GOOD',864),
 (3454,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',864),
 (3455,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',864),
 (3456,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',864),
 (3457,'None','GOOD',865),
 (3458,'Present without measureable section loss.','FAIR',865),
 (3459,'Present with measureable section loss, but does not warrant structural review.','POOR',865),
 (3460,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',865),
 (3461,'None','GOOD',866),
 (3462,'Surface white without build-up or leaching without rust staining.','FAIR',866),
 (3463,'Heavy build-up with rust staining.','POOR',866),
 (3464,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',866),
 (3465,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',867),
 (3466,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',867),
 (3467,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',867),
 (3468,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',867),
 (3469,'None','GOOD',868),
 (3470,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',868),
 (3471,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',868),
 (3472,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',868),
 (3473,'None','GOOD',869),
 (3474,'Present without measureable section loss.','FAIR',869),
 (3475,'Present with measureable section loss, but does not warrant structural review.','POOR',869),
 (3476,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',869),
 (3477,'None','GOOD',870),
 (3478,'Present without section loss.','FAIR',870),
 (3479,'Present with section loss, but does not warrant structural review.','POOR',870),
 (3480,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',870),
 (3481,'Width less than 0.004 in. or spacing greater than 3 ft.','GOOD',871),
 (3482,'Width 0.004 - 0.009 in. or spacing of 1.0 - 3.0 ft.','FAIR',871),
 (3483,'Width greater than 0.009 in. or spacing less than 1 ft.','POOR',871),
 (3484,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',871),
 (3485,'None','GOOD',872),
 (3486,'Surface white without build-up or leaching without rust staining.','FAIR',872),
 (3487,'Heavy build-up with rust staining.','POOR',872),
 (3488,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',872),
 (3489,'Good condition – no notable distress','GOOD',873),
 (3490,'Fair condition- isolated breakdowns or deterioration.','FAIR',873),
 (3491,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',873),
 (3492,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',873),
 (3493,'None','GOOD',874),
 (3494,'Freckled rust. Corrosion of the steel has initiated.','FAIR',874),
 (3495,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',874),
 (3496,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',874),
 (3497,'None','GOOD',875),
 (3498,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',875),
 (3499,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',875),
 (3500,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',875),
 (3501,'Connection is in place and functioning as intended.','GOOD',876),
 (3502,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',876),
 (3503,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',876),
 (3504,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',876),
 (3505,'None','GOOD',877),
 (3506,'Distortion has received structural review and has been mitigated.','FAIR',877),
 (3507,'Distortion has received structural review and does not require mitigation.','POOR',877),
 (3508,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',877),
 (3509,'None','GOOD',878),
 (3510,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',878),
 (3511,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',878),
 (3512,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',878),
 (3513,'None','GOOD',879),
 (3514,'Present without measureable section loss.','FAIR',879),
 (3515,'Present with measureable section loss, but does not warrant structural review.','POOR',879),
 (3516,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',879),
 (3517,'None','GOOD',880),
 (3518,'Surface white without build-up or leaching without rust staining.','FAIR',880),
 (3519,'Heavy build-up with rust staining.','POOR',880),
 (3520,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',880),
 (3521,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',881),
 (3522,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',881),
 (3523,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',881),
 (3524,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',881),
 (3525,'Good condition – no notable distress','GOOD',882),
 (3526,'Fair condition- isolated breakdowns or deterioration.','FAIR',882),
 (3527,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',882),
 (3528,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',882),
 (3529,'None','GOOD',883),
 (3530,'Freckled rust. Corrosion of the steel has initiated.','FAIR',883),
 (3531,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',883),
 (3532,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',883),
 (3533,'None','GOOD',884),
 (3534,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',884),
 (3535,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',884),
 (3536,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',884),
 (3537,'Connection is in place and functioning as intended.','GOOD',885),
 (3538,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',885),
 (3539,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',885),
 (3540,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',885),
 (3541,'None','GOOD',886),
 (3542,'Distortion has received structural review and has been mitigated.','FAIR',886),
 (3543,'Distortion has received structural review and does not require mitigation.','POOR',886),
 (3544,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',886),
 (3545,'Dry surface','GOOD',887),
 (3546,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',887),
 (3547,'Fully saturated surface with seepage.','POOR',887),
 (3548,'Seepage could range from dripping to flowing.','SEVERE',887),
 (3549,'None','GOOD',888),
 (3550,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',888),
 (3551,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',888),
 (3552,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',888),
 (3553,'None','GOOD',889),
 (3554,'Present without measureable section loss.','FAIR',889),
 (3555,'Present with measureable section loss, but does not warrant structural review.','POOR',889),
 (3556,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',889),
 (3557,'None','GOOD',890),
 (3558,'Surface white without build-up or leaching without rust staining.','FAIR',890),
 (3559,'Heavy build-up with rust staining.','POOR',890),
 (3560,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',890),
 (3561,'None','GOOD',891),
 (3562,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',891),
 (3563,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',891),
 (3564,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',891),
 (3565,'None','GOOD',892),
 (3566,'Distortion has received structural review and has been mitigated.','FAIR',892),
 (3567,'Distortion has received structural review and does not require mitigation.','POOR',892),
 (3568,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',892),
 (3569,'Dry surface','GOOD',893),
 (3570,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',893),
 (3571,'Fully saturated surface with seepage.','POOR',893),
 (3572,'Seepage could range from dripping to flowing.','SEVERE',893),
 (3573,'None','GOOD',894),
 (3574,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',894),
 (3575,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',894),
 (3576,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',894),
 (3577,'None','GOOD',895),
 (3578,'Present without measureable section loss.','FAIR',895),
 (3579,'Present with measureable section loss, but does not warrant structural review.','POOR',895),
 (3580,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',895),
 (3581,'None','GOOD',896),
 (3582,'Surface white without build-up or leaching without rust staining.','FAIR',896),
 (3583,'Heavy build-up with rust staining.','POOR',896),
 (3584,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',896),
 (3585,'None','GOOD',897),
 (3586,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',897),
 (3587,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',897),
 (3588,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',897),
 (3589,'None','GOOD',898),
 (3590,'Distortion has received structural review and has been mitigated.','FAIR',898),
 (3591,'Distortion has received structural review and does not require mitigation.','POOR',898),
 (3592,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',898),
 (3593,'Dry surface','GOOD',899),
 (3594,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',899),
 (3595,'Fully saturated surface with seepage.','POOR',899),
 (3596,'Seepage could range from dripping to flowing.','SEVERE',899),
 (3597,'None','GOOD',900),
 (3598,'Decay has started in the timber sets or lagging. No fungus growth or discoloration is present.','FAIR',900),
 (3599,'Decay has resulted in loss of strength, deflection, or crushing of the element but not of a sufficient magnitude to affect the strength and serviceability of the tunnel. Fungus growth and discoloration is present.','POOR',900),
 (3600,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',900),
 (3601,'None','GOOD',901),
 (3602,'Small voids may exist in the annular space behind the lagging.','FAIR',901),
 (3603,'Large voids may exist in the annular space behind the lagging.','POOR',901),
 (3604,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',901),
 (3605,'None','GOOD',902),
 (3606,'Cracks, splits or checks exist in the timber sets or lagging.','FAIR',902),
 (3607,'Cracks, splits or checks exist in the timber sets or lagging and has impacted strength and/or serviceability but does not warrant a structural review.','POOR',902),
 (3608,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',902),
 (3609,'No off-set or misalignment between the timber members (good compression fit).','GOOD',903),
 (3610,'Off-set or misalignment between timber members may exist but is 0.125 in. or less.','FAIR',903),
 (3611,'Off-set or misalignment between timber members may exist and is between 0.125 in and 0.25 in.','POOR',903),
 (3612,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',903),
 (3613,'None','GOOD',904),
 (3614,'Infestation has started in the timber sets or lagging.','FAIR',904),
 (3615,'Infestation exists in the timber sets or lagging and has produced loss of strength or deflection of the element but not of a sufficient magnitude to affect the strength and/or serviceability of the tunnel.','POOR',904),
 (3616,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',904),
 (3617,'None','GOOD',905),
 (3618,'Loose bolts, or fasteners are present but the connection is in place and functioning as intended.','FAIR',905),
 (3619,'Missing bolts or fasteners but does not warrant a structural review.','POOR',905),
 (3620,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',905),
 (3621,'Dry surface','GOOD',906),
 (3622,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',906),
 (3623,'Fully saturated surface with seepage.','POOR',906),
 (3624,'Seepage could range from dripping to flowing.','SEVERE',906),
 (3625,'None','GOOD',907),
 (3626,'Surface white without build-up or leaching without rust staining.','FAIR',907),
 (3627,'Heavy build-up with rust staining.','POOR',907),
 (3628,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',907),
 (3629,'None','GOOD',908),
 (3630,'Cracking or voids in less than 10% of joints.','FAIR',908),
 (3631,'Cracking or voids in 10% or more of the joints.','POOR',908),
 (3632,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',908),
 (3633,'None','GOOD',909),
 (3634,'Block or stone has split or spalled with no shifting.','FAIR',909),
 (3635,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',909),
 (3636,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',909),
 (3637,'None','GOOD',910),
 (3638,'Sound patch.','FAIR',910),
 (3639,'Unsound patch.','POOR',910),
 (3640,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',910),
 (3641,'None','GOOD',911),
 (3642,'Block or stone has shifted slightly out of alignment.','FAIR',911),
 (3643,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',911),
 (3644,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',911),
 (3645,'None','GOOD',912),
 (3646,'Distortion has received structural review and has been mitigated.','FAIR',912),
 (3647,'Distortion has received structural review and does not require mitigation.','POOR',912),
 (3648,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',912),
 (3649,'Dry surface','GOOD',913),
 (3650,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',913),
 (3651,'Fully saturated surface with seepage.','POOR',913),
 (3652,'Seepage could range from dripping to flowing.','SEVERE',913),
 (3653,'No drummy rock. No blocks or slabs apparent. No shear zones are in evidence. No displacements visible along joints, cracks.','GOOD',914),
 (3654,'Any blocks or slabs are tightly interlocked with the surrounding rock and are not in danger of separating from the parent rock mass. Any displacements along shear zones, joints or cracks appear to be old, i.e. to have come about prior to the existence of the tunnel. Drummy areas are less than or equal to 1.0 ft. in diameter.','FAIR',914),
 (3655,'Any blocks or slabs that are not tightly interlocked with the surrounding rock are small, i.e. less than 1 ft. in diameter. Displacements along shear zones, joints or cracks have occurred since was constructed. Drummy areas are greater than 1.0 ft. in diameter.','POOR',914),
 (3656,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',914),
 (3657,'None','GOOD',915),
 (3658,'Sound patches.','FAIR',915),
 (3659,'Unsound patches.','POOR',915),
 (3660,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',915),
 (3661,'Dry surface','GOOD',916),
 (3662,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',916),
 (3663,'Fully saturated surface with seepage.','POOR',916),
 (3664,'Seepage could range from dripping to flowing.','SEVERE',916),
 (3665,'Cracks are present but have not allowed the rock to shift.','GOOD',917),
 (3666,'Cracks are present and rock has minor shifting.','FAIR',917),
 (3667,'Rocks are cracked with face deformation. Rocks are missing.','POOR',917),
 (3668,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',917),
 (3669,'None','GOOD',918),
 (3670,'Distortion has received structural review and has been mitigated.','FAIR',918),
 (3671,'Distortion has received structural review and does not require mitigation.','POOR',918),
 (3672,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',918),
 (3673,'None','GOOD',919),
 (3674,'Sound patches.','FAIR',919),
 (3675,'Unsound patches.','POOR',919),
 (3676,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',919),
 (3677,'Dry surface','GOOD',920),
 (3678,'Saturated surface indicating seepage may be present or evidence of past seepage.','FAIR',920),
 (3679,'Fully saturated surface with seepage.','POOR',920),
 (3680,'Seepage could range from dripping to flowing.','SEVERE',920),
 (3681,'None','GOOD',921),
 (3682,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',921),
 (3683,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',921),
 (3684,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',921),
 (3685,'None','GOOD',922),
 (3686,'Present without measureable section loss.','FAIR',922),
 (3687,'Present with measureable section loss, but does not warrant structural review.','POOR',922),
 (3688,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',922),
 (3689,'None','GOOD',923),
 (3690,'Surface white without build-up or leaching without rust staining.','FAIR',923),
 (3691,'Heavy build-up with rust staining.','POOR',923),
 (3692,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',923),
 (3693,'None','GOOD',924),
 (3694,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',924),
 (3695,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',924),
 (3696,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',924),
 (3697,'Good condition – no notable distress','GOOD',925),
 (3698,'Fair condition- isolated breakdowns or deterioration.','FAIR',925),
 (3699,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',925),
 (3700,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',925),
 (3701,'None','GOOD',926),
 (3702,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',926),
 (3703,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',926),
 (3704,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',926),
 (3705,'None','GOOD',927),
 (3706,'Present without measureable section loss.','FAIR',927),
 (3707,'Present with measureable section loss, but does not warrant structural review.','POOR',927),
 (3708,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',927),
 (3709,'None','GOOD',928),
 (3710,'Surface white without build-up or leaching without rust staining.','FAIR',928),
 (3711,'Heavy build-up with rust staining.','POOR',928),
 (3712,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',928),
 (3713,'None','GOOD',929),
 (3714,'Width less than 0.012 in. or spacing greater than 5.0 ft.','FAIR',929),
 (3715,'Width greater than 0.10 in. below spring line or greater than 0.012 in. above spring line or spacing of less than 1 ft.','POOR',929),
 (3716,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',929),
 (3717,'None','GOOD',930),
 (3718,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',930),
 (3719,'Exceeds tolerable limits but does not warrant structural review.','POOR',930),
 (3720,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',930),
 (3721,'None','GOOD',931),
 (3722,'Surface white without build-up or leaching without rust staining.','FAIR',931),
 (3723,'Heavy build-up with rust staining.','POOR',931),
 (3724,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',931),
 (3725,'None','GOOD',932),
 (3726,'Cracking or voids in less than 10% of joints.','FAIR',932),
 (3727,'Cracking or voids in 10% or more of the joints.','POOR',932),
 (3728,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',932),
 (3729,'None','GOOD',933),
 (3730,'Block or stone has split or spalled with no shifting.','FAIR',933),
 (3731,'Block or stone has split or spalled with shifting but does not warrant a structural review.','POOR',933),
 (3732,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',933),
 (3733,'None','GOOD',934),
 (3734,'Sound patch.','FAIR',934),
 (3735,'Unsound patch.','POOR',934),
 (3736,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',934),
 (3737,'None','GOOD',935),
 (3738,'Block or stone has shifted slightly out of alignment.','FAIR',935),
 (3739,'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.','POOR',935),
 (3740,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',935),
 (3741,'None','GOOD',936),
 (3742,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',936),
 (3743,'Exceeds tolerable limits but does not warrant structural review.','POOR',936),
 (3744,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',936),
 (3745,'Good condition – no notable distress','GOOD',937),
 (3746,'Fair condition- isolated breakdowns or deterioration.','FAIR',937),
 (3747,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',937),
 (3748,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',937),
 (3749,'None','GOOD',938),
 (3750,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',938),
 (3751,'Exceeds tolerable limits but does not warrant structural review.','POOR',938),
 (3752,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',938),
 (3753,'None','GOOD',939),
 (3754,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',939),
 (3755,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',939),
 (3756,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',939),
 (3757,'None','GOOD',940),
 (3758,'Present without measureable section loss.','FAIR',940),
 (3759,'Present with measureable section loss, but does not warrant structural review.','POOR',940),
 (3760,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',940),
 (3761,'None','GOOD',941),
 (3762,'Surface white without build-up or leaching without rust staining.','FAIR',941),
 (3763,'Heavy build-up with rust staining.','POOR',941),
 (3764,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',941),
 (3765,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',942),
 (3766,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',942),
 (3767,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',942),
 (3768,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',942),
 (3769,'Good condition – no notable distress','GOOD',943),
 (3770,'Fair condition- isolated breakdowns or deterioration.','FAIR',943),
 (3771,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',943),
 (3772,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',943),
 (3773,'None','GOOD',944),
 (3774,'Freckled rust. Corrosion of the steel has initiated.','FAIR',944),
 (3775,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',944),
 (3776,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',944),
 (3777,'None','GOOD',945),
 (3778,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',945),
 (3779,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',945),
 (3780,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',945),
 (3781,'Connection is in place and functioning as intended.','GOOD',946),
 (3782,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',946),
 (3783,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',946),
 (3784,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',946),
 (3785,'None','GOOD',947),
 (3786,'Distortion has received structural review and has been mitigated.','FAIR',947),
 (3787,'Distortion has received structural review and does not require mitigation.','POOR',947),
 (3788,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',947),
 (3789,'None','GOOD',948),
 (3790,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',948),
 (3791,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',948),
 (3792,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',948),
 (3793,'None','GOOD',949),
 (3794,'Present without measureable section loss.','FAIR',949),
 (3795,'Present with measureable section loss, but does not warrant structural review.','POOR',949),
 (3796,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',949),
 (3797,'None','GOOD',950),
 (3798,'Surface white without build-up or leaching without rust staining.','FAIR',950),
 (3799,'Heavy build-up with rust staining.','POOR',950),
 (3800,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',950),
 (3801,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',951),
 (3802,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',951),
 (3803,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',951),
 (3804,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',951),
 (3805,'None','GOOD',952),
 (3806,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',952),
 (3807,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',952),
 (3808,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',952),
 (3809,'None','GOOD',953),
 (3810,'Present without measureable section loss.','FAIR',953),
 (3811,'Present with measureable section loss, but does not warrant structural review.','POOR',953),
 (3812,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',953),
 (3813,'None','GOOD',954),
 (3814,'Present without section loss.','FAIR',954),
 (3815,'Present with section loss, but does not warrant structural review.','POOR',954),
 (3816,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',954),
 (3817,'Width less than 0.004 in. or spacing greater than 3 ft.','GOOD',955),
 (3818,'Width 0.004 - 0.009 in. or spacing of 1.0 - 3.0 ft.','FAIR',955),
 (3819,'Width greater than 0.009 in. or spacing less than 1 ft.','POOR',955),
 (3820,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',955),
 (3821,'None','GOOD',956),
 (3822,'Surface white without build-up or leaching without rust staining.','FAIR',956),
 (3823,'Heavy build-up with rust staining.','POOR',956),
 (3824,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',956),
 (3825,'Good condition – no notable distress','GOOD',957),
 (3826,'Fair condition- isolated breakdowns or deterioration.','FAIR',957),
 (3827,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',957),
 (3828,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',957),
 (3829,'None','GOOD',958),
 (3830,'Freckled rust. Corrosion of the steel has initiated.','FAIR',958),
 (3831,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',958),
 (3832,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',958),
 (3833,'None','GOOD',959),
 (3834,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',959),
 (3835,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',959),
 (3836,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',959),
 (3837,'Connection is in place and functioning as intended.','GOOD',960),
 (3838,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',960),
 (3839,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',960),
 (3840,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',960),
 (3841,'None','GOOD',961),
 (3842,'Isolated hangers are bowed or elongated.','FAIR',961),
 (3843,'Multiple adjacent hangers are bowed or elongated. Anchors have a gap <1/8” or are visibly elongated.','POOR',961),
 (3844,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',961),
 (3845,'None','GOOD',962),
 (3846,'Displacement is visible and anchorage has received structural review and has been mitigated.','FAIR',962),
 (3847,'Displacement is visible and anchorage has received structural review and does not require mitigation.','POOR',962),
 (3848,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',962),
 (3849,'Sound anchorage.','GOOD',963),
 (3850,'Cracking around anchorage areas, but concrete is sound.','FAIR',963),
 (3851,'Cracking or spalling around anchorage area and concrete is not sound.','POOR',963),
 (3852,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',963),
 (3853,'Good condition – no notable distress','GOOD',964),
 (3854,'Fair condition- isolated breakdowns or deterioration.','FAIR',964),
 (3855,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',964),
 (3856,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',964),
 (3857,'Sound','GOOD',965),
 (3858,'Isolated fasteners are loose at their connections.','FAIR',965),
 (3859,'Adjacent hangers are loose. Fasteners are missing from adjacent hanger connections at isolated locations.','POOR',965),
 (3860,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',965),
 (3861,'None','GOOD',966),
 (3862,'Isolated hangers are bowed or elongated.','FAIR',966),
 (3863,'Multiple adjacent hangers are bowed or elongated. Anchors have a gap <1/8” or are visibly elongated.','POOR',966),
 (3864,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',966),
 (3865,'None','GOOD',967),
 (3866,'Displacement is visible and anchorage has received structural review and has been mitigated.','FAIR',967),
 (3867,'Displacement is visible and anchorage has received structural review and does not require mitigation.','POOR',967),
 (3868,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',967),
 (3869,'Sound anchorage.','GOOD',968),
 (3870,'Cracking around anchorage areas, but concrete is sound.','FAIR',968),
 (3871,'Cracking or spalling around anchorage area and concrete is not sound.','POOR',968),
 (3872,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',968),
 (3873,'None','GOOD',969),
 (3874,'Freckled rust. Corrosion of the steel has initiated.','FAIR',969),
 (3875,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',969),
 (3876,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',969),
 (3877,'None','GOOD',970),
 (3878,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',970),
 (3879,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',970),
 (3880,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',970),
 (3881,'Connection is in place and functioning as intended.','GOOD',971),
 (3882,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',971),
 (3883,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',971),
 (3884,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',971),
 (3885,'None','GOOD',972),
 (3886,'Distortion has received structural review and has been mitigated.','FAIR',972),
 (3887,'Distortion has received structural review and does not require mitigation.','POOR',972),
 (3888,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',972),
 (3889,'None','GOOD',973),
 (3890,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',973),
 (3891,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',973),
 (3892,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',973),
 (3893,'None','GOOD',974),
 (3894,'Present without measureable section loss.','FAIR',974),
 (3895,'Present with measureable section loss, but does not warrant structural review.','POOR',974),
 (3896,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',974),
 (3897,'None','GOOD',975),
 (3898,'Surface white without build-up or leaching without rust staining.','FAIR',975),
 (3899,'Heavy build-up with rust staining.','POOR',975),
 (3900,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',975),
 (3901,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',976),
 (3902,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',976),
 (3903,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',976),
 (3904,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',976),
 (3905,'Good condition – no notable distress','GOOD',977),
 (3906,'Fair condition- isolated breakdowns or deterioration.','FAIR',977),
 (3907,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',977),
 (3908,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',977),
 (3909,'None','GOOD',978),
 (3910,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',978),
 (3911,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',978),
 (3912,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',978),
 (3913,'None','GOOD',979),
 (3914,'Present without measureable section loss.','FAIR',979),
 (3915,'Present with measureable section loss, but does not warrant structural review.','POOR',979),
 (3916,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',979),
 (3917,'None','GOOD',980),
 (3918,'Surface white without build-up or leaching without rust staining.','FAIR',980),
 (3919,'Heavy build-up with rust staining.','POOR',980),
 (3920,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',980),
 (3921,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',981),
 (3922,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',981),
 (3923,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',981),
 (3924,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',981),
 (3925,'Good condition – no notable distress','GOOD',982),
 (3926,'Fair condition- isolated breakdowns or deterioration.','FAIR',982),
 (3927,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',982),
 (3928,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',982),
 (3929,'None','GOOD',983),
 (3930,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',983),
 (3931,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',983),
 (3932,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',983),
 (3933,'None','GOOD',984),
 (3934,'Present without measureable section loss.','FAIR',984),
 (3935,'Present with measureable section loss, but does not warrant structural review.','POOR',984),
 (3936,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',984),
 (3937,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',985),
 (3938,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',985),
 (3939,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',985),
 (3940,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',985),
 (3941,'None','GOOD',986),
 (3942,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',986),
 (3943,'Exceeds tolerable limits but does not warrant structural review.','POOR',986),
 (3944,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',986),
 (3945,'Good condition – no notable distress','GOOD',987),
 (3946,'Fair condition- isolated breakdowns or deterioration.','FAIR',987),
 (3947,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',987),
 (3948,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',987),
 (3949,'None','GOOD',988),
 (3950,'Exists within tolerable limits or arrested with no observed structural distress.','FAIR',988),
 (3951,'Exceeds tolerable limits but does not warrant structural review.','POOR',988),
 (3952,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',988),
 (3953,'None','GOOD',989),
 (3954,'Freckled rust. Corrosion of the steel has initiated.','FAIR',989),
 (3955,'Section loss is evident or pack rust is present but does not warrant structural review.','POOR',989),
 (3956,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',989),
 (3957,'None','GOOD',990),
 (3958,'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.','FAIR',990),
 (3959,'Identified crack exists that is not arrested but does not warrant structural review.','POOR',990),
 (3960,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',990),
 (3961,'Connection is in place and functioning as intended.','GOOD',991),
 (3962,'Loose fasteners or pack rust without distortion is present but the connection is in place and functioning as intended.','FAIR',991),
 (3963,'Missing bolts, rivets or fasteners; broken welds; or pack rust with distortion but does not warrant a structural review.','POOR',991),
 (3964,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',991),
 (3965,'None','GOOD',992),
 (3966,'Distortion has received structural review and has been mitigated.','FAIR',992),
 (3967,'Distortion has received structural review and does not require mitigation.','POOR',992),
 (3968,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',992),
 (3969,'None','GOOD',993),
 (3970,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',993),
 (3971,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',993),
 (3972,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',993),
 (3973,'None','GOOD',994),
 (3974,'Present without measureable section loss.','FAIR',994),
 (3975,'Present with measureable section loss, but does not warrant structural review.','POOR',994),
 (3976,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',994),
 (3977,'None','GOOD',995),
 (3978,'Surface white without build-up or leaching without rust staining.','FAIR',995),
 (3979,'Heavy build-up with rust staining.','POOR',995),
 (3980,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',995),
 (3981,'Width less than 0.012 in. or spacing greater than 3.0 ft.','GOOD',996),
 (3982,'Width 0.012 - 0.05 in. or spacing of 1 – 3.0 ft.','FAIR',996),
 (3983,'Width greater than 0.05 in. or spacing of less than 1 ft.','POOR',996),
 (3984,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',996),
 (3985,'None','GOOD',997),
 (3986,'Delaminated. Spall 1 in. or less deep or 6 in. or less in diameter. Patched area that is sound.','FAIR',997),
 (3987,'Spall greater than 1 in. deep or greater than 6 in. diameter. Patched area that is unsound or showing distress. Does not warrant structural review.','POOR',997),
 (3988,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',997),
 (3989,'None','GOOD',998),
 (3990,'Present without measureable section loss.','FAIR',998),
 (3991,'Present with measureable section loss, but does not warrant structural review.','POOR',998),
 (3992,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',998),
 (3993,'None','GOOD',999),
 (3994,'Present without section loss.','FAIR',999),
 (3995,'Present with section loss, but does not warrant structural review.','POOR',999),
 (3996,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',999),
 (3997,'Width less than 0.004 in. or spacing greater than 3 ft.','GOOD',1000),
 (3998,'Width 0.004 - 0.009 in. or spacing of 1.0 - 3.0 ft.','FAIR',1000),
 (3999,'Width greater than 0.009 in. or spacing less than 1 ft.','POOR',1000),
 (4000,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',1000),
 (4001,'None','GOOD',1001),
 (4002,'Surface white without build-up or leaching without rust staining.','FAIR',1001),
 (4003,'Heavy build-up with rust staining.','POOR',1001),
 (4004,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',1001),
 (4005,'Good condition – no notable distress','GOOD',1002),
 (4006,'Fair condition- isolated breakdowns or deterioration.','FAIR',1002),
 (4007,'Poor condition – widespread deterioration or breakdowns without reducing load capacity.','POOR',1002),
 (4008,'The condition warrants a structural review to determine the effect on strength or serviceability of the element or tunnel, OR a structural review has been completed and the defects impact strength and serviceability of the element or tunnel.','SEVERE',1002),
 (4009,'None','GOOD',1003),
 (4010,'Minimal. Minor dripping through the joint.','FAIR',1003),
 (4011,'Moderate. More than a drip and less than free flow of water.','POOR',1003),
 (4012,'Free flow of water through the joint.','SEVERE',1003),
 (4013,'Fully adhered.','GOOD',1004),
 (4014,'Adhered for more than 50% of the joint height.','FAIR',1004),
 (4015,'Adhered 50% or less of the joint height but still some adhesion.','POOR',1004),
 (4016,'Complete loss of adhesion.','SEVERE',1004),
 (4017,'None','GOOD',1005),
 (4018,'Seal abrasion without punctures.','FAIR',1005),
 (4019,'Punctured or ripped or partially pulled out.','POOR',1005),
 (4020,'Punctured completely through, pulled out, or missing.','SEVERE',1005),
 (4021,'None','GOOD',1006),
 (4022,'Surface crack.','FAIR',1006),
 (4023,'Crack that partially penetrates the seal.','POOR',1006),
 (4024,'Crack that fully penetrates the seal.','SEVERE',1006),
 (4025,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1007),
 (4026,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1007),
 (4027,'Completely filled and impacts joint movement.','POOR',1007),
 (4028,'Completely filled and prevents joint movement.','SEVERE',1007),
 (4029,'Sound. No spall, delamination or unsound patch.','GOOD',1008),
 (4030,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1008),
 (4031,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1008),
 (4032,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1008),
 (4033,'None','GOOD',1009),
 (4034,'Freckled rust, metal has no cracks, or impact damage. Connections may be loose but functioning as intended.','FAIR',1009),
 (4035,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint is still functioning.','POOR',1009),
 (4036,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',1009),
 (4037,'None','GOOD',1010),
 (4038,'Minimal. Minor dripping through the joint.','FAIR',1010),
 (4039,'Moderate. More than a drip and less than free flow of water.','POOR',1010),
 (4040,'Free flow of water through the joint.','SEVERE',1010),
 (4041,'Fully adhered.','GOOD',1011),
 (4042,'Adhered for more than 50% of the joint height.','FAIR',1011),
 (4043,'Adhered 50% or less of the joint height but still some adhesion.','POOR',1011),
 (4044,'Complete loss of adhesion.','SEVERE',1011),
 (4045,'None','GOOD',1012),
 (4046,'Seal abrasion without punctures.','FAIR',1012),
 (4047,'Punctured or ripped or partially pulled out.','POOR',1012),
 (4048,'Punctured completely through, pulled out, or missing.','SEVERE',1012),
 (4049,'None','GOOD',1013),
 (4050,'Surface crack.','FAIR',1013),
 (4051,'Crack that partially penetrates the seal.','POOR',1013),
 (4052,'Crack that fully penetrates the seal.','SEVERE',1013),
 (4053,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1014),
 (4054,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1014),
 (4055,'Completely filled and impacts joint movement.','POOR',1014),
 (4056,'Completely filled and prevents joint movement.','SEVERE',1014),
 (4057,'Sound. No spall, delamination or unsound patch.','GOOD',1015),
 (4058,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1015),
 (4059,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1015),
 (4060,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1015),
 (4061,'None','GOOD',1016),
 (4062,'Minimal. Minor dripping through the joint.','FAIR',1016),
 (4063,'Moderate. More than a drip and less than free flow of water.','POOR',1016),
 (4064,'Free flow of water through the joint.','SEVERE',1016),
 (4065,'Fully adhered.','GOOD',1017),
 (4066,'Adhered for more than 50% of the joint height.','FAIR',1017),
 (4067,'Adhered 50% or less of the joint height but still some adhesion.','POOR',1017),
 (4068,'Complete loss of adhesion.','SEVERE',1017),
 (4069,'None','GOOD',1018),
 (4070,'Seal abrasion without punctures.','FAIR',1018),
 (4071,'Punctured or ripped or partially pulled out.','POOR',1018),
 (4072,'Punctured completely through, pulled out, or missing.','SEVERE',1018),
 (4073,'None','GOOD',1019),
 (4074,'Surface crack.','FAIR',1019),
 (4075,'Crack that partially penetrates the seal.','POOR',1019),
 (4076,'Crack that fully penetrates the seal.','SEVERE',1019),
 (4077,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1020),
 (4078,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1020),
 (4079,'Completely filled and impacts joint movement.','POOR',1020),
 (4080,'Completely filled and prevents joint movement.','SEVERE',1020),
 (4081,'Sound. No spall, delamination or unsound patch.','GOOD',1021),
 (4082,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1021),
 (4083,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1021),
 (4084,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1021),
 (4085,'None','GOOD',1022),
 (4086,'Minimal. Minor dripping through the joint.','FAIR',1022),
 (4087,'Moderate. More than a drip and less than free flow of water.','POOR',1022),
 (4088,'Free flow of water through the joint.','SEVERE',1022),
 (4089,'Fully adhered.','GOOD',1023),
 (4090,'Adhered for more than 50% of the joint height.','FAIR',1023),
 (4091,'Adhered 50% or less of the joint height but still some adhesion.','POOR',1023),
 (4092,'Complete loss of adhesion.','SEVERE',1023),
 (4093,'None','GOOD',1024),
 (4094,'Seal abrasion without punctures.','FAIR',1024),
 (4095,'Punctured or ripped or partially pulled out.','POOR',1024),
 (4096,'Punctured completely through, pulled out, or missing.','SEVERE',1024),
 (4097,'None','GOOD',1025),
 (4098,'Surface crack.','FAIR',1025),
 (4099,'Crack that partially penetrates the seal.','POOR',1025),
 (4100,'Crack that fully penetrates the seal.','SEVERE',1025),
 (4101,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1026),
 (4102,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1026),
 (4103,'Completely filled and impacts joint movement.','POOR',1026),
 (4104,'Completely filled and prevents joint movement.','SEVERE',1026),
 (4105,'Sound. No spall, delamination or unsound patch.','GOOD',1027),
 (4106,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1027),
 (4107,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1027),
 (4108,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1027),
 (4109,'None','GOOD',1028),
 (4110,'Freckled rust, metal has no cracks, or impact damage. Connections may be loose but functioning as intended.','FAIR',1028),
 (4111,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint is still functioning.','POOR',1028),
 (4112,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',1028),
 (4113,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1029),
 (4114,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1029),
 (4115,'Completely filled and impacts joint movement.','POOR',1029),
 (4116,'Completely filled and prevents joint movement.','SEVERE',1029),
 (4117,'Sound. No spall, delamination or unsound patch.','GOOD',1030),
 (4118,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1030),
 (4119,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1030),
 (4120,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1030),
 (4121,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1031),
 (4122,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1031),
 (4123,'Completely filled and impacts joint movement.','POOR',1031),
 (4124,'Completely filled and prevents joint movement.','SEVERE',1031),
 (4125,'Sound. No spall, delamination or unsound patch.','GOOD',1032),
 (4126,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1032),
 (4127,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1032),
 (4128,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1032),
 (4129,'None','GOOD',1033),
 (4130,'Freckled rust, metal has no cracks, or impact damage. Connections may be loose but functioning as intended.','FAIR',1033),
 (4131,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint is still functioning.','POOR',1033),
 (4132,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',1033),
 (4133,'None','GOOD',1034),
 (4134,'Minimal. Minor dripping through the joint.','FAIR',1034),
 (4135,'Moderate. More than a drip and less than free flow of water.','POOR',1034),
 (4136,'Free flow of water through the joint.','SEVERE',1034),
 (4137,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1035),
 (4138,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1035),
 (4139,'Completely filled and impacts joint movement.','POOR',1035),
 (4140,'Completely filled and prevents joint movement.','SEVERE',1035),
 (4141,'Sound. No spall, delamination or unsound patch.','GOOD',1036),
 (4142,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1036),
 (4143,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1036),
 (4144,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1036),
 (4145,'None','GOOD',1037),
 (4146,'Freckled rust, metal has no cracks, or impact damage. Connections may be loose but functioning as intended.','FAIR',1037),
 (4147,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint is still functioning.','POOR',1037),
 (4148,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',1037),
 (4149,'None','GOOD',1038),
 (4150,'Minimal. Minor dripping through the joint.','FAIR',1038),
 (4151,'Moderate. More than a drip and less than free flow of water.','POOR',1038),
 (4152,'Free flow of water through the joint.','SEVERE',1038),
 (4153,'Fully adhered.','GOOD',1039),
 (4154,'Adhered for more than 50% of the joint height.','FAIR',1039),
 (4155,'Adhered 50% or less of the joint height but still some adhesion.','POOR',1039),
 (4156,'Complete loss of adhesion.','SEVERE',1039),
 (4157,'None','GOOD',1040),
 (4158,'Seal abrasion without punctures.','FAIR',1040),
 (4159,'Punctured or ripped or partially pulled out.','POOR',1040),
 (4160,'Punctured completely through, pulled out, or missing.','SEVERE',1040),
 (4161,'None','GOOD',1041),
 (4162,'Surface crack.','FAIR',1041),
 (4163,'Crack that partially penetrates the seal.','POOR',1041),
 (4164,'Crack that fully penetrates the seal.','SEVERE',1041),
 (4165,'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.','GOOD',1042),
 (4166,'Partially filled with hard-packed material, but still allowing free movement.','FAIR',1042),
 (4167,'Completely filled and impacts joint movement.','POOR',1042),
 (4168,'Completely filled and prevents joint movement.','SEVERE',1042),
 (4169,'Sound. No spall, delamination or unsound patch.','GOOD',1043),
 (4170,'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter. No exposed rebar. Patched area that is sound.','FAIR',1043),
 (4171,'Spall greater than 1 in. deep or greater than 6 in. diameter. Exposed rebar. Delamination or unsound patched area that makes the joint loose.','POOR',1043),
 (4172,'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.','SEVERE',1043),
 (4173,'None','GOOD',1044),
 (4174,'Freckled rust, metal has no cracks, or impact damage. Connections may be loose but functioning as intended.','FAIR',1044),
 (4175,'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint is still functioning.','POOR',1044),
 (4176,'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.','SEVERE',1044);