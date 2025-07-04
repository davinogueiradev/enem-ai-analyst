--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2 (Ubuntu 15.2-1.pgdg22.04+1)

create database chinook;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_table_access_method = heap;

--
-- Name: Album; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Album" (
    "AlbumId" integer NOT NULL,
    "Title" character varying(160) NOT NULL,
    "ArtistId" integer NOT NULL
);


--
-- Name: Artist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Artist" (
    "ArtistId" integer NOT NULL,
    "Name" character varying(120)
);


--
-- Name: Customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Customer" (
    "CustomerId" integer NOT NULL,
    "FirstName" character varying(40) NOT NULL,
    "LastName" character varying(20) NOT NULL,
    "Company" character varying(80),
    "Address" character varying(70),
    "City" character varying(40),
    "State" character varying(40),
    "Country" character varying(40),
    "PostalCode" character varying(10),
    "Phone" character varying(24),
    "Fax" character varying(24),
    "Email" character varying(60) NOT NULL,
    "SupportRepId" integer
);


--
-- Name: Employee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Employee" (
    "EmployeeId" integer NOT NULL,
    "LastName" character varying(20) NOT NULL,
    "FirstName" character varying(20) NOT NULL,
    "Title" character varying(30),
    "ReportsTo" integer,
    "BirthDate" timestamp without time zone,
    "HireDate" timestamp without time zone,
    "Address" character varying(70),
    "City" character varying(40),
    "State" character varying(40),
    "Country" character varying(40),
    "PostalCode" character varying(10),
    "Phone" character varying(24),
    "Fax" character varying(24),
    "Email" character varying(60)
);


--
-- Name: Genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Genre" (
    "GenreId" integer NOT NULL,
    "Name" character varying(120)
);


--
-- Name: Invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Invoice" (
    "InvoiceId" integer NOT NULL,
    "CustomerId" integer NOT NULL,
    "InvoiceDate" timestamp without time zone NOT NULL,
    "BillingAddress" character varying(70),
    "BillingCity" character varying(40),
    "BillingState" character varying(40),
    "BillingCountry" character varying(40),
    "BillingPostalCode" character varying(10),
    "Total" numeric(10,2) NOT NULL
);


--
-- Name: InvoiceLine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."InvoiceLine" (
    "InvoiceLineId" integer NOT NULL,
    "InvoiceId" integer NOT NULL,
    "TrackId" integer NOT NULL,
    "UnitPrice" numeric(10,2) NOT NULL,
    "Quantity" integer NOT NULL
);


--
-- Name: MediaType; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MediaType" (
    "MediaTypeId" integer NOT NULL,
    "Name" character varying(120)
);


--
-- Name: Playlist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Playlist" (
    "PlaylistId" integer NOT NULL,
    "Name" character varying(120)
);


--
-- Name: PlaylistTrack; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PlaylistTrack" (
    "PlaylistId" integer NOT NULL,
    "TrackId" integer NOT NULL
);


--
-- Name: Track; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Track" (
    "TrackId" integer NOT NULL,
    "Name" character varying(200) NOT NULL,
    "AlbumId" integer,
    "MediaTypeId" integer NOT NULL,
    "GenreId" integer,
    "Composer" character varying(220),
    "Milliseconds" integer NOT NULL,
    "Bytes" integer,
    "UnitPrice" numeric(10,2) NOT NULL
);


--
-- Data for Name: Album; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Album" ("AlbumId", "Title", "ArtistId") FROM stdin;
1	For Those About To Rock We Salute You	1
2	Balls to the Wall	2
3	Restless and Wild	2
4	Let There Be Rock	1
5	Big Ones	3
6	Jagged Little Pill	4
7	Facelift	5
8	Warner 25 Anos	6
9	Plays Metallica By Four Cellos	7
10	Audioslave	8
11	Out Of Exile	8
12	BackBeat Soundtrack	9
13	The Best Of Billy Cobham	10
14	Alcohol Fueled Brewtality Live! [Disc 1]	11
15	Alcohol Fueled Brewtality Live! [Disc 2]	11
16	Black Sabbath	12
17	Black Sabbath Vol. 4 (Remaster)	12
18	Body Count	13
19	Chemical Wedding	14
20	The Best Of Buddy Guy - The Millenium Collection	15
21	Prenda Minha	16
22	Sozinho Remix Ao Vivo	16
23	Minha Historia	17
24	Afrociberdelia	18
25	Da Lama Ao Caos	18
26	Ac�stico MTV [Live]	19
27	Cidade Negra - Hits	19
28	Na Pista	20
29	Ax� Bahia 2001	21
30	BBC Sessions [Disc 1] [Live]	22
31	Bongo Fury	23
32	Carnaval 2001	21
33	Chill: Brazil (Disc 1)	24
34	Chill: Brazil (Disc 2)	6
35	Garage Inc. (Disc 1)	50
36	Greatest Hits II	51
37	Greatest Kiss	52
38	Heart of the Night	53
39	International Superhits	54
40	Into The Light	55
41	Meus Momentos	56
42	Minha Hist�ria	57
43	MK III The Final Concerts [Disc 1]	58
44	Physical Graffiti [Disc 1]	22
45	Sambas De Enredo 2001	21
46	Supernatural	59
47	The Best of Ed Motta	37
48	The Essential Miles Davis [Disc 1]	68
49	The Essential Miles Davis [Disc 2]	68
50	The Final Concerts (Disc 2)	58
51	Up An' Atom	69
52	Vin�cius De Moraes - Sem Limite	70
53	Vozes do MPB	21
54	Chronicle, Vol. 1	76
55	Chronicle, Vol. 2	76
56	C�ssia Eller - Cole��o Sem Limite [Disc 2]	77
57	C�ssia Eller - Sem Limite [Disc 1]	77
58	Come Taste The Band	58
59	Deep Purple In Rock	58
60	Fireball	58
61	Knocking at Your Back Door: The Best Of Deep Purple in the 80's	58
62	Machine Head	58
63	Purpendicular	58
64	Slaves And Masters	58
65	Stormbringer	58
66	The Battle Rages On	58
67	Vault: Def Leppard's Greatest Hits	78
68	Outbreak	79
69	Djavan Ao Vivo - Vol. 02	80
70	Djavan Ao Vivo - Vol. 1	80
71	Elis Regina-Minha Hist�ria	41
72	The Cream Of Clapton	81
73	Unplugged	81
74	Album Of The Year	82
75	Angel Dust	82
76	King For A Day Fool For A Lifetime	82
77	The Real Thing	82
78	Deixa Entrar	83
79	In Your Honor [Disc 1]	84
80	In Your Honor [Disc 2]	84
81	One By One	84
82	The Colour And The Shape	84
83	My Way: The Best Of Frank Sinatra [Disc 1]	85
84	Roda De Funk	86
85	As Can��es de Eu Tu Eles	27
86	Quanta Gente Veio Ver (Live)	27
87	Quanta Gente Veio ver--B�nus De Carnaval	27
88	Faceless	87
89	American Idiot	54
90	Appetite for Destruction	88
91	Use Your Illusion I	88
92	Use Your Illusion II	88
93	Blue Moods	89
94	A Matter of Life and Death	90
95	A Real Dead One	90
96	A Real Live One	90
97	Brave New World	90
98	Dance Of Death	90
99	Fear Of The Dark	90
100	Iron Maiden	90
101	Killers	90
102	Live After Death	90
103	Live At Donington 1992 (Disc 1)	90
104	Live At Donington 1992 (Disc 2)	90
105	No Prayer For The Dying	90
106	Piece Of Mind	90
107	Powerslave	90
108	Rock In Rio [CD1]	90
109	Rock In Rio [CD2]	90
110	Seventh Son of a Seventh Son	90
111	Somewhere in Time	90
112	The Number of The Beast	90
113	The X Factor	90
114	Virtual XI	90
115	Sex Machine	91
116	Emergency On Planet Earth	92
117	Synkronized	92
118	The Return Of The Space Cowboy	92
119	Get Born	93
120	Are You Experienced?	94
121	Surfing with the Alien (Remastered)	95
122	Jorge Ben Jor 25 Anos	46
123	Jota Quest-1995	96
124	Cafezinho	97
125	Living After Midnight	98
126	Unplugged [Live]	52
127	BBC Sessions [Disc 2] [Live]	22
128	Coda	22
129	Houses Of The Holy	22
130	In Through The Out Door	22
131	IV	22
132	Led Zeppelin I	22
133	Led Zeppelin II	22
134	Led Zeppelin III	22
135	Physical Graffiti [Disc 2]	22
136	Presence	22
137	The Song Remains The Same (Disc 1)	22
138	The Song Remains The Same (Disc 2)	22
139	A TempestadeTempestade Ou O Livro Dos Dias	99
140	Mais Do Mesmo	99
141	Greatest Hits	100
142	Lulu Santos - RCA 100 Anos De M�sica - �lbum 01	101
143	Lulu Santos - RCA 100 Anos De M�sica - �lbum 02	101
144	Misplaced Childhood	102
145	Barulhinho Bom	103
146	Seek And Shall Find: More Of The Best (1963-1981)	104
147	The Best Of Men At Work	105
148	Black Album	50
149	Garage Inc. (Disc 2)	50
150	Kill 'Em All	50
151	Load	50
152	Master Of Puppets	50
153	ReLoad	50
154	Ride The Lightning	50
155	St. Anger	50
156	...And Justice For All	50
157	Miles Ahead	68
158	Milton Nascimento Ao Vivo	42
159	Minas	42
160	Ace Of Spades	106
161	Demorou...	108
162	Motley Crue Greatest Hits	109
163	From The Muddy Banks Of The Wishkah [Live]	110
164	Nevermind	110
165	Compositores	111
166	Olodum	112
167	Ac�stico MTV	113
168	Arquivo II	113
169	Arquivo Os Paralamas Do Sucesso	113
170	Bark at the Moon (Remastered)	114
171	Blizzard of Ozz	114
172	Diary of a Madman (Remastered)	114
173	No More Tears (Remastered)	114
174	Tribute	114
175	Walking Into Clarksdale	115
176	Original Soundtracks 1	116
177	The Beast Live	117
178	Live On Two Legs [Live]	118
179	Pearl Jam	118
180	Riot Act	118
181	Ten	118
182	Vs.	118
183	Dark Side Of The Moon	120
184	Os C�es Ladram Mas A Caravana N�o P�ra	121
185	Greatest Hits I	51
186	News Of The World	51
187	Out Of Time	122
188	Green	124
189	New Adventures In Hi-Fi	124
190	The Best Of R.E.M.: The IRS Years	124
191	Cesta B�sica	125
192	Raul Seixas	126
193	Blood Sugar Sex Magik	127
194	By The Way	127
195	Californication	127
196	Retrospective I (1974-1980)	128
197	Santana - As Years Go By	59
198	Santana Live	59
199	Maquinarama	130
200	O Samba Pocon�	130
201	Judas 0: B-Sides and Rarities	131
202	Rotten Apples: Greatest Hits	131
203	A-Sides	132
204	Morning Dance	53
205	In Step	133
206	Core	134
207	Mezmerize	135
208	[1997] Black Light Syndrome	136
209	Live [Disc 1]	137
210	Live [Disc 2]	137
211	The Singles	138
212	Beyond Good And Evil	139
213	Pure Cult: The Best Of The Cult (For Rockers, Ravers, Lovers & Sinners) [UK]	139
214	The Doors	140
215	The Police Greatest Hits	141
216	Hot Rocks, 1964-1971 (Disc 1)	142
217	No Security	142
218	Voodoo Lounge	142
219	Tangents	143
220	Transmission	143
221	My Generation - The Very Best Of The Who	144
222	Serie Sem Limite (Disc 1)	145
223	Serie Sem Limite (Disc 2)	145
224	Ac�stico	146
225	Volume Dois	146
226	Battlestar Galactica: The Story So Far	147
227	Battlestar Galactica, Season 3	147
228	Heroes, Season 1	148
229	Lost, Season 3	149
230	Lost, Season 1	149
231	Lost, Season 2	149
232	Achtung Baby	150
233	All That You Can't Leave Behind	150
234	B-Sides 1980-1990	150
235	How To Dismantle An Atomic Bomb	150
236	Pop	150
237	Rattle And Hum	150
238	The Best Of 1980-1990	150
239	War	150
240	Zooropa	150
241	UB40 The Best Of - Volume Two [UK]	151
242	Diver Down	152
243	The Best Of Van Halen, Vol. I	152
244	Van Halen	152
245	Van Halen III	152
246	Contraband	153
247	Vinicius De Moraes	72
248	Ao Vivo [IMPORT]	155
249	The Office, Season 1	156
250	The Office, Season 2	156
251	The Office, Season 3	156
252	Un-Led-Ed	157
253	Battlestar Galactica (Classic), Season 1	158
254	Aquaman	159
255	Instant Karma: The Amnesty International Campaign to Save Darfur	150
256	Speak of the Devil	114
257	20th Century Masters - The Millennium Collection: The Best of Scorpions	179
258	House of Pain	180
259	Radio Brasil (O Som da Jovem Vanguarda) - Seleccao de Henrique Amaro	36
260	Cake: B-Sides and Rarities	196
261	LOST, Season 4	149
262	Quiet Songs	197
263	Muso Ko	198
264	Realize	199
265	Every Kind of Light	200
266	Duos II	201
267	Worlds	202
268	The Best of Beethoven	203
269	Temple of the Dog	204
270	Carry On	205
271	Revelations	8
272	Adorate Deum: Gregorian Chant from the Proper of the Mass	206
273	Allegri: Miserere	207
274	Pachelbel: Canon & Gigue	208
275	Vivaldi: The Four Seasons	209
276	Bach: Violin Concertos	210
277	Bach: Goldberg Variations	211
278	Bach: The Cello Suites	212
279	Handel: The Messiah (Highlights)	213
280	The World of Classical Favourites	214
281	Sir Neville Marriner: A Celebration	215
282	Mozart: Wind Concertos	216
283	Haydn: Symphonies 99 - 104	217
284	Beethoven: Symhonies Nos. 5 & 6	218
285	A Soprano Inspired	219
286	Great Opera Choruses	220
287	Wagner: Favourite Overtures	221
288	Faur�: Requiem, Ravel: Pavane & Others	222
289	Tchaikovsky: The Nutcracker	223
290	The Last Night of the Proms	224
291	Puccini: Madama Butterfly - Highlights	225
292	Holst: The Planets, Op. 32 & Vaughan Williams: Fantasies	226
293	Pavarotti's Opera Made Easy	227
294	Great Performances - Barber's Adagio and Other Romantic Favorites for Strings	228
295	Carmina Burana	229
296	A Copland Celebration, Vol. I	230
297	Bach: Toccata & Fugue in D Minor	231
298	Prokofiev: Symphony No.1	232
299	Scheherazade	233
300	Bach: The Brandenburg Concertos	234
301	Chopin: Piano Concertos Nos. 1 & 2	235
302	Mascagni: Cavalleria Rusticana	236
303	Sibelius: Finlandia	237
304	Beethoven Piano Sonatas: Moonlight & Pastorale	238
305	Great Recordings of the Century - Mahler: Das Lied von der Erde	240
306	Elgar: Cello Concerto & Vaughan Williams: Fantasias	241
307	Adams, John: The Chairman Dances	242
308	Tchaikovsky: 1812 Festival Overture, Op.49, Capriccio Italien & Beethoven: Wellington's Victory	243
309	Palestrina: Missa Papae Marcelli & Allegri: Miserere	244
310	Prokofiev: Romeo & Juliet	245
311	Strauss: Waltzes	226
312	Berlioz: Symphonie Fantastique	245
313	Bizet: Carmen Highlights	246
314	English Renaissance	247
315	Handel: Music for the Royal Fireworks (Original Version 1749)	208
316	Grieg: Peer Gynt Suites & Sibelius: Pell�as et M�lisande	248
317	Mozart Gala: Famous Arias	249
318	SCRIABIN: Vers la flamme	250
319	Armada: Music from the Courts of England and Spain	251
320	Mozart: Symphonies Nos. 40 & 41	248
321	Back to Black	252
322	Frank	252
323	Carried to Dust (Bonus Track Version)	253
324	Beethoven: Symphony No. 6 'Pastoral' Etc.	254
325	Bartok: Violin & Viola Concertos	255
326	Mendelssohn: A Midsummer Night's Dream	256
327	Bach: Orchestral Suites Nos. 1 - 4	257
328	Charpentier: Divertissements, Airs & Concerts	258
329	South American Getaway	259
330	G�recki: Symphony No. 3	260
331	Purcell: The Fairy Queen	261
332	The Ultimate Relexation Album	262
333	Purcell: Music for the Queen Mary	263
334	Weill: The Seven Deadly Sins	264
335	J.S. Bach: Chaconne, Suite in E Minor, Partita in E Major & Prelude, Fugue and Allegro	265
336	Prokofiev: Symphony No.5 & Stravinksy: Le Sacre Du Printemps	248
337	Szymanowski: Piano Works, Vol. 1	266
338	Nielsen: The Six Symphonies	267
339	Great Recordings of the Century: Paganini's 24 Caprices	268
340	Liszt - 12 �tudes D'Execution Transcendante	269
341	Great Recordings of the Century - Shubert: Schwanengesang, 4 Lieder	270
342	Locatelli: Concertos for Violin, Strings and Continuo, Vol. 3	271
343	Respighi:Pines of Rome	226
344	Schubert: The Late String Quartets & String Quintet (3 CD's)	272
345	Monteverdi: L'Orfeo	273
346	Mozart: Chamber Music	274
347	Koyaanisqatsi (Soundtrack from the Motion Picture)	275
\.


--
-- Data for Name: Artist; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Artist" ("ArtistId", "Name") FROM stdin;
1	AC/DC
2	Accept
3	Aerosmith
4	Alanis Morissette
5	Alice In Chains
6	Ant�nio Carlos Jobim
7	Apocalyptica
8	Audioslave
9	BackBeat
10	Billy Cobham
11	Black Label Society
12	Black Sabbath
13	Body Count
14	Bruce Dickinson
15	Buddy Guy
16	Caetano Veloso
17	Chico Buarque
18	Chico Science & Na��o Zumbi
19	Cidade Negra
20	Cl�udio Zoli
21	Various Artists
22	Led Zeppelin
23	Frank Zappa & Captain Beefheart
24	Marcos Valle
25	Milton Nascimento & Bebeto
26	Azymuth
27	Gilberto Gil
28	Jo�o Gilberto
29	Bebel Gilberto
30	Jorge Vercilo
31	Baby Consuelo
32	Ney Matogrosso
33	Luiz Melodia
34	Nando Reis
35	Pedro Lu�s & A Parede
36	O Rappa
37	Ed Motta
38	Banda Black Rio
39	Fernanda Porto
40	Os Cariocas
41	Elis Regina
42	Milton Nascimento
43	A Cor Do Som
44	Kid Abelha
45	Sandra De S�
46	Jorge Ben
47	Hermeto Pascoal
48	Bar�o Vermelho
49	Edson, DJ Marky & DJ Patife Featuring Fernanda Porto
50	Metallica
51	Queen
52	Kiss
53	Spyro Gyra
54	Green Day
55	David Coverdale
56	Gonzaguinha
57	Os Mutantes
58	Deep Purple
59	Santana
60	Santana Feat. Dave Matthews
61	Santana Feat. Everlast
62	Santana Feat. Rob Thomas
63	Santana Feat. Lauryn Hill & Cee-Lo
64	Santana Feat. The Project G&B
65	Santana Feat. Man�
66	Santana Feat. Eagle-Eye Cherry
67	Santana Feat. Eric Clapton
68	Miles Davis
69	Gene Krupa
70	Toquinho & Vin�cius
71	Vin�cius De Moraes & Baden Powell
72	Vin�cius De Moraes
73	Vin�cius E Qurteto Em Cy
74	Vin�cius E Odette Lara
75	Vinicius, Toquinho & Quarteto Em Cy
76	Creedence Clearwater Revival
77	C�ssia Eller
78	Def Leppard
79	Dennis Chambers
80	Djavan
81	Eric Clapton
82	Faith No More
83	Falamansa
84	Foo Fighters
85	Frank Sinatra
86	Funk Como Le Gusta
87	Godsmack
88	Guns N' Roses
89	Incognito
90	Iron Maiden
91	James Brown
92	Jamiroquai
93	JET
94	Jimi Hendrix
95	Joe Satriani
96	Jota Quest
97	Jo�o Suplicy
98	Judas Priest
99	Legi�o Urbana
100	Lenny Kravitz
101	Lulu Santos
102	Marillion
103	Marisa Monte
104	Marvin Gaye
105	Men At Work
106	Mot�rhead
107	Mot�rhead & Girlschool
108	M�nica Marianno
109	M�tley Cr�e
110	Nirvana
111	O Ter�o
112	Olodum
113	Os Paralamas Do Sucesso
114	Ozzy Osbourne
115	Page & Plant
116	Passengers
117	Paul D'Ianno
118	Pearl Jam
119	Peter Tosh
120	Pink Floyd
121	Planet Hemp
122	R.E.M. Feat. Kate Pearson
123	R.E.M. Feat. KRS-One
124	R.E.M.
125	Raimundos
126	Raul Seixas
127	Red Hot Chili Peppers
128	Rush
129	Simply Red
130	Skank
131	Smashing Pumpkins
132	Soundgarden
133	Stevie Ray Vaughan & Double Trouble
134	Stone Temple Pilots
135	System Of A Down
136	Terry Bozzio, Tony Levin & Steve Stevens
137	The Black Crowes
138	The Clash
139	The Cult
140	The Doors
141	The Police
142	The Rolling Stones
143	The Tea Party
144	The Who
145	Tim Maia
146	Tit�s
147	Battlestar Galactica
148	Heroes
149	Lost
150	U2
151	UB40
152	Van Halen
153	Velvet Revolver
154	Whitesnake
155	Zeca Pagodinho
156	The Office
157	Dread Zeppelin
158	Battlestar Galactica (Classic)
159	Aquaman
160	Christina Aguilera featuring BigElf
161	Aerosmith & Sierra Leone's Refugee Allstars
162	Los Lonely Boys
163	Corinne Bailey Rae
164	Dhani Harrison & Jakob Dylan
165	Jackson Browne
166	Avril Lavigne
167	Big & Rich
168	Youssou N'Dour
169	Black Eyed Peas
170	Jack Johnson
171	Ben Harper
172	Snow Patrol
173	Matisyahu
174	The Postal Service
175	Jaguares
176	The Flaming Lips
177	Jack's Mannequin & Mick Fleetwood
178	Regina Spektor
179	Scorpions
180	House Of Pain
181	Xis
182	Nega Gizza
183	Gustavo & Andres Veiga & Salazar
184	Rodox
185	Charlie Brown Jr.
186	Pedro Lu�s E A Parede
187	Los Hermanos
188	Mundo Livre S/A
189	Otto
190	Instituto
191	Na��o Zumbi
192	DJ Dolores & Orchestra Santa Massa
193	Seu Jorge
194	Sabotage E Instituto
195	Stereo Maracana
196	Cake
197	Aisha Duo
198	Habib Koit� and Bamada
199	Karsh Kale
200	The Posies
201	Luciana Souza/Romero Lubambo
202	Aaron Goldberg
203	Nicolaus Esterhazy Sinfonia
204	Temple of the Dog
205	Chris Cornell
206	Alberto Turco & Nova Schola Gregoriana
207	Richard Marlow & The Choir of Trinity College, Cambridge
208	English Concert & Trevor Pinnock
209	Anne-Sophie Mutter, Herbert Von Karajan & Wiener Philharmoniker
210	Hilary Hahn, Jeffrey Kahane, Los Angeles Chamber Orchestra & Margaret Batjer
211	Wilhelm Kempff
212	Yo-Yo Ma
213	Scholars Baroque Ensemble
214	Academy of St. Martin in the Fields & Sir Neville Marriner
215	Academy of St. Martin in the Fields Chamber Ensemble & Sir Neville Marriner
216	Berliner Philharmoniker, Claudio Abbado & Sabine Meyer
217	Royal Philharmonic Orchestra & Sir Thomas Beecham
218	Orchestre R�volutionnaire et Romantique & John Eliot Gardiner
219	Britten Sinfonia, Ivor Bolton & Lesley Garrett
220	Chicago Symphony Chorus, Chicago Symphony Orchestra & Sir Georg Solti
221	Sir Georg Solti & Wiener Philharmoniker
222	Academy of St. Martin in the Fields, John Birch, Sir Neville Marriner & Sylvia McNair
223	London Symphony Orchestra & Sir Charles Mackerras
224	Barry Wordsworth & BBC Concert Orchestra
225	Herbert Von Karajan, Mirella Freni & Wiener Philharmoniker
226	Eugene Ormandy
227	Luciano Pavarotti
228	Leonard Bernstein & New York Philharmonic
229	Boston Symphony Orchestra & Seiji Ozawa
230	Aaron Copland & London Symphony Orchestra
231	Ton Koopman
232	Sergei Prokofiev & Yuri Temirkanov
233	Chicago Symphony Orchestra & Fritz Reiner
234	Orchestra of The Age of Enlightenment
235	Emanuel Ax, Eugene Ormandy & Philadelphia Orchestra
236	James Levine
237	Berliner Philharmoniker & Hans Rosbaud
238	Maurizio Pollini
239	Academy of St. Martin in the Fields, Sir Neville Marriner & William Bennett
240	Gustav Mahler
241	Felix Schmidt, London Symphony Orchestra & Rafael Fr�hbeck de Burgos
242	Edo de Waart & San Francisco Symphony
243	Antal Dor�ti & London Symphony Orchestra
244	Choir Of Westminster Abbey & Simon Preston
245	Michael Tilson Thomas & San Francisco Symphony
246	Chor der Wiener Staatsoper, Herbert Von Karajan & Wiener Philharmoniker
247	The King's Singers
248	Berliner Philharmoniker & Herbert Von Karajan
249	Sir Georg Solti, Sumi Jo & Wiener Philharmoniker
250	Christopher O'Riley
251	Fretwork
252	Amy Winehouse
253	Calexico
254	Otto Klemperer & Philharmonia Orchestra
255	Yehudi Menuhin
256	Philharmonia Orchestra & Sir Neville Marriner
257	Academy of St. Martin in the Fields, Sir Neville Marriner & Thurston Dart
258	Les Arts Florissants & William Christie
259	The 12 Cellists of The Berlin Philharmonic
260	Adrian Leaper & Doreen de Feis
261	Roger Norrington, London Classical Players
262	Charles Dutoit & L'Orchestre Symphonique de Montr�al
263	Equale Brass Ensemble, John Eliot Gardiner & Munich Monteverdi Orchestra and Choir
264	Kent Nagano and Orchestre de l'Op�ra de Lyon
265	Julian Bream
266	Martin Roscoe
267	G�teborgs Symfoniker & Neeme J�rvi
268	Itzhak Perlman
269	Michele Campanella
270	Gerald Moore
271	Mela Tenenbaum, Pro Musica Prague & Richard Kapp
272	Emerson String Quartet
273	C. Monteverdi, Nigel Rogers - Chiaroscuro; London Baroque; London Cornett & Sackbu
274	Nash Ensemble
275	Philip Glass Ensemble
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") FROM stdin;
1	Lu�s	Gon�alves	Embraer - Empresa Brasileira de Aeron�utica S.A.	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	+55 (12) 3923-5555	+55 (12) 3923-5566	luisg@embraer.com.br	3
2	Leonie	K�hler	\N	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	+49 0711 2842222	\N	leonekohler@surfeu.de	5
3	Fran�ois	Tremblay	\N	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	+1 (514) 721-4711	\N	ftremblay@gmail.com	3
4	Bj�rn	Hansen	\N	Ullev�lsveien 14	Oslo	\N	Norway	0171	+47 22 44 22 22	\N	bjorn.hansen@yahoo.no	4
5	Franti�ek	Wichterlov�	JetBrains s.r.o.	Klanova 9/506	Prague	\N	Czech Republic	14700	+420 2 4172 5555	+420 2 4172 5555	frantisekw@jetbrains.com	4
6	Helena	Hol�	\N	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	+420 2 4177 0449	\N	hholy@gmail.com	5
7	Astrid	Gruber	\N	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	+43 01 5134505	\N	astrid.gruber@apple.at	5
8	Daan	Peeters	\N	Gr�trystraat 63	Brussels	\N	Belgium	1000	+32 02 219 03 03	\N	daan_peeters@apple.be	4
9	Kara	Nielsen	\N	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	+453 3331 9991	\N	kara.nielsen@jubii.dk	4
10	Eduardo	Martins	Woodstock Discos	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	+55 (11) 3033-5446	+55 (11) 3033-4564	eduardo@woodstock.com.br	4
11	Alexandre	Rocha	Banco do Brasil S.A.	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	+55 (11) 3055-3278	+55 (11) 3055-8131	alero@uol.com.br	5
12	Roberto	Almeida	Riotur	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	+55 (21) 2271-7000	+55 (21) 2271-7070	roberto.almeida@riotur.gov.br	3
13	Fernanda	Ramos	\N	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	+55 (61) 3363-5547	+55 (61) 3363-7855	fernadaramos4@uol.com.br	4
14	Mark	Philips	Telus	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	+1 (780) 434-4554	+1 (780) 434-5565	mphilips12@shaw.ca	5
15	Jennifer	Peterson	Rogers Canada	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	+1 (604) 688-2255	+1 (604) 688-8756	jenniferp@rogers.ca	3
16	Frank	Harris	Google Inc.	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	+1 (650) 253-0000	+1 (650) 253-0000	fharris@google.com	4
17	Jack	Smith	Microsoft Corporation	1 Microsoft Way	Redmond	WA	USA	98052-8300	+1 (425) 882-8080	+1 (425) 882-8081	jacksmith@microsoft.com	5
18	Michelle	Brooks	\N	627 Broadway	New York	NY	USA	10012-2612	+1 (212) 221-3546	+1 (212) 221-4679	michelleb@aol.com	3
19	Tim	Goyer	Apple Inc.	1 Infinite Loop	Cupertino	CA	USA	95014	+1 (408) 996-1010	+1 (408) 996-1011	tgoyer@apple.com	3
20	Dan	Miller	\N	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	+1 (650) 644-3358	\N	dmiller@comcast.com	4
21	Kathy	Chase	\N	801 W 4th Street	Reno	NV	USA	89503	+1 (775) 223-7665	\N	kachase@hotmail.com	5
22	Heather	Leacock	\N	120 S Orange Ave	Orlando	FL	USA	32801	+1 (407) 999-7788	\N	hleacock@gmail.com	4
23	John	Gordon	\N	69 Salem Street	Boston	MA	USA	2113	+1 (617) 522-1333	\N	johngordon22@yahoo.com	4
24	Frank	Ralston	\N	162 E Superior Street	Chicago	IL	USA	60611	+1 (312) 332-3232	\N	fralston@gmail.com	3
25	Victor	Stevens	\N	319 N. Frances Street	Madison	WI	USA	53703	+1 (608) 257-0597	\N	vstevens@yahoo.com	5
26	Richard	Cunningham	\N	2211 W Berry Street	Fort Worth	TX	USA	76110	+1 (817) 924-7272	\N	ricunningham@hotmail.com	4
27	Patrick	Gray	\N	1033 N Park Ave	Tucson	AZ	USA	85719	+1 (520) 622-4200	\N	patrick.gray@aol.com	4
28	Julia	Barnett	\N	302 S 700 E	Salt Lake City	UT	USA	84102	+1 (801) 531-7272	\N	jubarnett@gmail.com	5
29	Robert	Brown	\N	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	+1 (416) 363-8888	\N	robbrown@shaw.ca	3
30	Edward	Francis	\N	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	+1 (613) 234-3322	\N	edfrancis@yachoo.ca	3
31	Martha	Silk	\N	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	+1 (902) 450-0450	\N	marthasilk@gmail.com	5
32	Aaron	Mitchell	\N	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	+1 (204) 452-6452	\N	aaronmitchell@yahoo.ca	4
33	Ellie	Sullivan	\N	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	+1 (867) 920-2233	\N	ellie.sullivan@shaw.ca	3
34	Jo�o	Fernandes	\N	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	+351 (213) 466-111	\N	jfernandes@yahoo.pt	4
35	Madalena	Sampaio	\N	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	+351 (225) 022-448	\N	masampaio@sapo.pt	4
36	Hannah	Schneider	\N	Tauentzienstra�e 8	Berlin	\N	Germany	10789	+49 030 26550280	\N	hannah.schneider@yahoo.de	5
37	Fynn	Zimmermann	\N	Berger Stra�e 10	Frankfurt	\N	Germany	60316	+49 069 40598889	\N	fzimmermann@yahoo.de	3
38	Niklas	Schr�der	\N	Barbarossastra�e 19	Berlin	\N	Germany	10779	+49 030 2141444	\N	nschroder@surfeu.de	3
39	Camille	Bernard	\N	4, Rue Milton	Paris	\N	France	75009	+33 01 49 70 65 65	\N	camille.bernard@yahoo.fr	4
40	Dominique	Lefebvre	\N	8, Rue Hanovre	Paris	\N	France	75002	+33 01 47 42 71 71	\N	dominiquelefebvre@gmail.com	4
41	Marc	Dubois	\N	11, Place Bellecour	Lyon	\N	France	69002	+33 04 78 30 30 30	\N	marc.dubois@hotmail.com	5
42	Wyatt	Girard	\N	9, Place Louis Barthou	Bordeaux	\N	France	33000	+33 05 56 96 96 96	\N	wyatt.girard@yahoo.fr	3
43	Isabelle	Mercier	\N	68, Rue Jouvence	Dijon	\N	France	21000	+33 03 80 73 66 99	\N	isabelle_mercier@apple.fr	3
44	Terhi	H�m�l�inen	\N	Porthaninkatu 9	Helsinki	\N	Finland	00530	+358 09 870 2000	\N	terhi.hamalainen@apple.fi	3
45	Ladislav	Kov�cs	\N	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	\N	\N	ladislav_kovacs@apple.hu	3
46	Hugh	O'Reilly	\N	3 Chatham Street	Dublin	Dublin	Ireland	\N	+353 01 6792424	\N	hughoreilly@apple.ie	3
47	Lucas	Mancini	\N	Via Degli Scipioni, 43	Rome	RM	Italy	00192	+39 06 39733434	\N	lucas.mancini@yahoo.it	5
48	Johannes	Van der Berg	\N	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	+31 020 6223130	\N	johavanderberg@yahoo.nl	5
49	Stanislaw	W�jcik	\N	Ordynacka 10	Warsaw	\N	Poland	00-358	+48 22 828 37 39	\N	stanislaw.w�jcik@wp.pl	4
50	Enrique	Mu�oz	\N	C/ San Bernardo 85	Madrid	\N	Spain	28015	+34 914 454 454	\N	enrique_munoz@yahoo.es	5
51	Joakim	Johansson	\N	Celsiusg. 9	Stockholm	\N	Sweden	11230	+46 08-651 52 52	\N	joakim.johansson@yahoo.se	5
52	Emma	Jones	\N	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	+44 020 7707 0707	\N	emma_jones@hotmail.com	3
53	Phil	Hughes	\N	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	+44 020 7976 5722	\N	phil.hughes@gmail.com	3
54	Steve	Murray	\N	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	+44 0131 315 3300	\N	steve.murray@yahoo.uk	5
55	Mark	Taylor	\N	421 Bourke Street	Sidney	NSW	Australia	2010	+61 (02) 9332 3633	\N	mark.taylor@yahoo.au	4
56	Diego	Guti�rrez	\N	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	+54 (0)11 4311 4333	\N	diego.gutierrez@yahoo.ar	4
57	Luis	Rojas	\N	Calle Lira, 198	Santiago	\N	Chile	\N	+56 (0)2 635 4444	\N	luisrojas@yahoo.cl	5
58	Manoj	Pareek	\N	12,Community Centre	Delhi	\N	India	110017	+91 0124 39883988	\N	manoj.pareek@rediff.com	3
59	Puja	Srivastava	\N	3,Raj Bhavan Road	Bangalore	\N	India	560001	+91 080 22289999	\N	puja_srivastava@yahoo.in	3
\.


--
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") FROM stdin;
1	Adams	Andrew	General Manager	\N	1962-02-18 00:00:00	2002-08-14 00:00:00	11120 Jasper Ave NW	Edmonton	AB	Canada	T5K 2N1	+1 (780) 428-9482	+1 (780) 428-3457	andrew@chinookcorp.com
2	Edwards	Nancy	Sales Manager	1	1958-12-08 00:00:00	2002-05-01 00:00:00	825 8 Ave SW	Calgary	AB	Canada	T2P 2T3	+1 (403) 262-3443	+1 (403) 262-3322	nancy@chinookcorp.com
3	Peacock	Jane	Sales Support Agent	2	1973-08-29 00:00:00	2002-04-01 00:00:00	1111 6 Ave SW	Calgary	AB	Canada	T2P 5M5	+1 (403) 262-3443	+1 (403) 262-6712	jane@chinookcorp.com
4	Park	Margaret	Sales Support Agent	2	1947-09-19 00:00:00	2003-05-03 00:00:00	683 10 Street SW	Calgary	AB	Canada	T2P 5G3	+1 (403) 263-4423	+1 (403) 263-4289	margaret@chinookcorp.com
5	Johnson	Steve	Sales Support Agent	2	1965-03-03 00:00:00	2003-10-17 00:00:00	7727B 41 Ave	Calgary	AB	Canada	T3B 1Y7	1 (780) 836-9987	1 (780) 836-9543	steve@chinookcorp.com
6	Mitchell	Michael	IT Manager	1	1973-07-01 00:00:00	2003-10-17 00:00:00	5827 Bowness Road NW	Calgary	AB	Canada	T3B 0C5	+1 (403) 246-9887	+1 (403) 246-9899	michael@chinookcorp.com
7	King	Robert	IT Staff	6	1970-05-29 00:00:00	2004-01-02 00:00:00	590 Columbia Boulevard West	Lethbridge	AB	Canada	T1K 5N8	+1 (403) 456-9986	+1 (403) 456-8485	robert@chinookcorp.com
8	Callahan	Laura	IT Staff	6	1968-01-09 00:00:00	2004-03-04 00:00:00	923 7 ST NW	Lethbridge	AB	Canada	T1H 1Y8	+1 (403) 467-3351	+1 (403) 467-8772	laura@chinookcorp.com
\.


--
-- Data for Name: Genre; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Genre" ("GenreId", "Name") FROM stdin;
1	Rock
2	Jazz
3	Metal
4	Alternative & Punk
5	Rock And Roll
6	Blues
7	Latin
8	Reggae
9	Pop
10	Soundtrack
11	Bossa Nova
12	Easy Listening
13	Heavy Metal
14	R&B/Soul
15	Electronica/Dance
16	World
17	Hip Hop/Rap
18	Science Fiction
19	TV Shows
20	Sci Fi & Fantasy
21	Drama
22	Comedy
23	Alternative
24	Classical
25	Opera
\.


--
-- Data for Name: Invoice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") FROM stdin;
1	2	2009-01-01 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	1.98
2	4	2009-01-02 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	3.96
3	8	2009-01-03 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	5.94
4	14	2009-01-06 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	8.91
5	23	2009-01-11 00:00:00	69 Salem Street	Boston	MA	USA	2113	13.86
6	37	2009-01-19 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	0.99
7	38	2009-02-01 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	1.98
8	40	2009-02-01 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	1.98
9	42	2009-02-02 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	3.96
10	46	2009-02-03 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	5.94
11	52	2009-02-06 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	8.91
12	2	2009-02-11 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	13.86
13	16	2009-02-19 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	0.99
14	17	2009-03-04 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	1.98
15	19	2009-03-04 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	1.98
16	21	2009-03-05 00:00:00	801 W 4th Street	Reno	NV	USA	89503	3.96
17	25	2009-03-06 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	5.94
18	31	2009-03-09 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	8.91
19	40	2009-03-14 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	13.86
20	54	2009-03-22 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	0.99
21	55	2009-04-04 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	1.98
22	57	2009-04-04 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	1.98
23	59	2009-04-05 00:00:00	3,Raj Bhavan Road	Bangalore	\N	India	560001	3.96
24	4	2009-04-06 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	5.94
25	10	2009-04-09 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	8.91
26	19	2009-04-14 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	13.86
27	33	2009-04-22 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	0.99
28	34	2009-05-05 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	1.98
29	36	2009-05-05 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	1.98
30	38	2009-05-06 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	3.96
31	42	2009-05-07 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	5.94
32	48	2009-05-10 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	8.91
33	57	2009-05-15 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	13.86
34	12	2009-05-23 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	0.99
35	13	2009-06-05 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	1.98
36	15	2009-06-05 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	1.98
37	17	2009-06-06 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	3.96
38	21	2009-06-07 00:00:00	801 W 4th Street	Reno	NV	USA	89503	5.94
39	27	2009-06-10 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	8.91
40	36	2009-06-15 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	13.86
41	50	2009-06-23 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	0.99
42	51	2009-07-06 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	1.98
43	53	2009-07-06 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	1.98
44	55	2009-07-07 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	3.96
45	59	2009-07-08 00:00:00	3,Raj Bhavan Road	Bangalore	\N	India	560001	5.94
46	6	2009-07-11 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	8.91
47	15	2009-07-16 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	13.86
48	29	2009-07-24 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	0.99
49	30	2009-08-06 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	1.98
50	32	2009-08-06 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	1.98
51	34	2009-08-07 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	3.96
52	38	2009-08-08 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	5.94
53	44	2009-08-11 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	8.91
54	53	2009-08-16 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	13.86
55	8	2009-08-24 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	0.99
56	9	2009-09-06 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	1.98
57	11	2009-09-06 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	1.98
58	13	2009-09-07 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	3.96
59	17	2009-09-08 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	5.94
60	23	2009-09-11 00:00:00	69 Salem Street	Boston	MA	USA	2113	8.91
61	32	2009-09-16 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	13.86
62	46	2009-09-24 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	0.99
63	47	2009-10-07 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	1.98
64	49	2009-10-07 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	1.98
65	51	2009-10-08 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	3.96
66	55	2009-10-09 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	5.94
67	2	2009-10-12 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	8.91
68	11	2009-10-17 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	13.86
69	25	2009-10-25 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	0.99
70	26	2009-11-07 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	1.98
71	28	2009-11-07 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	1.98
72	30	2009-11-08 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	3.96
73	34	2009-11-09 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	5.94
74	40	2009-11-12 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	8.91
75	49	2009-11-17 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	13.86
76	4	2009-11-25 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	0.99
77	5	2009-12-08 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	1.98
78	7	2009-12-08 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	1.98
79	9	2009-12-09 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	3.96
80	13	2009-12-10 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	5.94
81	19	2009-12-13 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	8.91
82	28	2009-12-18 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	13.86
83	42	2009-12-26 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	0.99
84	43	2010-01-08 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	1.98
85	45	2010-01-08 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	1.98
86	47	2010-01-09 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	3.96
87	51	2010-01-10 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	6.94
88	57	2010-01-13 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	17.91
89	7	2010-01-18 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	18.86
90	21	2010-01-26 00:00:00	801 W 4th Street	Reno	NV	USA	89503	0.99
91	22	2010-02-08 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	1.98
92	24	2010-02-08 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	1.98
93	26	2010-02-09 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	3.96
94	30	2010-02-10 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	5.94
95	36	2010-02-13 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	8.91
96	45	2010-02-18 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	21.86
97	59	2010-02-26 00:00:00	3,Raj Bhavan Road	Bangalore	\N	India	560001	1.99
98	1	2010-03-11 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	3.98
99	3	2010-03-11 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	3.98
100	5	2010-03-12 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	3.96
101	9	2010-03-13 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	5.94
102	15	2010-03-16 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	9.91
103	24	2010-03-21 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	15.86
104	38	2010-03-29 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	0.99
105	39	2010-04-11 00:00:00	4, Rue Milton	Paris	\N	France	75009	1.98
106	41	2010-04-11 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	1.98
107	43	2010-04-12 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	3.96
108	47	2010-04-13 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	5.94
109	53	2010-04-16 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	8.91
110	3	2010-04-21 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	13.86
111	17	2010-04-29 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	0.99
112	18	2010-05-12 00:00:00	627 Broadway	New York	NY	USA	10012-2612	1.98
113	20	2010-05-12 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	1.98
114	22	2010-05-13 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	3.96
115	26	2010-05-14 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	5.94
116	32	2010-05-17 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	8.91
117	41	2010-05-22 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	13.86
118	55	2010-05-30 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	0.99
119	56	2010-06-12 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	1.98
120	58	2010-06-12 00:00:00	12,Community Centre	Delhi	\N	India	110017	1.98
121	1	2010-06-13 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	3.96
122	5	2010-06-14 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	5.94
123	11	2010-06-17 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	8.91
124	20	2010-06-22 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	13.86
125	34	2010-06-30 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	0.99
126	35	2010-07-13 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	1.98
127	37	2010-07-13 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	1.98
128	39	2010-07-14 00:00:00	4, Rue Milton	Paris	\N	France	75009	3.96
129	43	2010-07-15 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	5.94
130	49	2010-07-18 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	8.91
131	58	2010-07-23 00:00:00	12,Community Centre	Delhi	\N	India	110017	13.86
132	13	2010-07-31 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	0.99
133	14	2010-08-13 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	1.98
134	16	2010-08-13 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	1.98
135	18	2010-08-14 00:00:00	627 Broadway	New York	NY	USA	10012-2612	3.96
136	22	2010-08-15 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	5.94
137	28	2010-08-18 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	8.91
138	37	2010-08-23 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	13.86
139	51	2010-08-31 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	0.99
140	52	2010-09-13 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	1.98
141	54	2010-09-13 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	1.98
142	56	2010-09-14 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	3.96
143	1	2010-09-15 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	5.94
144	7	2010-09-18 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	8.91
145	16	2010-09-23 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	13.86
146	30	2010-10-01 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	0.99
147	31	2010-10-14 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	1.98
148	33	2010-10-14 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	1.98
149	35	2010-10-15 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	3.96
150	39	2010-10-16 00:00:00	4, Rue Milton	Paris	\N	France	75009	5.94
151	45	2010-10-19 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	8.91
152	54	2010-10-24 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	13.86
153	9	2010-11-01 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	0.99
154	10	2010-11-14 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	1.98
155	12	2010-11-14 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	1.98
156	14	2010-11-15 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	3.96
157	18	2010-11-16 00:00:00	627 Broadway	New York	NY	USA	10012-2612	5.94
158	24	2010-11-19 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	8.91
159	33	2010-11-24 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	13.86
160	47	2010-12-02 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	0.99
161	48	2010-12-15 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	1.98
162	50	2010-12-15 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	1.98
163	52	2010-12-16 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	3.96
164	56	2010-12-17 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	5.94
165	3	2010-12-20 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	8.91
166	12	2010-12-25 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	13.86
167	26	2011-01-02 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	0.99
168	27	2011-01-15 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	1.98
169	29	2011-01-15 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	1.98
170	31	2011-01-16 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	3.96
171	35	2011-01-17 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	5.94
172	41	2011-01-20 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	8.91
173	50	2011-01-25 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	13.86
174	5	2011-02-02 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	0.99
175	6	2011-02-15 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	1.98
176	8	2011-02-15 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	1.98
177	10	2011-02-16 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	3.96
178	14	2011-02-17 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	5.94
179	20	2011-02-20 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	8.91
180	29	2011-02-25 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	13.86
181	43	2011-03-05 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	0.99
182	44	2011-03-18 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	1.98
183	46	2011-03-18 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	1.98
184	48	2011-03-19 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	3.96
185	52	2011-03-20 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	5.94
186	58	2011-03-23 00:00:00	12,Community Centre	Delhi	\N	India	110017	8.91
187	8	2011-03-28 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	13.86
188	22	2011-04-05 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	0.99
189	23	2011-04-18 00:00:00	69 Salem Street	Boston	MA	USA	2113	1.98
190	25	2011-04-18 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	1.98
191	27	2011-04-19 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	3.96
192	31	2011-04-20 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	5.94
193	37	2011-04-23 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	14.91
194	46	2011-04-28 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	21.86
195	1	2011-05-06 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	0.99
196	2	2011-05-19 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	1.98
197	4	2011-05-19 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	1.98
198	6	2011-05-20 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	3.96
199	10	2011-05-21 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	5.94
200	16	2011-05-24 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	8.91
201	25	2011-05-29 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	18.86
202	39	2011-06-06 00:00:00	4, Rue Milton	Paris	\N	France	75009	1.99
203	40	2011-06-19 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	2.98
204	42	2011-06-19 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	3.98
205	44	2011-06-20 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	7.96
206	48	2011-06-21 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	8.94
207	54	2011-06-24 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	8.91
208	4	2011-06-29 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	15.86
209	18	2011-07-07 00:00:00	627 Broadway	New York	NY	USA	10012-2612	0.99
210	19	2011-07-20 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	1.98
211	21	2011-07-20 00:00:00	801 W 4th Street	Reno	NV	USA	89503	1.98
212	23	2011-07-21 00:00:00	69 Salem Street	Boston	MA	USA	2113	3.96
213	27	2011-07-22 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	5.94
214	33	2011-07-25 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	8.91
215	42	2011-07-30 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	13.86
216	56	2011-08-07 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	0.99
217	57	2011-08-20 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	1.98
218	59	2011-08-20 00:00:00	3,Raj Bhavan Road	Bangalore	\N	India	560001	1.98
219	2	2011-08-21 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	3.96
220	6	2011-08-22 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	5.94
221	12	2011-08-25 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	8.91
222	21	2011-08-30 00:00:00	801 W 4th Street	Reno	NV	USA	89503	13.86
223	35	2011-09-07 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	0.99
224	36	2011-09-20 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	1.98
225	38	2011-09-20 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	1.98
226	40	2011-09-21 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	3.96
227	44	2011-09-22 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	5.94
228	50	2011-09-25 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	8.91
229	59	2011-09-30 00:00:00	3,Raj Bhavan Road	Bangalore	\N	India	560001	13.86
230	14	2011-10-08 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	0.99
231	15	2011-10-21 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	1.98
232	17	2011-10-21 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	1.98
233	19	2011-10-22 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	3.96
234	23	2011-10-23 00:00:00	69 Salem Street	Boston	MA	USA	2113	5.94
235	29	2011-10-26 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	8.91
236	38	2011-10-31 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	13.86
237	52	2011-11-08 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	0.99
238	53	2011-11-21 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	1.98
239	55	2011-11-21 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	1.98
240	57	2011-11-22 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	3.96
241	2	2011-11-23 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	5.94
242	8	2011-11-26 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	8.91
243	17	2011-12-01 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	13.86
244	31	2011-12-09 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	0.99
245	32	2011-12-22 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	1.98
246	34	2011-12-22 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	1.98
247	36	2011-12-23 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	3.96
248	40	2011-12-24 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	5.94
249	46	2011-12-27 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	8.91
250	55	2012-01-01 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	13.86
251	10	2012-01-09 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	0.99
252	11	2012-01-22 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	1.98
253	13	2012-01-22 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	1.98
254	15	2012-01-23 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	3.96
255	19	2012-01-24 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	5.94
256	25	2012-01-27 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	8.91
257	34	2012-02-01 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	13.86
258	48	2012-02-09 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	0.99
259	49	2012-02-22 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	1.98
260	51	2012-02-22 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	1.98
261	53	2012-02-23 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	3.96
262	57	2012-02-24 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	5.94
263	4	2012-02-27 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	8.91
264	13	2012-03-03 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	13.86
265	27	2012-03-11 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	0.99
266	28	2012-03-24 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	1.98
267	30	2012-03-24 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	1.98
268	32	2012-03-25 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	3.96
269	36	2012-03-26 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	5.94
270	42	2012-03-29 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	8.91
271	51	2012-04-03 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	13.86
272	6	2012-04-11 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	0.99
273	7	2012-04-24 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	1.98
274	9	2012-04-24 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	1.98
275	11	2012-04-25 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	3.96
276	15	2012-04-26 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	5.94
277	21	2012-04-29 00:00:00	801 W 4th Street	Reno	NV	USA	89503	8.91
278	30	2012-05-04 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	13.86
279	44	2012-05-12 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	0.99
280	45	2012-05-25 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	1.98
281	47	2012-05-25 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	1.98
282	49	2012-05-26 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	3.96
283	53	2012-05-27 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	5.94
284	59	2012-05-30 00:00:00	3,Raj Bhavan Road	Bangalore	\N	India	560001	8.91
285	9	2012-06-04 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	13.86
286	23	2012-06-12 00:00:00	69 Salem Street	Boston	MA	USA	2113	0.99
287	24	2012-06-25 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	1.98
288	26	2012-06-25 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	1.98
289	28	2012-06-26 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	3.96
290	32	2012-06-27 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	5.94
291	38	2012-06-30 00:00:00	Barbarossastra�e 19	Berlin	\N	Germany	10779	8.91
292	47	2012-07-05 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	13.86
293	2	2012-07-13 00:00:00	Theodor-Heuss-Stra�e 34	Stuttgart	\N	Germany	70174	0.99
294	3	2012-07-26 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	1.98
295	5	2012-07-26 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	1.98
296	7	2012-07-27 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	3.96
297	11	2012-07-28 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	5.94
298	17	2012-07-31 00:00:00	1 Microsoft Way	Redmond	WA	USA	98052-8300	10.91
299	26	2012-08-05 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	23.86
300	40	2012-08-13 00:00:00	8, Rue Hanovre	Paris	\N	France	75002	0.99
301	41	2012-08-26 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	1.98
302	43	2012-08-26 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	1.98
303	45	2012-08-27 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	3.96
304	49	2012-08-28 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	5.94
305	55	2012-08-31 00:00:00	421 Bourke Street	Sidney	NSW	Australia	2010	8.91
306	5	2012-09-05 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	16.86
307	19	2012-09-13 00:00:00	1 Infinite Loop	Cupertino	CA	USA	95014	1.99
308	20	2012-09-26 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	3.98
309	22	2012-09-26 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	3.98
310	24	2012-09-27 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	7.96
311	28	2012-09-28 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	11.94
312	34	2012-10-01 00:00:00	Rua da Assun��o 53	Lisbon	\N	Portugal	\N	10.91
313	43	2012-10-06 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	16.86
314	57	2012-10-14 00:00:00	Calle Lira, 198	Santiago	\N	Chile	\N	0.99
315	58	2012-10-27 00:00:00	12,Community Centre	Delhi	\N	India	110017	1.98
316	1	2012-10-27 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	1.98
317	3	2012-10-28 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	3.96
396	18	2013-10-08 00:00:00	627 Broadway	New York	NY	USA	10012-2612	8.91
318	7	2012-10-29 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	5.94
319	13	2012-11-01 00:00:00	Qe 7 Bloco G	Bras�lia	DF	Brazil	71020-677	8.91
320	22	2012-11-06 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	13.86
321	36	2012-11-14 00:00:00	Tauentzienstra�e 8	Berlin	\N	Germany	10789	0.99
322	37	2012-11-27 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	1.98
323	39	2012-11-27 00:00:00	4, Rue Milton	Paris	\N	France	75009	1.98
324	41	2012-11-28 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	3.96
325	45	2012-11-29 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	5.94
326	51	2012-12-02 00:00:00	Celsiusg. 9	Stockholm	\N	Sweden	11230	8.91
327	1	2012-12-07 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	13.86
328	15	2012-12-15 00:00:00	700 W Pender Street	Vancouver	BC	Canada	V6C 1G8	0.99
329	16	2012-12-28 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	1.98
330	18	2012-12-28 00:00:00	627 Broadway	New York	NY	USA	10012-2612	1.98
331	20	2012-12-29 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	3.96
332	24	2012-12-30 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	5.94
333	30	2013-01-02 00:00:00	230 Elgin Street	Ottawa	ON	Canada	K2P 1L7	8.91
334	39	2013-01-07 00:00:00	4, Rue Milton	Paris	\N	France	75009	13.86
335	53	2013-01-15 00:00:00	113 Lupus St	London	\N	United Kingdom	SW1V 3EN	0.99
336	54	2013-01-28 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	1.98
337	56	2013-01-28 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	1.98
338	58	2013-01-29 00:00:00	12,Community Centre	Delhi	\N	India	110017	3.96
339	3	2013-01-30 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	5.94
340	9	2013-02-02 00:00:00	S�nder Boulevard 51	Copenhagen	\N	Denmark	1720	8.91
341	18	2013-02-07 00:00:00	627 Broadway	New York	NY	USA	10012-2612	13.86
342	32	2013-02-15 00:00:00	696 Osborne Street	Winnipeg	MB	Canada	R3L 2B9	0.99
343	33	2013-02-28 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	1.98
344	35	2013-02-28 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	1.98
345	37	2013-03-01 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	3.96
346	41	2013-03-02 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	5.94
347	47	2013-03-05 00:00:00	Via Degli Scipioni, 43	Rome	RM	Italy	00192	8.91
348	56	2013-03-10 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	13.86
349	11	2013-03-18 00:00:00	Av. Paulista, 2022	S�o Paulo	SP	Brazil	01310-200	0.99
350	12	2013-03-31 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	1.98
351	14	2013-03-31 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	1.98
352	16	2013-04-01 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	3.96
353	20	2013-04-02 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	5.94
354	26	2013-04-05 00:00:00	2211 W Berry Street	Fort Worth	TX	USA	76110	8.91
355	35	2013-04-10 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	13.86
356	49	2013-04-18 00:00:00	Ordynacka 10	Warsaw	\N	Poland	00-358	0.99
357	50	2013-05-01 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	1.98
358	52	2013-05-01 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	1.98
359	54	2013-05-02 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	3.96
360	58	2013-05-03 00:00:00	12,Community Centre	Delhi	\N	India	110017	5.94
361	5	2013-05-06 00:00:00	Klanova 9/506	Prague	\N	Czech Republic	14700	8.91
362	14	2013-05-11 00:00:00	8210 111 ST NW	Edmonton	AB	Canada	T6G 2C7	13.86
363	28	2013-05-19 00:00:00	302 S 700 E	Salt Lake City	UT	USA	84102	0.99
364	29	2013-06-01 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	1.98
365	31	2013-06-01 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	1.98
366	33	2013-06-02 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	3.96
367	37	2013-06-03 00:00:00	Berger Stra�e 10	Frankfurt	\N	Germany	60316	5.94
368	43	2013-06-06 00:00:00	68, Rue Jouvence	Dijon	\N	France	21000	8.91
369	52	2013-06-11 00:00:00	202 Hoxton Street	London	\N	United Kingdom	N1 5LH	13.86
370	7	2013-06-19 00:00:00	Rotenturmstra�e 4, 1010 Innere Stadt	Vienne	\N	Austria	1010	0.99
371	8	2013-07-02 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	1.98
372	10	2013-07-02 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	1.98
373	12	2013-07-03 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	3.96
374	16	2013-07-04 00:00:00	1600 Amphitheatre Parkway	Mountain View	CA	USA	94043-1351	5.94
375	22	2013-07-07 00:00:00	120 S Orange Ave	Orlando	FL	USA	32801	8.91
376	31	2013-07-12 00:00:00	194A Chain Lake Drive	Halifax	NS	Canada	B3S 1C5	13.86
377	45	2013-07-20 00:00:00	Erzs�bet krt. 58.	Budapest	\N	Hungary	H-1073	0.99
378	46	2013-08-02 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	1.98
379	48	2013-08-02 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	1.98
380	50	2013-08-03 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	3.96
381	54	2013-08-04 00:00:00	110 Raeburn Pl	Edinburgh	\N	United Kingdom	EH4 1HH	5.94
382	1	2013-08-07 00:00:00	Av. Brigadeiro Faria Lima, 2170	S�o Jos� dos Campos	SP	Brazil	12227-000	8.91
383	10	2013-08-12 00:00:00	Rua Dr. Falc�o Filho, 155	S�o Paulo	SP	Brazil	01007-010	13.86
384	24	2013-08-20 00:00:00	162 E Superior Street	Chicago	IL	USA	60611	0.99
385	25	2013-09-02 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	1.98
386	27	2013-09-02 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	1.98
387	29	2013-09-03 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	3.96
388	33	2013-09-04 00:00:00	5112 48 Street	Yellowknife	NT	Canada	X1A 1N6	5.94
389	39	2013-09-07 00:00:00	4, Rue Milton	Paris	\N	France	75009	8.91
390	48	2013-09-12 00:00:00	Lijnbaansgracht 120bg	Amsterdam	VV	Netherlands	1016	13.86
391	3	2013-09-20 00:00:00	1498 rue B�langer	Montr�al	QC	Canada	H2G 1A7	0.99
392	4	2013-10-03 00:00:00	Ullev�lsveien 14	Oslo	\N	Norway	0171	1.98
393	6	2013-10-03 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	1.98
394	8	2013-10-04 00:00:00	Gr�trystraat 63	Brussels	\N	Belgium	1000	3.96
395	12	2013-10-05 00:00:00	Pra�a Pio X, 119	Rio de Janeiro	RJ	Brazil	20040-020	5.94
397	27	2013-10-13 00:00:00	1033 N Park Ave	Tucson	AZ	USA	85719	13.86
398	41	2013-10-21 00:00:00	11, Place Bellecour	Lyon	\N	France	69002	0.99
399	42	2013-11-03 00:00:00	9, Place Louis Barthou	Bordeaux	\N	France	33000	1.98
400	44	2013-11-03 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	1.98
401	46	2013-11-04 00:00:00	3 Chatham Street	Dublin	Dublin	Ireland	\N	3.96
402	50	2013-11-05 00:00:00	C/ San Bernardo 85	Madrid	\N	Spain	28015	5.94
403	56	2013-11-08 00:00:00	307 Macacha G�emes	Buenos Aires	\N	Argentina	1106	8.91
404	6	2013-11-13 00:00:00	Rilsk� 3174/6	Prague	\N	Czech Republic	14300	25.86
405	20	2013-11-21 00:00:00	541 Del Medio Avenue	Mountain View	CA	USA	94040-111	0.99
406	21	2013-12-04 00:00:00	801 W 4th Street	Reno	NV	USA	89503	1.98
407	23	2013-12-04 00:00:00	69 Salem Street	Boston	MA	USA	2113	1.98
408	25	2013-12-05 00:00:00	319 N. Frances Street	Madison	WI	USA	53703	3.96
409	29	2013-12-06 00:00:00	796 Dundas Street West	Toronto	ON	Canada	M6J 1V1	5.94
410	35	2013-12-09 00:00:00	Rua dos Campe�es Europeus de Viena, 4350	Porto	\N	Portugal	\N	8.91
411	44	2013-12-14 00:00:00	Porthaninkatu 9	Helsinki	\N	Finland	00530	13.86
412	58	2013-12-22 00:00:00	12,Community Centre	Delhi	\N	India	110017	1.99
\.


--
-- Data for Name: InvoiceLine; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."InvoiceLine" ("InvoiceLineId", "InvoiceId", "TrackId", "UnitPrice", "Quantity") FROM stdin;
1	1	2	0.99	1
2	1	4	0.99	1
3	2	6	0.99	1
4	2	8	0.99	1
5	2	10	0.99	1
6	2	12	0.99	1
7	3	16	0.99	1
8	3	20	0.99	1
9	3	24	0.99	1
10	3	28	0.99	1
11	3	32	0.99	1
12	3	36	0.99	1
13	4	42	0.99	1
14	4	48	0.99	1
15	4	54	0.99	1
16	4	60	0.99	1
17	4	66	0.99	1
18	4	72	0.99	1
19	4	78	0.99	1
20	4	84	0.99	1
21	4	90	0.99	1
22	5	99	0.99	1
23	5	108	0.99	1
24	5	117	0.99	1
25	5	126	0.99	1
26	5	135	0.99	1
27	5	144	0.99	1
28	5	153	0.99	1
29	5	162	0.99	1
30	5	171	0.99	1
31	5	180	0.99	1
32	5	189	0.99	1
33	5	198	0.99	1
34	5	207	0.99	1
35	5	216	0.99	1
36	6	230	0.99	1
37	7	231	0.99	1
38	7	232	0.99	1
39	8	234	0.99	1
40	8	236	0.99	1
41	9	238	0.99	1
42	9	240	0.99	1
43	9	242	0.99	1
44	9	244	0.99	1
45	10	248	0.99	1
46	10	252	0.99	1
47	10	256	0.99	1
48	10	260	0.99	1
49	10	264	0.99	1
50	10	268	0.99	1
51	11	274	0.99	1
52	11	280	0.99	1
53	11	286	0.99	1
54	11	292	0.99	1
55	11	298	0.99	1
56	11	304	0.99	1
57	11	310	0.99	1
58	11	316	0.99	1
59	11	322	0.99	1
60	12	331	0.99	1
61	12	340	0.99	1
62	12	349	0.99	1
63	12	358	0.99	1
64	12	367	0.99	1
65	12	376	0.99	1
66	12	385	0.99	1
67	12	394	0.99	1
68	12	403	0.99	1
69	12	412	0.99	1
70	12	421	0.99	1
71	12	430	0.99	1
72	12	439	0.99	1
73	12	448	0.99	1
74	13	462	0.99	1
75	14	463	0.99	1
76	14	464	0.99	1
77	15	466	0.99	1
78	15	468	0.99	1
79	16	470	0.99	1
80	16	472	0.99	1
81	16	474	0.99	1
82	16	476	0.99	1
83	17	480	0.99	1
84	17	484	0.99	1
85	17	488	0.99	1
86	17	492	0.99	1
87	17	496	0.99	1
88	17	500	0.99	1
89	18	506	0.99	1
90	18	512	0.99	1
91	18	518	0.99	1
92	18	524	0.99	1
93	18	530	0.99	1
94	18	536	0.99	1
95	18	542	0.99	1
96	18	548	0.99	1
97	18	554	0.99	1
98	19	563	0.99	1
99	19	572	0.99	1
100	19	581	0.99	1
101	19	590	0.99	1
102	19	599	0.99	1
103	19	608	0.99	1
104	19	617	0.99	1
105	19	626	0.99	1
106	19	635	0.99	1
107	19	644	0.99	1
108	19	653	0.99	1
109	19	662	0.99	1
110	19	671	0.99	1
111	19	680	0.99	1
112	20	694	0.99	1
113	21	695	0.99	1
114	21	696	0.99	1
115	22	698	0.99	1
116	22	700	0.99	1
117	23	702	0.99	1
118	23	704	0.99	1
119	23	706	0.99	1
120	23	708	0.99	1
121	24	712	0.99	1
122	24	716	0.99	1
123	24	720	0.99	1
124	24	724	0.99	1
125	24	728	0.99	1
126	24	732	0.99	1
127	25	738	0.99	1
128	25	744	0.99	1
129	25	750	0.99	1
130	25	756	0.99	1
131	25	762	0.99	1
132	25	768	0.99	1
133	25	774	0.99	1
134	25	780	0.99	1
135	25	786	0.99	1
136	26	795	0.99	1
137	26	804	0.99	1
138	26	813	0.99	1
139	26	822	0.99	1
140	26	831	0.99	1
141	26	840	0.99	1
142	26	849	0.99	1
143	26	858	0.99	1
144	26	867	0.99	1
145	26	876	0.99	1
146	26	885	0.99	1
147	26	894	0.99	1
148	26	903	0.99	1
149	26	912	0.99	1
150	27	926	0.99	1
151	28	927	0.99	1
152	28	928	0.99	1
153	29	930	0.99	1
154	29	932	0.99	1
155	30	934	0.99	1
156	30	936	0.99	1
157	30	938	0.99	1
158	30	940	0.99	1
159	31	944	0.99	1
160	31	948	0.99	1
161	31	952	0.99	1
162	31	956	0.99	1
163	31	960	0.99	1
164	31	964	0.99	1
165	32	970	0.99	1
166	32	976	0.99	1
167	32	982	0.99	1
168	32	988	0.99	1
169	32	994	0.99	1
170	32	1000	0.99	1
171	32	1006	0.99	1
172	32	1012	0.99	1
173	32	1018	0.99	1
174	33	1027	0.99	1
175	33	1036	0.99	1
176	33	1045	0.99	1
177	33	1054	0.99	1
178	33	1063	0.99	1
179	33	1072	0.99	1
180	33	1081	0.99	1
181	33	1090	0.99	1
182	33	1099	0.99	1
183	33	1108	0.99	1
184	33	1117	0.99	1
185	33	1126	0.99	1
186	33	1135	0.99	1
187	33	1144	0.99	1
188	34	1158	0.99	1
189	35	1159	0.99	1
190	35	1160	0.99	1
191	36	1162	0.99	1
192	36	1164	0.99	1
193	37	1166	0.99	1
194	37	1168	0.99	1
195	37	1170	0.99	1
196	37	1172	0.99	1
197	38	1176	0.99	1
198	38	1180	0.99	1
199	38	1184	0.99	1
200	38	1188	0.99	1
201	38	1192	0.99	1
202	38	1196	0.99	1
203	39	1202	0.99	1
204	39	1208	0.99	1
205	39	1214	0.99	1
206	39	1220	0.99	1
207	39	1226	0.99	1
208	39	1232	0.99	1
209	39	1238	0.99	1
210	39	1244	0.99	1
211	39	1250	0.99	1
212	40	1259	0.99	1
213	40	1268	0.99	1
214	40	1277	0.99	1
215	40	1286	0.99	1
216	40	1295	0.99	1
217	40	1304	0.99	1
218	40	1313	0.99	1
219	40	1322	0.99	1
220	40	1331	0.99	1
221	40	1340	0.99	1
222	40	1349	0.99	1
223	40	1358	0.99	1
224	40	1367	0.99	1
225	40	1376	0.99	1
226	41	1390	0.99	1
227	42	1391	0.99	1
228	42	1392	0.99	1
229	43	1394	0.99	1
230	43	1396	0.99	1
231	44	1398	0.99	1
232	44	1400	0.99	1
233	44	1402	0.99	1
234	44	1404	0.99	1
235	45	1408	0.99	1
236	45	1412	0.99	1
237	45	1416	0.99	1
238	45	1420	0.99	1
239	45	1424	0.99	1
240	45	1428	0.99	1
241	46	1434	0.99	1
242	46	1440	0.99	1
243	46	1446	0.99	1
244	46	1452	0.99	1
245	46	1458	0.99	1
246	46	1464	0.99	1
247	46	1470	0.99	1
248	46	1476	0.99	1
249	46	1482	0.99	1
250	47	1491	0.99	1
251	47	1500	0.99	1
252	47	1509	0.99	1
253	47	1518	0.99	1
254	47	1527	0.99	1
255	47	1536	0.99	1
256	47	1545	0.99	1
257	47	1554	0.99	1
258	47	1563	0.99	1
259	47	1572	0.99	1
260	47	1581	0.99	1
261	47	1590	0.99	1
262	47	1599	0.99	1
263	47	1608	0.99	1
264	48	1622	0.99	1
265	49	1623	0.99	1
266	49	1624	0.99	1
267	50	1626	0.99	1
268	50	1628	0.99	1
269	51	1630	0.99	1
270	51	1632	0.99	1
271	51	1634	0.99	1
272	51	1636	0.99	1
273	52	1640	0.99	1
274	52	1644	0.99	1
275	52	1648	0.99	1
276	52	1652	0.99	1
277	52	1656	0.99	1
278	52	1660	0.99	1
279	53	1666	0.99	1
280	53	1672	0.99	1
281	53	1678	0.99	1
282	53	1684	0.99	1
283	53	1690	0.99	1
284	53	1696	0.99	1
285	53	1702	0.99	1
286	53	1708	0.99	1
287	53	1714	0.99	1
288	54	1723	0.99	1
289	54	1732	0.99	1
290	54	1741	0.99	1
291	54	1750	0.99	1
292	54	1759	0.99	1
293	54	1768	0.99	1
294	54	1777	0.99	1
295	54	1786	0.99	1
296	54	1795	0.99	1
297	54	1804	0.99	1
298	54	1813	0.99	1
299	54	1822	0.99	1
300	54	1831	0.99	1
301	54	1840	0.99	1
302	55	1854	0.99	1
303	56	1855	0.99	1
304	56	1856	0.99	1
305	57	1858	0.99	1
306	57	1860	0.99	1
307	58	1862	0.99	1
308	58	1864	0.99	1
309	58	1866	0.99	1
310	58	1868	0.99	1
311	59	1872	0.99	1
312	59	1876	0.99	1
313	59	1880	0.99	1
314	59	1884	0.99	1
315	59	1888	0.99	1
316	59	1892	0.99	1
317	60	1898	0.99	1
318	60	1904	0.99	1
319	60	1910	0.99	1
320	60	1916	0.99	1
321	60	1922	0.99	1
322	60	1928	0.99	1
323	60	1934	0.99	1
324	60	1940	0.99	1
325	60	1946	0.99	1
326	61	1955	0.99	1
327	61	1964	0.99	1
328	61	1973	0.99	1
329	61	1982	0.99	1
330	61	1991	0.99	1
331	61	2000	0.99	1
332	61	2009	0.99	1
333	61	2018	0.99	1
334	61	2027	0.99	1
335	61	2036	0.99	1
336	61	2045	0.99	1
337	61	2054	0.99	1
338	61	2063	0.99	1
339	61	2072	0.99	1
340	62	2086	0.99	1
341	63	2087	0.99	1
342	63	2088	0.99	1
343	64	2090	0.99	1
344	64	2092	0.99	1
345	65	2094	0.99	1
346	65	2096	0.99	1
347	65	2098	0.99	1
348	65	2100	0.99	1
349	66	2104	0.99	1
350	66	2108	0.99	1
351	66	2112	0.99	1
352	66	2116	0.99	1
353	66	2120	0.99	1
354	66	2124	0.99	1
355	67	2130	0.99	1
356	67	2136	0.99	1
357	67	2142	0.99	1
358	67	2148	0.99	1
359	67	2154	0.99	1
360	67	2160	0.99	1
361	67	2166	0.99	1
362	67	2172	0.99	1
363	67	2178	0.99	1
364	68	2187	0.99	1
365	68	2196	0.99	1
366	68	2205	0.99	1
367	68	2214	0.99	1
368	68	2223	0.99	1
369	68	2232	0.99	1
370	68	2241	0.99	1
371	68	2250	0.99	1
372	68	2259	0.99	1
373	68	2268	0.99	1
374	68	2277	0.99	1
375	68	2286	0.99	1
376	68	2295	0.99	1
377	68	2304	0.99	1
378	69	2318	0.99	1
379	70	2319	0.99	1
380	70	2320	0.99	1
381	71	2322	0.99	1
382	71	2324	0.99	1
383	72	2326	0.99	1
384	72	2328	0.99	1
385	72	2330	0.99	1
386	72	2332	0.99	1
387	73	2336	0.99	1
388	73	2340	0.99	1
389	73	2344	0.99	1
390	73	2348	0.99	1
391	73	2352	0.99	1
392	73	2356	0.99	1
393	74	2362	0.99	1
394	74	2368	0.99	1
395	74	2374	0.99	1
396	74	2380	0.99	1
397	74	2386	0.99	1
398	74	2392	0.99	1
399	74	2398	0.99	1
400	74	2404	0.99	1
401	74	2410	0.99	1
402	75	2419	0.99	1
403	75	2428	0.99	1
404	75	2437	0.99	1
405	75	2446	0.99	1
406	75	2455	0.99	1
407	75	2464	0.99	1
408	75	2473	0.99	1
409	75	2482	0.99	1
410	75	2491	0.99	1
411	75	2500	0.99	1
412	75	2509	0.99	1
413	75	2518	0.99	1
414	75	2527	0.99	1
415	75	2536	0.99	1
416	76	2550	0.99	1
417	77	2551	0.99	1
418	77	2552	0.99	1
419	78	2554	0.99	1
420	78	2556	0.99	1
421	79	2558	0.99	1
422	79	2560	0.99	1
423	79	2562	0.99	1
424	79	2564	0.99	1
425	80	2568	0.99	1
426	80	2572	0.99	1
427	80	2576	0.99	1
428	80	2580	0.99	1
429	80	2584	0.99	1
430	80	2588	0.99	1
431	81	2594	0.99	1
432	81	2600	0.99	1
433	81	2606	0.99	1
434	81	2612	0.99	1
435	81	2618	0.99	1
436	81	2624	0.99	1
437	81	2630	0.99	1
438	81	2636	0.99	1
439	81	2642	0.99	1
440	82	2651	0.99	1
441	82	2660	0.99	1
442	82	2669	0.99	1
443	82	2678	0.99	1
444	82	2687	0.99	1
445	82	2696	0.99	1
446	82	2705	0.99	1
447	82	2714	0.99	1
448	82	2723	0.99	1
449	82	2732	0.99	1
450	82	2741	0.99	1
451	82	2750	0.99	1
452	82	2759	0.99	1
453	82	2768	0.99	1
454	83	2782	0.99	1
455	84	2783	0.99	1
456	84	2784	0.99	1
457	85	2786	0.99	1
458	85	2788	0.99	1
459	86	2790	0.99	1
460	86	2792	0.99	1
461	86	2794	0.99	1
462	86	2796	0.99	1
463	87	2800	0.99	1
464	87	2804	0.99	1
465	87	2808	0.99	1
466	87	2812	0.99	1
467	87	2816	0.99	1
468	87	2820	1.99	1
469	88	2826	1.99	1
470	88	2832	1.99	1
471	88	2838	1.99	1
472	88	2844	1.99	1
473	88	2850	1.99	1
474	88	2856	1.99	1
475	88	2862	1.99	1
476	88	2868	1.99	1
477	88	2874	1.99	1
478	89	2883	1.99	1
479	89	2892	1.99	1
480	89	2901	1.99	1
481	89	2910	1.99	1
482	89	2919	1.99	1
483	89	2928	0.99	1
484	89	2937	0.99	1
485	89	2946	0.99	1
486	89	2955	0.99	1
487	89	2964	0.99	1
488	89	2973	0.99	1
489	89	2982	0.99	1
490	89	2991	0.99	1
491	89	3000	0.99	1
492	90	3014	0.99	1
493	91	3015	0.99	1
494	91	3016	0.99	1
495	92	3018	0.99	1
496	92	3020	0.99	1
497	93	3022	0.99	1
498	93	3024	0.99	1
499	93	3026	0.99	1
500	93	3028	0.99	1
501	94	3032	0.99	1
502	94	3036	0.99	1
503	94	3040	0.99	1
504	94	3044	0.99	1
505	94	3048	0.99	1
506	94	3052	0.99	1
507	95	3058	0.99	1
508	95	3064	0.99	1
509	95	3070	0.99	1
510	95	3076	0.99	1
511	95	3082	0.99	1
512	95	3088	0.99	1
513	95	3094	0.99	1
514	95	3100	0.99	1
515	95	3106	0.99	1
516	96	3115	0.99	1
517	96	3124	0.99	1
518	96	3133	0.99	1
519	96	3142	0.99	1
520	96	3151	0.99	1
521	96	3160	0.99	1
522	96	3169	1.99	1
523	96	3178	1.99	1
524	96	3187	1.99	1
525	96	3196	1.99	1
526	96	3205	1.99	1
527	96	3214	1.99	1
528	96	3223	1.99	1
529	96	3232	1.99	1
530	97	3246	1.99	1
531	98	3247	1.99	1
532	98	3248	1.99	1
533	99	3250	1.99	1
534	99	3252	1.99	1
535	100	3254	0.99	1
536	100	3256	0.99	1
537	100	3258	0.99	1
538	100	3260	0.99	1
539	101	3264	0.99	1
540	101	3268	0.99	1
541	101	3272	0.99	1
542	101	3276	0.99	1
543	101	3280	0.99	1
544	101	3284	0.99	1
545	102	3290	0.99	1
546	102	3296	0.99	1
547	102	3302	0.99	1
548	102	3308	0.99	1
549	102	3314	0.99	1
550	102	3320	0.99	1
551	102	3326	0.99	1
552	102	3332	0.99	1
553	102	3338	1.99	1
554	103	3347	1.99	1
555	103	3356	0.99	1
556	103	3365	0.99	1
557	103	3374	0.99	1
558	103	3383	0.99	1
559	103	3392	0.99	1
560	103	3401	0.99	1
561	103	3410	0.99	1
562	103	3419	0.99	1
563	103	3428	1.99	1
564	103	3437	0.99	1
565	103	3446	0.99	1
566	103	3455	0.99	1
567	103	3464	0.99	1
568	104	3478	0.99	1
569	105	3479	0.99	1
570	105	3480	0.99	1
571	106	3482	0.99	1
572	106	3484	0.99	1
573	107	3486	0.99	1
574	107	3488	0.99	1
575	107	3490	0.99	1
576	107	3492	0.99	1
577	108	3496	0.99	1
578	108	3500	0.99	1
579	108	1	0.99	1
580	108	5	0.99	1
581	108	9	0.99	1
582	108	13	0.99	1
583	109	19	0.99	1
584	109	25	0.99	1
585	109	31	0.99	1
586	109	37	0.99	1
587	109	43	0.99	1
588	109	49	0.99	1
589	109	55	0.99	1
590	109	61	0.99	1
591	109	67	0.99	1
592	110	76	0.99	1
593	110	85	0.99	1
594	110	94	0.99	1
595	110	103	0.99	1
596	110	112	0.99	1
597	110	121	0.99	1
598	110	130	0.99	1
599	110	139	0.99	1
600	110	148	0.99	1
601	110	157	0.99	1
602	110	166	0.99	1
603	110	175	0.99	1
604	110	184	0.99	1
605	110	193	0.99	1
606	111	207	0.99	1
607	112	208	0.99	1
608	112	209	0.99	1
609	113	211	0.99	1
610	113	213	0.99	1
611	114	215	0.99	1
612	114	217	0.99	1
613	114	219	0.99	1
614	114	221	0.99	1
615	115	225	0.99	1
616	115	229	0.99	1
617	115	233	0.99	1
618	115	237	0.99	1
619	115	241	0.99	1
620	115	245	0.99	1
621	116	251	0.99	1
622	116	257	0.99	1
623	116	263	0.99	1
624	116	269	0.99	1
625	116	275	0.99	1
626	116	281	0.99	1
627	116	287	0.99	1
628	116	293	0.99	1
629	116	299	0.99	1
630	117	308	0.99	1
631	117	317	0.99	1
632	117	326	0.99	1
633	117	335	0.99	1
634	117	344	0.99	1
635	117	353	0.99	1
636	117	362	0.99	1
637	117	371	0.99	1
638	117	380	0.99	1
639	117	389	0.99	1
640	117	398	0.99	1
641	117	407	0.99	1
642	117	416	0.99	1
643	117	425	0.99	1
644	118	439	0.99	1
645	119	440	0.99	1
646	119	441	0.99	1
647	120	443	0.99	1
648	120	445	0.99	1
649	121	447	0.99	1
650	121	449	0.99	1
651	121	451	0.99	1
652	121	453	0.99	1
653	122	457	0.99	1
654	122	461	0.99	1
655	122	465	0.99	1
656	122	469	0.99	1
657	122	473	0.99	1
658	122	477	0.99	1
659	123	483	0.99	1
660	123	489	0.99	1
661	123	495	0.99	1
662	123	501	0.99	1
663	123	507	0.99	1
664	123	513	0.99	1
665	123	519	0.99	1
666	123	525	0.99	1
667	123	531	0.99	1
668	124	540	0.99	1
669	124	549	0.99	1
670	124	558	0.99	1
671	124	567	0.99	1
672	124	576	0.99	1
673	124	585	0.99	1
674	124	594	0.99	1
675	124	603	0.99	1
676	124	612	0.99	1
677	124	621	0.99	1
678	124	630	0.99	1
679	124	639	0.99	1
680	124	648	0.99	1
681	124	657	0.99	1
682	125	671	0.99	1
683	126	672	0.99	1
684	126	673	0.99	1
685	127	675	0.99	1
686	127	677	0.99	1
687	128	679	0.99	1
688	128	681	0.99	1
689	128	683	0.99	1
690	128	685	0.99	1
691	129	689	0.99	1
692	129	693	0.99	1
693	129	697	0.99	1
694	129	701	0.99	1
695	129	705	0.99	1
696	129	709	0.99	1
697	130	715	0.99	1
698	130	721	0.99	1
699	130	727	0.99	1
700	130	733	0.99	1
701	130	739	0.99	1
702	130	745	0.99	1
703	130	751	0.99	1
704	130	757	0.99	1
705	130	763	0.99	1
706	131	772	0.99	1
707	131	781	0.99	1
708	131	790	0.99	1
709	131	799	0.99	1
710	131	808	0.99	1
711	131	817	0.99	1
712	131	826	0.99	1
713	131	835	0.99	1
714	131	844	0.99	1
715	131	853	0.99	1
716	131	862	0.99	1
717	131	871	0.99	1
718	131	880	0.99	1
719	131	889	0.99	1
720	132	903	0.99	1
721	133	904	0.99	1
722	133	905	0.99	1
723	134	907	0.99	1
724	134	909	0.99	1
725	135	911	0.99	1
726	135	913	0.99	1
727	135	915	0.99	1
728	135	917	0.99	1
729	136	921	0.99	1
730	136	925	0.99	1
731	136	929	0.99	1
732	136	933	0.99	1
733	136	937	0.99	1
734	136	941	0.99	1
735	137	947	0.99	1
736	137	953	0.99	1
737	137	959	0.99	1
738	137	965	0.99	1
739	137	971	0.99	1
740	137	977	0.99	1
741	137	983	0.99	1
742	137	989	0.99	1
743	137	995	0.99	1
744	138	1004	0.99	1
745	138	1013	0.99	1
746	138	1022	0.99	1
747	138	1031	0.99	1
748	138	1040	0.99	1
749	138	1049	0.99	1
750	138	1058	0.99	1
751	138	1067	0.99	1
752	138	1076	0.99	1
753	138	1085	0.99	1
754	138	1094	0.99	1
755	138	1103	0.99	1
756	138	1112	0.99	1
757	138	1121	0.99	1
758	139	1135	0.99	1
759	140	1136	0.99	1
760	140	1137	0.99	1
761	141	1139	0.99	1
762	141	1141	0.99	1
763	142	1143	0.99	1
764	142	1145	0.99	1
765	142	1147	0.99	1
766	142	1149	0.99	1
767	143	1153	0.99	1
768	143	1157	0.99	1
769	143	1161	0.99	1
770	143	1165	0.99	1
771	143	1169	0.99	1
772	143	1173	0.99	1
773	144	1179	0.99	1
774	144	1185	0.99	1
775	144	1191	0.99	1
776	144	1197	0.99	1
777	144	1203	0.99	1
778	144	1209	0.99	1
779	144	1215	0.99	1
780	144	1221	0.99	1
781	144	1227	0.99	1
782	145	1236	0.99	1
783	145	1245	0.99	1
784	145	1254	0.99	1
785	145	1263	0.99	1
786	145	1272	0.99	1
787	145	1281	0.99	1
788	145	1290	0.99	1
789	145	1299	0.99	1
790	145	1308	0.99	1
791	145	1317	0.99	1
792	145	1326	0.99	1
793	145	1335	0.99	1
794	145	1344	0.99	1
795	145	1353	0.99	1
796	146	1367	0.99	1
797	147	1368	0.99	1
798	147	1369	0.99	1
799	148	1371	0.99	1
800	148	1373	0.99	1
801	149	1375	0.99	1
802	149	1377	0.99	1
803	149	1379	0.99	1
804	149	1381	0.99	1
805	150	1385	0.99	1
806	150	1389	0.99	1
807	150	1393	0.99	1
808	150	1397	0.99	1
809	150	1401	0.99	1
810	150	1405	0.99	1
811	151	1411	0.99	1
812	151	1417	0.99	1
813	151	1423	0.99	1
814	151	1429	0.99	1
815	151	1435	0.99	1
816	151	1441	0.99	1
817	151	1447	0.99	1
818	151	1453	0.99	1
819	151	1459	0.99	1
820	152	1468	0.99	1
821	152	1477	0.99	1
822	152	1486	0.99	1
823	152	1495	0.99	1
824	152	1504	0.99	1
825	152	1513	0.99	1
826	152	1522	0.99	1
827	152	1531	0.99	1
828	152	1540	0.99	1
829	152	1549	0.99	1
830	152	1558	0.99	1
831	152	1567	0.99	1
832	152	1576	0.99	1
833	152	1585	0.99	1
834	153	1599	0.99	1
835	154	1600	0.99	1
836	154	1601	0.99	1
837	155	1603	0.99	1
838	155	1605	0.99	1
839	156	1607	0.99	1
840	156	1609	0.99	1
841	156	1611	0.99	1
842	156	1613	0.99	1
843	157	1617	0.99	1
844	157	1621	0.99	1
845	157	1625	0.99	1
846	157	1629	0.99	1
847	157	1633	0.99	1
848	157	1637	0.99	1
849	158	1643	0.99	1
850	158	1649	0.99	1
851	158	1655	0.99	1
852	158	1661	0.99	1
853	158	1667	0.99	1
854	158	1673	0.99	1
855	158	1679	0.99	1
856	158	1685	0.99	1
857	158	1691	0.99	1
858	159	1700	0.99	1
859	159	1709	0.99	1
860	159	1718	0.99	1
861	159	1727	0.99	1
862	159	1736	0.99	1
863	159	1745	0.99	1
864	159	1754	0.99	1
865	159	1763	0.99	1
866	159	1772	0.99	1
867	159	1781	0.99	1
868	159	1790	0.99	1
869	159	1799	0.99	1
870	159	1808	0.99	1
871	159	1817	0.99	1
872	160	1831	0.99	1
873	161	1832	0.99	1
874	161	1833	0.99	1
875	162	1835	0.99	1
876	162	1837	0.99	1
877	163	1839	0.99	1
878	163	1841	0.99	1
879	163	1843	0.99	1
880	163	1845	0.99	1
881	164	1849	0.99	1
882	164	1853	0.99	1
883	164	1857	0.99	1
884	164	1861	0.99	1
885	164	1865	0.99	1
886	164	1869	0.99	1
887	165	1875	0.99	1
888	165	1881	0.99	1
889	165	1887	0.99	1
890	165	1893	0.99	1
891	165	1899	0.99	1
892	165	1905	0.99	1
893	165	1911	0.99	1
894	165	1917	0.99	1
895	165	1923	0.99	1
896	166	1932	0.99	1
897	166	1941	0.99	1
898	166	1950	0.99	1
899	166	1959	0.99	1
900	166	1968	0.99	1
901	166	1977	0.99	1
902	166	1986	0.99	1
903	166	1995	0.99	1
904	166	2004	0.99	1
905	166	2013	0.99	1
906	166	2022	0.99	1
907	166	2031	0.99	1
908	166	2040	0.99	1
909	166	2049	0.99	1
910	167	2063	0.99	1
911	168	2064	0.99	1
912	168	2065	0.99	1
913	169	2067	0.99	1
914	169	2069	0.99	1
915	170	2071	0.99	1
916	170	2073	0.99	1
917	170	2075	0.99	1
918	170	2077	0.99	1
919	171	2081	0.99	1
920	171	2085	0.99	1
921	171	2089	0.99	1
922	171	2093	0.99	1
923	171	2097	0.99	1
924	171	2101	0.99	1
925	172	2107	0.99	1
926	172	2113	0.99	1
927	172	2119	0.99	1
928	172	2125	0.99	1
929	172	2131	0.99	1
930	172	2137	0.99	1
931	172	2143	0.99	1
932	172	2149	0.99	1
933	172	2155	0.99	1
934	173	2164	0.99	1
935	173	2173	0.99	1
936	173	2182	0.99	1
937	173	2191	0.99	1
938	173	2200	0.99	1
939	173	2209	0.99	1
940	173	2218	0.99	1
941	173	2227	0.99	1
942	173	2236	0.99	1
943	173	2245	0.99	1
944	173	2254	0.99	1
945	173	2263	0.99	1
946	173	2272	0.99	1
947	173	2281	0.99	1
948	174	2295	0.99	1
949	175	2296	0.99	1
950	175	2297	0.99	1
951	176	2299	0.99	1
952	176	2301	0.99	1
953	177	2303	0.99	1
954	177	2305	0.99	1
955	177	2307	0.99	1
956	177	2309	0.99	1
957	178	2313	0.99	1
958	178	2317	0.99	1
959	178	2321	0.99	1
960	178	2325	0.99	1
961	178	2329	0.99	1
962	178	2333	0.99	1
963	179	2339	0.99	1
964	179	2345	0.99	1
965	179	2351	0.99	1
966	179	2357	0.99	1
967	179	2363	0.99	1
968	179	2369	0.99	1
969	179	2375	0.99	1
970	179	2381	0.99	1
971	179	2387	0.99	1
972	180	2396	0.99	1
973	180	2405	0.99	1
974	180	2414	0.99	1
975	180	2423	0.99	1
976	180	2432	0.99	1
977	180	2441	0.99	1
978	180	2450	0.99	1
979	180	2459	0.99	1
980	180	2468	0.99	1
981	180	2477	0.99	1
982	180	2486	0.99	1
983	180	2495	0.99	1
984	180	2504	0.99	1
985	180	2513	0.99	1
986	181	2527	0.99	1
987	182	2528	0.99	1
988	182	2529	0.99	1
989	183	2531	0.99	1
990	183	2533	0.99	1
991	184	2535	0.99	1
992	184	2537	0.99	1
993	184	2539	0.99	1
994	184	2541	0.99	1
995	185	2545	0.99	1
996	185	2549	0.99	1
997	185	2553	0.99	1
998	185	2557	0.99	1
999	185	2561	0.99	1
1000	185	2565	0.99	1
1001	186	2571	0.99	1
1002	186	2577	0.99	1
1003	186	2583	0.99	1
1004	186	2589	0.99	1
1005	186	2595	0.99	1
1006	186	2601	0.99	1
1007	186	2607	0.99	1
1008	186	2613	0.99	1
1009	186	2619	0.99	1
1010	187	2628	0.99	1
1011	187	2637	0.99	1
1012	187	2646	0.99	1
1013	187	2655	0.99	1
1014	187	2664	0.99	1
1015	187	2673	0.99	1
1016	187	2682	0.99	1
1017	187	2691	0.99	1
1018	187	2700	0.99	1
1019	187	2709	0.99	1
1020	187	2718	0.99	1
1021	187	2727	0.99	1
1022	187	2736	0.99	1
1023	187	2745	0.99	1
1024	188	2759	0.99	1
1025	189	2760	0.99	1
1026	189	2761	0.99	1
1027	190	2763	0.99	1
1028	190	2765	0.99	1
1029	191	2767	0.99	1
1030	191	2769	0.99	1
1031	191	2771	0.99	1
1032	191	2773	0.99	1
1033	192	2777	0.99	1
1034	192	2781	0.99	1
1035	192	2785	0.99	1
1036	192	2789	0.99	1
1037	192	2793	0.99	1
1038	192	2797	0.99	1
1039	193	2803	0.99	1
1040	193	2809	0.99	1
1041	193	2815	0.99	1
1042	193	2821	1.99	1
1043	193	2827	1.99	1
1044	193	2833	1.99	1
1045	193	2839	1.99	1
1046	193	2845	1.99	1
1047	193	2851	1.99	1
1048	194	2860	1.99	1
1049	194	2869	1.99	1
1050	194	2878	1.99	1
1051	194	2887	1.99	1
1052	194	2896	1.99	1
1053	194	2905	1.99	1
1054	194	2914	1.99	1
1055	194	2923	1.99	1
1056	194	2932	0.99	1
1057	194	2941	0.99	1
1058	194	2950	0.99	1
1059	194	2959	0.99	1
1060	194	2968	0.99	1
1061	194	2977	0.99	1
1062	195	2991	0.99	1
1063	196	2992	0.99	1
1064	196	2993	0.99	1
1065	197	2995	0.99	1
1066	197	2997	0.99	1
1067	198	2999	0.99	1
1068	198	3001	0.99	1
1069	198	3003	0.99	1
1070	198	3005	0.99	1
1071	199	3009	0.99	1
1072	199	3013	0.99	1
1073	199	3017	0.99	1
1074	199	3021	0.99	1
1075	199	3025	0.99	1
1076	199	3029	0.99	1
1077	200	3035	0.99	1
1078	200	3041	0.99	1
1079	200	3047	0.99	1
1080	200	3053	0.99	1
1081	200	3059	0.99	1
1082	200	3065	0.99	1
1083	200	3071	0.99	1
1084	200	3077	0.99	1
1085	200	3083	0.99	1
1086	201	3092	0.99	1
1087	201	3101	0.99	1
1088	201	3110	0.99	1
1089	201	3119	0.99	1
1090	201	3128	0.99	1
1091	201	3137	0.99	1
1092	201	3146	0.99	1
1093	201	3155	0.99	1
1094	201	3164	0.99	1
1095	201	3173	1.99	1
1096	201	3182	1.99	1
1097	201	3191	1.99	1
1098	201	3200	1.99	1
1099	201	3209	1.99	1
1100	202	3223	1.99	1
1101	203	3224	1.99	1
1102	203	3225	0.99	1
1103	204	3227	1.99	1
1104	204	3229	1.99	1
1105	205	3231	1.99	1
1106	205	3233	1.99	1
1107	205	3235	1.99	1
1108	205	3237	1.99	1
1109	206	3241	1.99	1
1110	206	3245	1.99	1
1111	206	3249	1.99	1
1112	206	3253	0.99	1
1113	206	3257	0.99	1
1114	206	3261	0.99	1
1115	207	3267	0.99	1
1116	207	3273	0.99	1
1117	207	3279	0.99	1
1118	207	3285	0.99	1
1119	207	3291	0.99	1
1120	207	3297	0.99	1
1121	207	3303	0.99	1
1122	207	3309	0.99	1
1123	207	3315	0.99	1
1124	208	3324	0.99	1
1125	208	3333	0.99	1
1126	208	3342	1.99	1
1127	208	3351	0.99	1
1128	208	3360	1.99	1
1129	208	3369	0.99	1
1130	208	3378	0.99	1
1131	208	3387	0.99	1
1132	208	3396	0.99	1
1133	208	3405	0.99	1
1134	208	3414	0.99	1
1135	208	3423	0.99	1
1136	208	3432	0.99	1
1137	208	3441	0.99	1
1138	209	3455	0.99	1
1139	210	3456	0.99	1
1140	210	3457	0.99	1
1141	211	3459	0.99	1
1142	211	3461	0.99	1
1143	212	3463	0.99	1
1144	212	3465	0.99	1
1145	212	3467	0.99	1
1146	212	3469	0.99	1
1147	213	3473	0.99	1
1148	213	3477	0.99	1
1149	213	3481	0.99	1
1150	213	3485	0.99	1
1151	213	3489	0.99	1
1152	213	3493	0.99	1
1153	214	3499	0.99	1
1154	214	2	0.99	1
1155	214	8	0.99	1
1156	214	14	0.99	1
1157	214	20	0.99	1
1158	214	26	0.99	1
1159	214	32	0.99	1
1160	214	38	0.99	1
1161	214	44	0.99	1
1162	215	53	0.99	1
1163	215	62	0.99	1
1164	215	71	0.99	1
1165	215	80	0.99	1
1166	215	89	0.99	1
1167	215	98	0.99	1
1168	215	107	0.99	1
1169	215	116	0.99	1
1170	215	125	0.99	1
1171	215	134	0.99	1
1172	215	143	0.99	1
1173	215	152	0.99	1
1174	215	161	0.99	1
1175	215	170	0.99	1
1176	216	184	0.99	1
1177	217	185	0.99	1
1178	217	186	0.99	1
1179	218	188	0.99	1
1180	218	190	0.99	1
1181	219	192	0.99	1
1182	219	194	0.99	1
1183	219	196	0.99	1
1184	219	198	0.99	1
1185	220	202	0.99	1
1186	220	206	0.99	1
1187	220	210	0.99	1
1188	220	214	0.99	1
1189	220	218	0.99	1
1190	220	222	0.99	1
1191	221	228	0.99	1
1192	221	234	0.99	1
1193	221	240	0.99	1
1194	221	246	0.99	1
1195	221	252	0.99	1
1196	221	258	0.99	1
1197	221	264	0.99	1
1198	221	270	0.99	1
1199	221	276	0.99	1
1200	222	285	0.99	1
1201	222	294	0.99	1
1202	222	303	0.99	1
1203	222	312	0.99	1
1204	222	321	0.99	1
1205	222	330	0.99	1
1206	222	339	0.99	1
1207	222	348	0.99	1
1208	222	357	0.99	1
1209	222	366	0.99	1
1210	222	375	0.99	1
1211	222	384	0.99	1
1212	222	393	0.99	1
1213	222	402	0.99	1
1214	223	416	0.99	1
1215	224	417	0.99	1
1216	224	418	0.99	1
1217	225	420	0.99	1
1218	225	422	0.99	1
1219	226	424	0.99	1
1220	226	426	0.99	1
1221	226	428	0.99	1
1222	226	430	0.99	1
1223	227	434	0.99	1
1224	227	438	0.99	1
1225	227	442	0.99	1
1226	227	446	0.99	1
1227	227	450	0.99	1
1228	227	454	0.99	1
1229	228	460	0.99	1
1230	228	466	0.99	1
1231	228	472	0.99	1
1232	228	478	0.99	1
1233	228	484	0.99	1
1234	228	490	0.99	1
1235	228	496	0.99	1
1236	228	502	0.99	1
1237	228	508	0.99	1
1238	229	517	0.99	1
1239	229	526	0.99	1
1240	229	535	0.99	1
1241	229	544	0.99	1
1242	229	553	0.99	1
1243	229	562	0.99	1
1244	229	571	0.99	1
1245	229	580	0.99	1
1246	229	589	0.99	1
1247	229	598	0.99	1
1248	229	607	0.99	1
1249	229	616	0.99	1
1250	229	625	0.99	1
1251	229	634	0.99	1
1252	230	648	0.99	1
1253	231	649	0.99	1
1254	231	650	0.99	1
1255	232	652	0.99	1
1256	232	654	0.99	1
1257	233	656	0.99	1
1258	233	658	0.99	1
1259	233	660	0.99	1
1260	233	662	0.99	1
1261	234	666	0.99	1
1262	234	670	0.99	1
1263	234	674	0.99	1
1264	234	678	0.99	1
1265	234	682	0.99	1
1266	234	686	0.99	1
1267	235	692	0.99	1
1268	235	698	0.99	1
1269	235	704	0.99	1
1270	235	710	0.99	1
1271	235	716	0.99	1
1272	235	722	0.99	1
1273	235	728	0.99	1
1274	235	734	0.99	1
1275	235	740	0.99	1
1276	236	749	0.99	1
1277	236	758	0.99	1
1278	236	767	0.99	1
1279	236	776	0.99	1
1280	236	785	0.99	1
1281	236	794	0.99	1
1282	236	803	0.99	1
1283	236	812	0.99	1
1284	236	821	0.99	1
1285	236	830	0.99	1
1286	236	839	0.99	1
1287	236	848	0.99	1
1288	236	857	0.99	1
1289	236	866	0.99	1
1290	237	880	0.99	1
1291	238	881	0.99	1
1292	238	882	0.99	1
1293	239	884	0.99	1
1294	239	886	0.99	1
1295	240	888	0.99	1
1296	240	890	0.99	1
1297	240	892	0.99	1
1298	240	894	0.99	1
1299	241	898	0.99	1
1300	241	902	0.99	1
1301	241	906	0.99	1
1302	241	910	0.99	1
1303	241	914	0.99	1
1304	241	918	0.99	1
1305	242	924	0.99	1
1306	242	930	0.99	1
1307	242	936	0.99	1
1308	242	942	0.99	1
1309	242	948	0.99	1
1310	242	954	0.99	1
1311	242	960	0.99	1
1312	242	966	0.99	1
1313	242	972	0.99	1
1314	243	981	0.99	1
1315	243	990	0.99	1
1316	243	999	0.99	1
1317	243	1008	0.99	1
1318	243	1017	0.99	1
1319	243	1026	0.99	1
1320	243	1035	0.99	1
1321	243	1044	0.99	1
1322	243	1053	0.99	1
1323	243	1062	0.99	1
1324	243	1071	0.99	1
1325	243	1080	0.99	1
1326	243	1089	0.99	1
1327	243	1098	0.99	1
1328	244	1112	0.99	1
1329	245	1113	0.99	1
1330	245	1114	0.99	1
1331	246	1116	0.99	1
1332	246	1118	0.99	1
1333	247	1120	0.99	1
1334	247	1122	0.99	1
1335	247	1124	0.99	1
1336	247	1126	0.99	1
1337	248	1130	0.99	1
1338	248	1134	0.99	1
1339	248	1138	0.99	1
1340	248	1142	0.99	1
1341	248	1146	0.99	1
1342	248	1150	0.99	1
1343	249	1156	0.99	1
1344	249	1162	0.99	1
1345	249	1168	0.99	1
1346	249	1174	0.99	1
1347	249	1180	0.99	1
1348	249	1186	0.99	1
1349	249	1192	0.99	1
1350	249	1198	0.99	1
1351	249	1204	0.99	1
1352	250	1213	0.99	1
1353	250	1222	0.99	1
1354	250	1231	0.99	1
1355	250	1240	0.99	1
1356	250	1249	0.99	1
1357	250	1258	0.99	1
1358	250	1267	0.99	1
1359	250	1276	0.99	1
1360	250	1285	0.99	1
1361	250	1294	0.99	1
1362	250	1303	0.99	1
1363	250	1312	0.99	1
1364	250	1321	0.99	1
1365	250	1330	0.99	1
1366	251	1344	0.99	1
1367	252	1345	0.99	1
1368	252	1346	0.99	1
1369	253	1348	0.99	1
1370	253	1350	0.99	1
1371	254	1352	0.99	1
1372	254	1354	0.99	1
1373	254	1356	0.99	1
1374	254	1358	0.99	1
1375	255	1362	0.99	1
1376	255	1366	0.99	1
1377	255	1370	0.99	1
1378	255	1374	0.99	1
1379	255	1378	0.99	1
1380	255	1382	0.99	1
1381	256	1388	0.99	1
1382	256	1394	0.99	1
1383	256	1400	0.99	1
1384	256	1406	0.99	1
1385	256	1412	0.99	1
1386	256	1418	0.99	1
1387	256	1424	0.99	1
1388	256	1430	0.99	1
1389	256	1436	0.99	1
1390	257	1445	0.99	1
1391	257	1454	0.99	1
1392	257	1463	0.99	1
1393	257	1472	0.99	1
1394	257	1481	0.99	1
1395	257	1490	0.99	1
1396	257	1499	0.99	1
1397	257	1508	0.99	1
1398	257	1517	0.99	1
1399	257	1526	0.99	1
1400	257	1535	0.99	1
1401	257	1544	0.99	1
1402	257	1553	0.99	1
1403	257	1562	0.99	1
1404	258	1576	0.99	1
1405	259	1577	0.99	1
1406	259	1578	0.99	1
1407	260	1580	0.99	1
1408	260	1582	0.99	1
1409	261	1584	0.99	1
1410	261	1586	0.99	1
1411	261	1588	0.99	1
1412	261	1590	0.99	1
1413	262	1594	0.99	1
1414	262	1598	0.99	1
1415	262	1602	0.99	1
1416	262	1606	0.99	1
1417	262	1610	0.99	1
1418	262	1614	0.99	1
1419	263	1620	0.99	1
1420	263	1626	0.99	1
1421	263	1632	0.99	1
1422	263	1638	0.99	1
1423	263	1644	0.99	1
1424	263	1650	0.99	1
1425	263	1656	0.99	1
1426	263	1662	0.99	1
1427	263	1668	0.99	1
1428	264	1677	0.99	1
1429	264	1686	0.99	1
1430	264	1695	0.99	1
1431	264	1704	0.99	1
1432	264	1713	0.99	1
1433	264	1722	0.99	1
1434	264	1731	0.99	1
1435	264	1740	0.99	1
1436	264	1749	0.99	1
1437	264	1758	0.99	1
1438	264	1767	0.99	1
1439	264	1776	0.99	1
1440	264	1785	0.99	1
1441	264	1794	0.99	1
1442	265	1808	0.99	1
1443	266	1809	0.99	1
1444	266	1810	0.99	1
1445	267	1812	0.99	1
1446	267	1814	0.99	1
1447	268	1816	0.99	1
1448	268	1818	0.99	1
1449	268	1820	0.99	1
1450	268	1822	0.99	1
1451	269	1826	0.99	1
1452	269	1830	0.99	1
1453	269	1834	0.99	1
1454	269	1838	0.99	1
1455	269	1842	0.99	1
1456	269	1846	0.99	1
1457	270	1852	0.99	1
1458	270	1858	0.99	1
1459	270	1864	0.99	1
1460	270	1870	0.99	1
1461	270	1876	0.99	1
1462	270	1882	0.99	1
1463	270	1888	0.99	1
1464	270	1894	0.99	1
1465	270	1900	0.99	1
1466	271	1909	0.99	1
1467	271	1918	0.99	1
1468	271	1927	0.99	1
1469	271	1936	0.99	1
1470	271	1945	0.99	1
1471	271	1954	0.99	1
1472	271	1963	0.99	1
1473	271	1972	0.99	1
1474	271	1981	0.99	1
1475	271	1990	0.99	1
1476	271	1999	0.99	1
1477	271	2008	0.99	1
1478	271	2017	0.99	1
1479	271	2026	0.99	1
1480	272	2040	0.99	1
1481	273	2041	0.99	1
1482	273	2042	0.99	1
1483	274	2044	0.99	1
1484	274	2046	0.99	1
1485	275	2048	0.99	1
1486	275	2050	0.99	1
1487	275	2052	0.99	1
1488	275	2054	0.99	1
1489	276	2058	0.99	1
1490	276	2062	0.99	1
1491	276	2066	0.99	1
1492	276	2070	0.99	1
1493	276	2074	0.99	1
1494	276	2078	0.99	1
1495	277	2084	0.99	1
1496	277	2090	0.99	1
1497	277	2096	0.99	1
1498	277	2102	0.99	1
1499	277	2108	0.99	1
1500	277	2114	0.99	1
1501	277	2120	0.99	1
1502	277	2126	0.99	1
1503	277	2132	0.99	1
1504	278	2141	0.99	1
1505	278	2150	0.99	1
1506	278	2159	0.99	1
1507	278	2168	0.99	1
1508	278	2177	0.99	1
1509	278	2186	0.99	1
1510	278	2195	0.99	1
1511	278	2204	0.99	1
1512	278	2213	0.99	1
1513	278	2222	0.99	1
1514	278	2231	0.99	1
1515	278	2240	0.99	1
1516	278	2249	0.99	1
1517	278	2258	0.99	1
1518	279	2272	0.99	1
1519	280	2273	0.99	1
1520	280	2274	0.99	1
1521	281	2276	0.99	1
1522	281	2278	0.99	1
1523	282	2280	0.99	1
1524	282	2282	0.99	1
1525	282	2284	0.99	1
1526	282	2286	0.99	1
1527	283	2290	0.99	1
1528	283	2294	0.99	1
1529	283	2298	0.99	1
1530	283	2302	0.99	1
1531	283	2306	0.99	1
1532	283	2310	0.99	1
1533	284	2316	0.99	1
1534	284	2322	0.99	1
1535	284	2328	0.99	1
1536	284	2334	0.99	1
1537	284	2340	0.99	1
1538	284	2346	0.99	1
1539	284	2352	0.99	1
1540	284	2358	0.99	1
1541	284	2364	0.99	1
1542	285	2373	0.99	1
1543	285	2382	0.99	1
1544	285	2391	0.99	1
1545	285	2400	0.99	1
1546	285	2409	0.99	1
1547	285	2418	0.99	1
1548	285	2427	0.99	1
1549	285	2436	0.99	1
1550	285	2445	0.99	1
1551	285	2454	0.99	1
1552	285	2463	0.99	1
1553	285	2472	0.99	1
1554	285	2481	0.99	1
1555	285	2490	0.99	1
1556	286	2504	0.99	1
1557	287	2505	0.99	1
1558	287	2506	0.99	1
1559	288	2508	0.99	1
1560	288	2510	0.99	1
1561	289	2512	0.99	1
1562	289	2514	0.99	1
1563	289	2516	0.99	1
1564	289	2518	0.99	1
1565	290	2522	0.99	1
1566	290	2526	0.99	1
1567	290	2530	0.99	1
1568	290	2534	0.99	1
1569	290	2538	0.99	1
1570	290	2542	0.99	1
1571	291	2548	0.99	1
1572	291	2554	0.99	1
1573	291	2560	0.99	1
1574	291	2566	0.99	1
1575	291	2572	0.99	1
1576	291	2578	0.99	1
1577	291	2584	0.99	1
1578	291	2590	0.99	1
1579	291	2596	0.99	1
1580	292	2605	0.99	1
1581	292	2614	0.99	1
1582	292	2623	0.99	1
1583	292	2632	0.99	1
1584	292	2641	0.99	1
1585	292	2650	0.99	1
1586	292	2659	0.99	1
1587	292	2668	0.99	1
1588	292	2677	0.99	1
1589	292	2686	0.99	1
1590	292	2695	0.99	1
1591	292	2704	0.99	1
1592	292	2713	0.99	1
1593	292	2722	0.99	1
1594	293	2736	0.99	1
1595	294	2737	0.99	1
1596	294	2738	0.99	1
1597	295	2740	0.99	1
1598	295	2742	0.99	1
1599	296	2744	0.99	1
1600	296	2746	0.99	1
1601	296	2748	0.99	1
1602	296	2750	0.99	1
1603	297	2754	0.99	1
1604	297	2758	0.99	1
1605	297	2762	0.99	1
1606	297	2766	0.99	1
1607	297	2770	0.99	1
1608	297	2774	0.99	1
1609	298	2780	0.99	1
1610	298	2786	0.99	1
1611	298	2792	0.99	1
1612	298	2798	0.99	1
1613	298	2804	0.99	1
1614	298	2810	0.99	1
1615	298	2816	0.99	1
1616	298	2822	1.99	1
1617	298	2828	1.99	1
1618	299	2837	1.99	1
1619	299	2846	1.99	1
1620	299	2855	1.99	1
1621	299	2864	1.99	1
1622	299	2873	1.99	1
1623	299	2882	1.99	1
1624	299	2891	1.99	1
1625	299	2900	1.99	1
1626	299	2909	1.99	1
1627	299	2918	1.99	1
1628	299	2927	0.99	1
1629	299	2936	0.99	1
1630	299	2945	0.99	1
1631	299	2954	0.99	1
1632	300	2968	0.99	1
1633	301	2969	0.99	1
1634	301	2970	0.99	1
1635	302	2972	0.99	1
1636	302	2974	0.99	1
1637	303	2976	0.99	1
1638	303	2978	0.99	1
1639	303	2980	0.99	1
1640	303	2982	0.99	1
1641	304	2986	0.99	1
1642	304	2990	0.99	1
1643	304	2994	0.99	1
1644	304	2998	0.99	1
1645	304	3002	0.99	1
1646	304	3006	0.99	1
1647	305	3012	0.99	1
1648	305	3018	0.99	1
1649	305	3024	0.99	1
1650	305	3030	0.99	1
1651	305	3036	0.99	1
1652	305	3042	0.99	1
1653	305	3048	0.99	1
1654	305	3054	0.99	1
1655	305	3060	0.99	1
1656	306	3069	0.99	1
1657	306	3078	0.99	1
1658	306	3087	0.99	1
1659	306	3096	0.99	1
1660	306	3105	0.99	1
1661	306	3114	0.99	1
1662	306	3123	0.99	1
1663	306	3132	0.99	1
1664	306	3141	0.99	1
1665	306	3150	0.99	1
1666	306	3159	0.99	1
1667	306	3168	1.99	1
1668	306	3177	1.99	1
1669	306	3186	1.99	1
1670	307	3200	1.99	1
1671	308	3201	1.99	1
1672	308	3202	1.99	1
1673	309	3204	1.99	1
1674	309	3206	1.99	1
1675	310	3208	1.99	1
1676	310	3210	1.99	1
1677	310	3212	1.99	1
1678	310	3214	1.99	1
1679	311	3218	1.99	1
1680	311	3222	1.99	1
1681	311	3226	1.99	1
1682	311	3230	1.99	1
1683	311	3234	1.99	1
1684	311	3238	1.99	1
1685	312	3244	1.99	1
1686	312	3250	1.99	1
1687	312	3256	0.99	1
1688	312	3262	0.99	1
1689	312	3268	0.99	1
1690	312	3274	0.99	1
1691	312	3280	0.99	1
1692	312	3286	0.99	1
1693	312	3292	0.99	1
1694	313	3301	0.99	1
1695	313	3310	0.99	1
1696	313	3319	0.99	1
1697	313	3328	0.99	1
1698	313	3337	1.99	1
1699	313	3346	1.99	1
1700	313	3355	0.99	1
1701	313	3364	1.99	1
1702	313	3373	0.99	1
1703	313	3382	0.99	1
1704	313	3391	0.99	1
1705	313	3400	0.99	1
1706	313	3409	0.99	1
1707	313	3418	0.99	1
1708	314	3432	0.99	1
1709	315	3433	0.99	1
1710	315	3434	0.99	1
1711	316	3436	0.99	1
1712	316	3438	0.99	1
1713	317	3440	0.99	1
1714	317	3442	0.99	1
1715	317	3444	0.99	1
1716	317	3446	0.99	1
1717	318	3450	0.99	1
1718	318	3454	0.99	1
1719	318	3458	0.99	1
1720	318	3462	0.99	1
1721	318	3466	0.99	1
1722	318	3470	0.99	1
1723	319	3476	0.99	1
1724	319	3482	0.99	1
1725	319	3488	0.99	1
1726	319	3494	0.99	1
1727	319	3500	0.99	1
1728	319	3	0.99	1
1729	319	9	0.99	1
1730	319	15	0.99	1
1731	319	21	0.99	1
1732	320	30	0.99	1
1733	320	39	0.99	1
1734	320	48	0.99	1
1735	320	57	0.99	1
1736	320	66	0.99	1
1737	320	75	0.99	1
1738	320	84	0.99	1
1739	320	93	0.99	1
1740	320	102	0.99	1
1741	320	111	0.99	1
1742	320	120	0.99	1
1743	320	129	0.99	1
1744	320	138	0.99	1
1745	320	147	0.99	1
1746	321	161	0.99	1
1747	322	162	0.99	1
1748	322	163	0.99	1
1749	323	165	0.99	1
1750	323	167	0.99	1
1751	324	169	0.99	1
1752	324	171	0.99	1
1753	324	173	0.99	1
1754	324	175	0.99	1
1755	325	179	0.99	1
1756	325	183	0.99	1
1757	325	187	0.99	1
1758	325	191	0.99	1
1759	325	195	0.99	1
1760	325	199	0.99	1
1761	326	205	0.99	1
1762	326	211	0.99	1
1763	326	217	0.99	1
1764	326	223	0.99	1
1765	326	229	0.99	1
1766	326	235	0.99	1
1767	326	241	0.99	1
1768	326	247	0.99	1
1769	326	253	0.99	1
1770	327	262	0.99	1
1771	327	271	0.99	1
1772	327	280	0.99	1
1773	327	289	0.99	1
1774	327	298	0.99	1
1775	327	307	0.99	1
1776	327	316	0.99	1
1777	327	325	0.99	1
1778	327	334	0.99	1
1779	327	343	0.99	1
1780	327	352	0.99	1
1781	327	361	0.99	1
1782	327	370	0.99	1
1783	327	379	0.99	1
1784	328	393	0.99	1
1785	329	394	0.99	1
1786	329	395	0.99	1
1787	330	397	0.99	1
1788	330	399	0.99	1
1789	331	401	0.99	1
1790	331	403	0.99	1
1791	331	405	0.99	1
1792	331	407	0.99	1
1793	332	411	0.99	1
1794	332	415	0.99	1
1795	332	419	0.99	1
1796	332	423	0.99	1
1797	332	427	0.99	1
1798	332	431	0.99	1
1799	333	437	0.99	1
1800	333	443	0.99	1
1801	333	449	0.99	1
1802	333	455	0.99	1
1803	333	461	0.99	1
1804	333	467	0.99	1
1805	333	473	0.99	1
1806	333	479	0.99	1
1807	333	485	0.99	1
1808	334	494	0.99	1
1809	334	503	0.99	1
1810	334	512	0.99	1
1811	334	521	0.99	1
1812	334	530	0.99	1
1813	334	539	0.99	1
1814	334	548	0.99	1
1815	334	557	0.99	1
1816	334	566	0.99	1
1817	334	575	0.99	1
1818	334	584	0.99	1
1819	334	593	0.99	1
1820	334	602	0.99	1
1821	334	611	0.99	1
1822	335	625	0.99	1
1823	336	626	0.99	1
1824	336	627	0.99	1
1825	337	629	0.99	1
1826	337	631	0.99	1
1827	338	633	0.99	1
1828	338	635	0.99	1
1829	338	637	0.99	1
1830	338	639	0.99	1
1831	339	643	0.99	1
1832	339	647	0.99	1
1833	339	651	0.99	1
1834	339	655	0.99	1
1835	339	659	0.99	1
1836	339	663	0.99	1
1837	340	669	0.99	1
1838	340	675	0.99	1
1839	340	681	0.99	1
1840	340	687	0.99	1
1841	340	693	0.99	1
1842	340	699	0.99	1
1843	340	705	0.99	1
1844	340	711	0.99	1
1845	340	717	0.99	1
1846	341	726	0.99	1
1847	341	735	0.99	1
1848	341	744	0.99	1
1849	341	753	0.99	1
1850	341	762	0.99	1
1851	341	771	0.99	1
1852	341	780	0.99	1
1853	341	789	0.99	1
1854	341	798	0.99	1
1855	341	807	0.99	1
1856	341	816	0.99	1
1857	341	825	0.99	1
1858	341	834	0.99	1
1859	341	843	0.99	1
1860	342	857	0.99	1
1861	343	858	0.99	1
1862	343	859	0.99	1
1863	344	861	0.99	1
1864	344	863	0.99	1
1865	345	865	0.99	1
1866	345	867	0.99	1
1867	345	869	0.99	1
1868	345	871	0.99	1
1869	346	875	0.99	1
1870	346	879	0.99	1
1871	346	883	0.99	1
1872	346	887	0.99	1
1873	346	891	0.99	1
1874	346	895	0.99	1
1875	347	901	0.99	1
1876	347	907	0.99	1
1877	347	913	0.99	1
1878	347	919	0.99	1
1879	347	925	0.99	1
1880	347	931	0.99	1
1881	347	937	0.99	1
1882	347	943	0.99	1
1883	347	949	0.99	1
1884	348	958	0.99	1
1885	348	967	0.99	1
1886	348	976	0.99	1
1887	348	985	0.99	1
1888	348	994	0.99	1
1889	348	1003	0.99	1
1890	348	1012	0.99	1
1891	348	1021	0.99	1
1892	348	1030	0.99	1
1893	348	1039	0.99	1
1894	348	1048	0.99	1
1895	348	1057	0.99	1
1896	348	1066	0.99	1
1897	348	1075	0.99	1
1898	349	1089	0.99	1
1899	350	1090	0.99	1
1900	350	1091	0.99	1
1901	351	1093	0.99	1
1902	351	1095	0.99	1
1903	352	1097	0.99	1
1904	352	1099	0.99	1
1905	352	1101	0.99	1
1906	352	1103	0.99	1
1907	353	1107	0.99	1
1908	353	1111	0.99	1
1909	353	1115	0.99	1
1910	353	1119	0.99	1
1911	353	1123	0.99	1
1912	353	1127	0.99	1
1913	354	1133	0.99	1
1914	354	1139	0.99	1
1915	354	1145	0.99	1
1916	354	1151	0.99	1
1917	354	1157	0.99	1
1918	354	1163	0.99	1
1919	354	1169	0.99	1
1920	354	1175	0.99	1
1921	354	1181	0.99	1
1922	355	1190	0.99	1
1923	355	1199	0.99	1
1924	355	1208	0.99	1
1925	355	1217	0.99	1
1926	355	1226	0.99	1
1927	355	1235	0.99	1
1928	355	1244	0.99	1
1929	355	1253	0.99	1
1930	355	1262	0.99	1
1931	355	1271	0.99	1
1932	355	1280	0.99	1
1933	355	1289	0.99	1
1934	355	1298	0.99	1
1935	355	1307	0.99	1
1936	356	1321	0.99	1
1937	357	1322	0.99	1
1938	357	1323	0.99	1
1939	358	1325	0.99	1
1940	358	1327	0.99	1
1941	359	1329	0.99	1
1942	359	1331	0.99	1
1943	359	1333	0.99	1
1944	359	1335	0.99	1
1945	360	1339	0.99	1
1946	360	1343	0.99	1
1947	360	1347	0.99	1
1948	360	1351	0.99	1
1949	360	1355	0.99	1
1950	360	1359	0.99	1
1951	361	1365	0.99	1
1952	361	1371	0.99	1
1953	361	1377	0.99	1
1954	361	1383	0.99	1
1955	361	1389	0.99	1
1956	361	1395	0.99	1
1957	361	1401	0.99	1
1958	361	1407	0.99	1
1959	361	1413	0.99	1
1960	362	1422	0.99	1
1961	362	1431	0.99	1
1962	362	1440	0.99	1
1963	362	1449	0.99	1
1964	362	1458	0.99	1
1965	362	1467	0.99	1
1966	362	1476	0.99	1
1967	362	1485	0.99	1
1968	362	1494	0.99	1
1969	362	1503	0.99	1
1970	362	1512	0.99	1
1971	362	1521	0.99	1
1972	362	1530	0.99	1
1973	362	1539	0.99	1
1974	363	1553	0.99	1
1975	364	1554	0.99	1
1976	364	1555	0.99	1
1977	365	1557	0.99	1
1978	365	1559	0.99	1
1979	366	1561	0.99	1
1980	366	1563	0.99	1
1981	366	1565	0.99	1
1982	366	1567	0.99	1
1983	367	1571	0.99	1
1984	367	1575	0.99	1
1985	367	1579	0.99	1
1986	367	1583	0.99	1
1987	367	1587	0.99	1
1988	367	1591	0.99	1
1989	368	1597	0.99	1
1990	368	1603	0.99	1
1991	368	1609	0.99	1
1992	368	1615	0.99	1
1993	368	1621	0.99	1
1994	368	1627	0.99	1
1995	368	1633	0.99	1
1996	368	1639	0.99	1
1997	368	1645	0.99	1
1998	369	1654	0.99	1
1999	369	1663	0.99	1
2000	369	1672	0.99	1
2001	369	1681	0.99	1
2002	369	1690	0.99	1
2003	369	1699	0.99	1
2004	369	1708	0.99	1
2005	369	1717	0.99	1
2006	369	1726	0.99	1
2007	369	1735	0.99	1
2008	369	1744	0.99	1
2009	369	1753	0.99	1
2010	369	1762	0.99	1
2011	369	1771	0.99	1
2012	370	1785	0.99	1
2013	371	1786	0.99	1
2014	371	1787	0.99	1
2015	372	1789	0.99	1
2016	372	1791	0.99	1
2017	373	1793	0.99	1
2018	373	1795	0.99	1
2019	373	1797	0.99	1
2020	373	1799	0.99	1
2021	374	1803	0.99	1
2022	374	1807	0.99	1
2023	374	1811	0.99	1
2024	374	1815	0.99	1
2025	374	1819	0.99	1
2026	374	1823	0.99	1
2027	375	1829	0.99	1
2028	375	1835	0.99	1
2029	375	1841	0.99	1
2030	375	1847	0.99	1
2031	375	1853	0.99	1
2032	375	1859	0.99	1
2033	375	1865	0.99	1
2034	375	1871	0.99	1
2035	375	1877	0.99	1
2036	376	1886	0.99	1
2037	376	1895	0.99	1
2038	376	1904	0.99	1
2039	376	1913	0.99	1
2040	376	1922	0.99	1
2041	376	1931	0.99	1
2042	376	1940	0.99	1
2043	376	1949	0.99	1
2044	376	1958	0.99	1
2045	376	1967	0.99	1
2046	376	1976	0.99	1
2047	376	1985	0.99	1
2048	376	1994	0.99	1
2049	376	2003	0.99	1
2050	377	2017	0.99	1
2051	378	2018	0.99	1
2052	378	2019	0.99	1
2053	379	2021	0.99	1
2054	379	2023	0.99	1
2055	380	2025	0.99	1
2056	380	2027	0.99	1
2057	380	2029	0.99	1
2058	380	2031	0.99	1
2059	381	2035	0.99	1
2060	381	2039	0.99	1
2061	381	2043	0.99	1
2062	381	2047	0.99	1
2063	381	2051	0.99	1
2064	381	2055	0.99	1
2065	382	2061	0.99	1
2066	382	2067	0.99	1
2067	382	2073	0.99	1
2068	382	2079	0.99	1
2069	382	2085	0.99	1
2070	382	2091	0.99	1
2071	382	2097	0.99	1
2072	382	2103	0.99	1
2073	382	2109	0.99	1
2074	383	2118	0.99	1
2075	383	2127	0.99	1
2076	383	2136	0.99	1
2077	383	2145	0.99	1
2078	383	2154	0.99	1
2079	383	2163	0.99	1
2080	383	2172	0.99	1
2081	383	2181	0.99	1
2082	383	2190	0.99	1
2083	383	2199	0.99	1
2084	383	2208	0.99	1
2085	383	2217	0.99	1
2086	383	2226	0.99	1
2087	383	2235	0.99	1
2088	384	2249	0.99	1
2089	385	2250	0.99	1
2090	385	2251	0.99	1
2091	386	2253	0.99	1
2092	386	2255	0.99	1
2093	387	2257	0.99	1
2094	387	2259	0.99	1
2095	387	2261	0.99	1
2096	387	2263	0.99	1
2097	388	2267	0.99	1
2098	388	2271	0.99	1
2099	388	2275	0.99	1
2100	388	2279	0.99	1
2101	388	2283	0.99	1
2102	388	2287	0.99	1
2103	389	2293	0.99	1
2104	389	2299	0.99	1
2105	389	2305	0.99	1
2106	389	2311	0.99	1
2107	389	2317	0.99	1
2108	389	2323	0.99	1
2109	389	2329	0.99	1
2110	389	2335	0.99	1
2111	389	2341	0.99	1
2112	390	2350	0.99	1
2113	390	2359	0.99	1
2114	390	2368	0.99	1
2115	390	2377	0.99	1
2116	390	2386	0.99	1
2117	390	2395	0.99	1
2118	390	2404	0.99	1
2119	390	2413	0.99	1
2120	390	2422	0.99	1
2121	390	2431	0.99	1
2122	390	2440	0.99	1
2123	390	2449	0.99	1
2124	390	2458	0.99	1
2125	390	2467	0.99	1
2126	391	2481	0.99	1
2127	392	2482	0.99	1
2128	392	2483	0.99	1
2129	393	2485	0.99	1
2130	393	2487	0.99	1
2131	394	2489	0.99	1
2132	394	2491	0.99	1
2133	394	2493	0.99	1
2134	394	2495	0.99	1
2135	395	2499	0.99	1
2136	395	2503	0.99	1
2137	395	2507	0.99	1
2138	395	2511	0.99	1
2139	395	2515	0.99	1
2140	395	2519	0.99	1
2141	396	2525	0.99	1
2142	396	2531	0.99	1
2143	396	2537	0.99	1
2144	396	2543	0.99	1
2145	396	2549	0.99	1
2146	396	2555	0.99	1
2147	396	2561	0.99	1
2148	396	2567	0.99	1
2149	396	2573	0.99	1
2150	397	2582	0.99	1
2151	397	2591	0.99	1
2152	397	2600	0.99	1
2153	397	2609	0.99	1
2154	397	2618	0.99	1
2155	397	2627	0.99	1
2156	397	2636	0.99	1
2157	397	2645	0.99	1
2158	397	2654	0.99	1
2159	397	2663	0.99	1
2160	397	2672	0.99	1
2161	397	2681	0.99	1
2162	397	2690	0.99	1
2163	397	2699	0.99	1
2164	398	2713	0.99	1
2165	399	2714	0.99	1
2166	399	2715	0.99	1
2167	400	2717	0.99	1
2168	400	2719	0.99	1
2169	401	2721	0.99	1
2170	401	2723	0.99	1
2171	401	2725	0.99	1
2172	401	2727	0.99	1
2173	402	2731	0.99	1
2174	402	2735	0.99	1
2175	402	2739	0.99	1
2176	402	2743	0.99	1
2177	402	2747	0.99	1
2178	402	2751	0.99	1
2179	403	2757	0.99	1
2180	403	2763	0.99	1
2181	403	2769	0.99	1
2182	403	2775	0.99	1
2183	403	2781	0.99	1
2184	403	2787	0.99	1
2185	403	2793	0.99	1
2186	403	2799	0.99	1
2187	403	2805	0.99	1
2188	404	2814	0.99	1
2189	404	2823	1.99	1
2190	404	2832	1.99	1
2191	404	2841	1.99	1
2192	404	2850	1.99	1
2193	404	2859	1.99	1
2194	404	2868	1.99	1
2195	404	2877	1.99	1
2196	404	2886	1.99	1
2197	404	2895	1.99	1
2198	404	2904	1.99	1
2199	404	2913	1.99	1
2200	404	2922	1.99	1
2201	404	2931	0.99	1
2202	405	2945	0.99	1
2203	406	2946	0.99	1
2204	406	2947	0.99	1
2205	407	2949	0.99	1
2206	407	2951	0.99	1
2207	408	2953	0.99	1
2208	408	2955	0.99	1
2209	408	2957	0.99	1
2210	408	2959	0.99	1
2211	409	2963	0.99	1
2212	409	2967	0.99	1
2213	409	2971	0.99	1
2214	409	2975	0.99	1
2215	409	2979	0.99	1
2216	409	2983	0.99	1
2217	410	2989	0.99	1
2218	410	2995	0.99	1
2219	410	3001	0.99	1
2220	410	3007	0.99	1
2221	410	3013	0.99	1
2222	410	3019	0.99	1
2223	410	3025	0.99	1
2224	410	3031	0.99	1
2225	410	3037	0.99	1
2226	411	3046	0.99	1
2227	411	3055	0.99	1
2228	411	3064	0.99	1
2229	411	3073	0.99	1
2230	411	3082	0.99	1
2231	411	3091	0.99	1
2232	411	3100	0.99	1
2233	411	3109	0.99	1
2234	411	3118	0.99	1
2235	411	3127	0.99	1
2236	411	3136	0.99	1
2237	411	3145	0.99	1
2238	411	3154	0.99	1
2239	411	3163	0.99	1
2240	412	3177	1.99	1
\.


--
-- Data for Name: MediaType; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MediaType" ("MediaTypeId", "Name") FROM stdin;
1	MPEG audio file
2	Protected AAC audio file
3	Protected MPEG-4 video file
4	Purchased AAC audio file
5	AAC audio file
\.


--
-- Data for Name: Playlist; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Playlist" ("PlaylistId", "Name") FROM stdin;
1	Music
2	Movies
3	TV Shows
4	Audiobooks
5	90�s Music
6	Audiobooks
7	Movies
8	Music
9	Music Videos
10	TV Shows
11	Brazilian Music
12	Classical
13	Classical 101 - Deep Cuts
14	Classical 101 - Next Steps
15	Classical 101 - The Basics
16	Grunge
17	Heavy Metal Classic
18	On-The-Go 1
\.


--
-- Data for Name: PlaylistTrack; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PlaylistTrack" ("PlaylistId", "TrackId") FROM stdin;
1	3402
1	3389
1	3390
1	3391
1	3392
1	3393
1	3394
1	3395
1	3396
1	3397
1	3398
1	3399
1	3400
1	3401
1	3336
1	3478
1	3375
1	3376
1	3377
1	3378
1	3379
1	3380
1	3381
1	3382
1	3383
1	3384
1	3385
1	3386
1	3387
1	3388
1	3365
1	3366
1	3367
1	3368
1	3369
1	3370
1	3371
1	3372
1	3373
1	3374
1	99
1	100
1	101
1	102
1	103
1	104
1	105
1	106
1	107
1	108
1	109
1	110
1	166
1	167
1	168
1	169
1	170
1	171
1	172
1	173
1	174
1	175
1	176
1	177
1	178
1	179
1	180
1	181
1	182
1	2591
1	2592
1	2593
1	2594
1	2595
1	2596
1	2597
1	2598
1	2599
1	2600
1	2601
1	2602
1	2603
1	2604
1	2605
1	2606
1	2607
1	2608
1	923
1	924
1	925
1	926
1	927
1	928
1	929
1	930
1	931
1	932
1	933
1	934
1	935
1	936
1	937
1	938
1	939
1	940
1	941
1	942
1	943
1	944
1	945
1	946
1	947
1	948
1	964
1	965
1	966
1	967
1	968
1	969
1	970
1	971
1	972
1	973
1	974
1	1009
1	1010
1	1011
1	1012
1	1013
1	1014
1	1015
1	1016
1	1017
1	1018
1	1019
1	1133
1	1134
1	1135
1	1136
1	1137
1	1138
1	1139
1	1140
1	1141
1	1142
1	1143
1	1144
1	1145
1	468
1	469
1	470
1	471
1	472
1	473
1	474
1	475
1	476
1	477
1	478
1	479
1	480
1	481
1	482
1	483
1	484
1	485
1	486
1	487
1	488
1	1466
1	1467
1	1468
1	1469
1	1470
1	1471
1	1472
1	1473
1	1474
1	1475
1	1476
1	1477
1	1478
1	529
1	530
1	531
1	532
1	533
1	534
1	535
1	536
1	537
1	538
1	539
1	540
1	541
1	542
1	2165
1	2166
1	2167
1	2168
1	2169
1	2170
1	2171
1	2172
1	2173
1	2174
1	2175
1	2176
1	2177
1	2318
1	2319
1	2320
1	2321
1	2322
1	2323
1	2324
1	2325
1	2326
1	2327
1	2328
1	2329
1	2330
1	2331
1	2332
1	2333
1	2285
1	2286
1	2287
1	2288
1	2289
1	2290
1	2291
1	2292
1	2293
1	2294
1	2295
1	2310
1	2311
1	2312
1	2313
1	2314
1	2315
1	2316
1	2317
1	2282
1	2283
1	2284
1	2334
1	2335
1	2336
1	2337
1	2338
1	2339
1	2340
1	2341
1	2342
1	2343
1	2358
1	2359
1	2360
1	2361
1	2362
1	2363
1	2364
1	2365
1	2366
1	2367
1	2368
1	2369
1	2370
1	2371
1	2372
1	2373
1	2374
1	2472
1	2473
1	2474
1	2475
1	2476
1	2477
1	2478
1	2479
1	2480
1	2481
1	2482
1	2483
1	2484
1	2485
1	2486
1	2487
1	2488
1	2489
1	2490
1	2491
1	2492
1	2493
1	2494
1	2495
1	2496
1	2497
1	2498
1	2499
1	2500
1	2501
1	2502
1	2503
1	2504
1	2505
1	2705
1	2706
1	2707
1	2708
1	2709
1	2710
1	2711
1	2712
1	2713
1	2714
1	2715
1	2716
1	2717
1	2718
1	2719
1	2720
1	2721
1	2722
1	2723
1	2724
1	2725
1	2726
1	2727
1	2728
1	2729
1	2730
1	2781
1	2782
1	2783
1	2784
1	2785
1	2786
1	2787
1	2788
1	2789
1	2790
1	2791
1	2792
1	2793
1	2794
1	2795
1	2796
1	2797
1	2798
1	2799
1	2800
1	2801
1	2802
1	2803
1	2804
1	2805
1	2806
1	2807
1	2808
1	2809
1	2810
1	2811
1	2812
1	2813
1	2814
1	2815
1	2816
1	2817
1	2818
1	2572
1	2573
1	2574
1	2575
1	2576
1	2577
1	2578
1	2579
1	2580
1	2581
1	2582
1	2583
1	2584
1	2585
1	2586
1	2587
1	2588
1	2589
1	2590
1	194
1	195
1	196
1	197
1	198
1	199
1	200
1	201
1	202
1	203
1	204
1	891
1	892
1	893
1	894
1	895
1	896
1	897
1	898
1	899
1	900
1	901
1	902
1	903
1	904
1	905
1	906
1	907
1	908
1	909
1	910
1	911
1	912
1	913
1	914
1	915
1	916
1	917
1	918
1	919
1	920
1	921
1	922
1	1268
1	1269
1	1270
1	1271
1	1272
1	1273
1	1274
1	1275
1	1276
1	2532
1	2533
1	2534
1	2535
1	2536
1	2537
1	2538
1	2539
1	2540
1	2541
1	646
1	647
1	648
1	649
1	651
1	653
1	655
1	658
1	652
1	656
1	657
1	650
1	659
1	654
1	660
1	3427
1	3411
1	3412
1	3419
1	3482
1	3438
1	3485
1	3403
1	3406
1	3442
1	3421
1	3436
1	3450
1	3454
1	3491
1	3413
1	3426
1	3416
1	3501
1	3487
1	3417
1	3432
1	3443
1	3447
1	3452
1	3441
1	3434
1	3500
1	3449
1	3405
1	3488
1	3423
1	3499
1	3445
1	3440
1	3453
1	3497
1	3494
1	3439
1	3422
1	3407
1	3495
1	3435
1	3490
1	3489
1	3448
1	3492
1	3425
1	3483
1	3420
1	3424
1	3493
1	3437
1	3498
1	3446
1	3444
1	3496
1	3502
1	3359
1	3433
1	3415
1	3479
1	3481
1	3404
1	3486
1	3414
1	3410
1	3431
1	3418
1	3430
1	3408
1	3480
1	3409
1	3484
1	1033
1	1034
1	1035
1	1036
1	1037
1	1038
1	1039
1	1040
1	1041
1	1042
1	1043
1	1044
1	1045
1	1046
1	1047
1	1048
1	1049
1	1050
1	1051
1	1052
1	1053
1	1054
1	1055
1	1056
1	3324
1	3331
1	3332
1	3322
1	3329
1	1455
1	1456
1	1457
1	1458
1	1459
1	1460
1	1461
1	1462
1	1463
1	1464
1	1465
1	3352
1	3358
1	3326
1	3327
1	3330
1	3321
1	3319
1	3328
1	3325
1	3323
1	3334
1	3333
1	3335
1	3320
1	1245
1	1246
1	1247
1	1248
1	1249
1	1250
1	1251
1	1252
1	1253
1	1254
1	1255
1	1277
1	1278
1	1279
1	1280
1	1281
1	1282
1	1283
1	1284
1	1285
1	1286
1	1287
1	1288
1	1300
1	1301
1	1302
1	1303
1	1304
1	3301
1	3300
1	3302
1	3303
1	3304
1	3305
1	3306
1	3307
1	3308
1	3309
1	3310
1	3311
1	3312
1	3313
1	3314
1	3315
1	3316
1	3317
1	3318
1	2238
1	2239
1	2240
1	2241
1	2242
1	2243
1	2244
1	2245
1	2246
1	2247
1	2248
1	2249
1	2250
1	2251
1	2252
1	2253
1	3357
1	3350
1	3349
1	63
1	64
1	65
1	66
1	67
1	68
1	69
1	70
1	71
1	72
1	73
1	74
1	75
1	76
1	123
1	124
1	125
1	126
1	127
1	128
1	129
1	130
1	842
1	843
1	844
1	845
1	846
1	847
1	848
1	849
1	850
1	624
1	625
1	626
1	627
1	628
1	629
1	630
1	631
1	632
1	633
1	634
1	635
1	636
1	637
1	638
1	639
1	640
1	641
1	642
1	643
1	644
1	645
1	1102
1	1103
1	1104
1	1188
1	1189
1	1190
1	1191
1	1192
1	1193
1	1194
1	1195
1	1196
1	1197
1	1198
1	1199
1	1200
1	597
1	598
1	599
1	600
1	601
1	602
1	603
1	604
1	605
1	606
1	607
1	608
1	609
1	610
1	611
1	612
1	613
1	614
1	615
1	616
1	617
1	618
1	619
1	1902
1	1903
1	1904
1	1905
1	1906
1	1907
1	1908
1	1909
1	1910
1	1911
1	1912
1	1913
1	1914
1	1915
1	456
1	457
1	458
1	459
1	460
1	461
1	462
1	463
1	464
1	465
1	466
1	467
1	2523
1	2524
1	2525
1	2526
1	2527
1	2528
1	2529
1	2530
1	2531
1	379
1	391
1	376
1	397
1	382
1	389
1	404
1	406
1	380
1	394
1	515
1	516
1	517
1	518
1	519
1	520
1	521
1	522
1	523
1	524
1	525
1	526
1	527
1	528
1	205
1	206
1	207
1	208
1	209
1	210
1	211
1	212
1	213
1	214
1	215
1	216
1	217
1	218
1	219
1	220
1	221
1	222
1	223
1	224
1	225
1	715
1	716
1	717
1	718
1	719
1	720
1	721
1	722
1	723
1	724
1	725
1	726
1	727
1	728
1	729
1	730
1	731
1	732
1	733
1	734
1	735
1	736
1	737
1	738
1	739
1	740
1	741
1	742
1	743
1	744
1	226
1	227
1	228
1	229
1	230
1	231
1	232
1	233
1	234
1	235
1	236
1	237
1	238
1	239
1	240
1	241
1	242
1	243
1	244
1	245
1	246
1	247
1	248
1	249
1	250
1	251
1	252
1	253
1	254
1	255
1	256
1	257
1	258
1	259
1	260
1	261
1	262
1	263
1	264
1	265
1	266
1	267
1	268
1	269
1	270
1	271
1	272
1	273
1	274
1	275
1	276
1	277
1	278
1	279
1	280
1	281
1	313
1	314
1	315
1	316
1	317
1	318
1	319
1	320
1	321
1	322
1	399
1	851
1	852
1	853
1	854
1	855
1	856
1	857
1	858
1	859
1	860
1	861
1	862
1	863
1	864
1	865
1	866
1	867
1	868
1	869
1	870
1	871
1	872
1	873
1	874
1	875
1	876
1	583
1	584
1	585
1	586
1	587
1	588
1	589
1	590
1	591
1	592
1	593
1	594
1	595
1	596
1	388
1	402
1	407
1	396
1	877
1	878
1	879
1	880
1	881
1	882
1	883
1	884
1	885
1	886
1	887
1	888
1	889
1	890
1	975
1	976
1	977
1	978
1	979
1	980
1	981
1	982
1	983
1	984
1	985
1	986
1	987
1	988
1	390
1	1057
1	1058
1	1059
1	1060
1	1061
1	1062
1	1063
1	1064
1	1065
1	1066
1	1067
1	1068
1	1069
1	1070
1	1071
1	1072
1	377
1	395
1	1087
1	1088
1	1089
1	1090
1	1091
1	1092
1	1093
1	1094
1	1095
1	1096
1	1097
1	1098
1	1099
1	1100
1	1101
1	1105
1	1106
1	1107
1	1108
1	1109
1	1110
1	1111
1	1112
1	1113
1	1114
1	1115
1	1116
1	1117
1	1118
1	1119
1	1120
1	501
1	502
1	503
1	504
1	505
1	506
1	507
1	508
1	509
1	510
1	511
1	512
1	513
1	514
1	405
1	378
1	392
1	403
1	1506
1	1507
1	1508
1	1509
1	1510
1	1511
1	1512
1	1513
1	1514
1	1515
1	1516
1	1517
1	1518
1	1519
1	381
1	1520
1	1521
1	1522
1	1523
1	1524
1	1525
1	1526
1	1527
1	1528
1	1529
1	1530
1	1531
1	400
1	1686
1	1687
1	1688
1	1689
1	1690
1	1691
1	1692
1	1693
1	1694
1	1695
1	1696
1	1697
1	1698
1	1699
1	1700
1	1701
1	1671
1	1672
1	1673
1	1674
1	1675
1	1676
1	1677
1	1678
1	1679
1	1680
1	1681
1	1682
1	1683
1	1684
1	1685
1	3356
1	384
1	1717
1	1720
1	1722
1	1723
1	1726
1	1727
1	1730
1	1731
1	1733
1	1736
1	1737
1	1740
1	1742
1	1743
1	1718
1	1719
1	1721
1	1724
1	1725
1	1728
1	1729
1	1732
1	1734
1	1735
1	1738
1	1739
1	1741
1	1744
1	374
1	1755
1	1762
1	1763
1	1756
1	1764
1	1757
1	1758
1	1765
1	1766
1	1759
1	1760
1	1767
1	1761
1	1768
1	1769
1	1770
1	1771
1	1772
1	398
1	1916
1	1917
1	1918
1	1919
1	1920
1	1921
1	1922
1	1923
1	1924
1	1925
1	1926
1	1927
1	1928
1	1929
1	1930
1	1931
1	1932
1	1933
1	1934
1	1935
1	1936
1	1937
1	1938
1	1939
1	1940
1	1941
1	375
1	385
1	383
1	387
1	2030
1	2031
1	2032
1	2033
1	2034
1	2035
1	2036
1	2037
1	2038
1	2039
1	2040
1	2041
1	2042
1	2043
1	393
1	2044
1	2045
1	2046
1	2047
1	2048
1	2049
1	2050
1	2051
1	2052
1	2053
1	2054
1	2055
1	2056
1	2057
1	2058
1	2059
1	2060
1	2061
1	2062
1	2063
1	2064
1	2065
1	2066
1	2067
1	2068
1	2069
1	2070
1	2071
1	2072
1	2073
1	2074
1	2075
1	2076
1	2077
1	2078
1	2079
1	2080
1	2081
1	2082
1	2083
1	2084
1	2085
1	2086
1	2087
1	2088
1	2089
1	2090
1	2091
1	2092
1	386
1	401
1	2751
1	2752
1	2753
1	2754
1	2755
1	2756
1	2757
1	2758
1	2759
1	2760
1	2761
1	2762
1	2763
1	2764
1	2765
1	2766
1	2767
1	2768
1	2769
1	2770
1	2771
1	2772
1	2773
1	2774
1	2775
1	2776
1	2777
1	2778
1	2779
1	2780
1	556
1	557
1	558
1	559
1	560
1	561
1	562
1	563
1	564
1	565
1	566
1	567
1	568
1	569
1	661
1	662
1	663
1	664
1	665
1	666
1	667
1	668
1	669
1	670
1	671
1	672
1	673
1	674
1	3117
1	3118
1	3119
1	3120
1	3121
1	3122
1	3123
1	3124
1	3125
1	3126
1	3127
1	3128
1	3129
1	3130
1	3131
1	3146
1	3147
1	3148
1	3149
1	3150
1	3151
1	3152
1	3153
1	3154
1	3155
1	3156
1	3157
1	3158
1	3159
1	3160
1	3161
1	3162
1	3163
1	3164
1	77
1	78
1	79
1	80
1	81
1	82
1	83
1	84
1	131
1	132
1	133
1	134
1	135
1	136
1	137
1	138
1	139
1	140
1	141
1	142
1	143
1	144
1	145
1	146
1	147
1	148
1	149
1	150
1	151
1	152
1	153
1	154
1	155
1	156
1	157
1	158
1	159
1	160
1	161
1	162
1	163
1	164
1	165
1	183
1	184
1	185
1	186
1	187
1	188
1	189
1	190
1	191
1	192
1	193
1	1121
1	1122
1	1123
1	1124
1	1125
1	1126
1	1127
1	1128
1	1129
1	1130
1	1131
1	1132
1	1174
1	1175
1	1176
1	1177
1	1178
1	1179
1	1180
1	1181
1	1182
1	1183
1	1184
1	1185
1	1186
1	1187
1	1289
1	1290
1	1291
1	1292
1	1293
1	1294
1	1295
1	1296
1	1297
1	1298
1	1299
1	1325
1	1326
1	1327
1	1328
1	1329
1	1330
1	1331
1	1332
1	1333
1	1334
1	1391
1	1388
1	1394
1	1387
1	1392
1	1389
1	1390
1	1335
1	1336
1	1337
1	1338
1	1339
1	1340
1	1341
1	1342
1	1343
1	1344
1	1345
1	1346
1	1347
1	1348
1	1349
1	1350
1	1351
1	1212
1	1213
1	1214
1	1215
1	1216
1	1217
1	1218
1	1219
1	1220
1	1221
1	1222
1	1223
1	1224
1	1225
1	1226
1	1227
1	1228
1	1229
1	1230
1	1231
1	1232
1	1233
1	1234
1	1352
1	1353
1	1354
1	1355
1	1356
1	1357
1	1358
1	1359
1	1360
1	1361
1	1364
1	1371
1	1372
1	1373
1	1374
1	1375
1	1376
1	1377
1	1378
1	1379
1	1380
1	1381
1	1382
1	1386
1	1383
1	1385
1	1384
1	1546
1	1547
1	1548
1	1549
1	1550
1	1551
1	1552
1	1553
1	1554
1	1555
1	1556
1	1557
1	1558
1	1559
1	1560
1	1561
1	1893
1	1894
1	1895
1	1896
1	1897
1	1898
1	1899
1	1900
1	1901
1	1801
1	1802
1	1803
1	1804
1	1805
1	1806
1	1807
1	1808
1	1809
1	1810
1	1811
1	1812
1	408
1	409
1	410
1	411
1	412
1	413
1	414
1	415
1	416
1	417
1	418
1	1813
1	1814
1	1815
1	1816
1	1817
1	1818
1	1819
1	1820
1	1821
1	1822
1	1823
1	1824
1	1825
1	1826
1	1827
1	1828
1	1829
1	1830
1	1831
1	1832
1	1833
1	1834
1	1835
1	1836
1	1837
1	1838
1	1839
1	1840
1	1841
1	1842
1	1843
1	1844
1	1845
1	1846
1	1847
1	1848
1	1849
1	1850
1	1851
1	1852
1	1853
1	1854
1	1855
1	1856
1	1857
1	1858
1	1859
1	1860
1	1861
1	1862
1	1863
1	1864
1	1865
1	1866
1	1867
1	1868
1	1869
1	1870
1	1871
1	1872
1	1873
1	1874
1	1875
1	1876
1	1877
1	1878
1	1879
1	1880
1	1881
1	1882
1	1883
1	1884
1	1885
1	1886
1	1887
1	1888
1	1889
1	1890
1	1891
1	1892
1	1969
1	1970
1	1971
1	1972
1	1973
1	1974
1	1975
1	1976
1	1977
1	1978
1	1979
1	1980
1	1981
1	1982
1	1983
1	1984
1	1985
1	1942
1	1943
1	1944
1	1945
1	1946
1	1947
1	1948
1	1949
1	1950
1	1951
1	1952
1	1953
1	1954
1	1955
1	1956
1	2099
1	2100
1	2101
1	2102
1	2103
1	2104
1	2105
1	2106
1	2107
1	2108
1	2109
1	2110
1	2111
1	2112
1	2554
1	2555
1	2556
1	2557
1	2558
1	2559
1	2560
1	2561
1	2562
1	2563
1	2564
1	3132
1	3133
1	3134
1	3135
1	3136
1	3137
1	3138
1	3139
1	3140
1	3141
1	3142
1	3143
1	3144
1	3145
1	3451
1	3256
1	3467
1	3468
1	3469
1	3470
1	3471
1	3472
1	3473
1	3474
1	3475
1	3476
1	3477
1	3262
1	3268
1	3263
1	3266
1	3255
1	3259
1	3260
1	3273
1	3265
1	3274
1	3267
1	3261
1	3272
1	3257
1	3258
1	3270
1	3271
1	3254
1	3275
1	3269
1	3253
1	323
1	324
1	325
1	326
1	327
1	328
1	329
1	330
1	331
1	332
1	333
1	334
1	335
1	336
1	3264
1	3455
1	3456
1	3457
1	3458
1	3459
1	3460
1	3461
1	3462
1	3463
1	3464
1	3465
1	3466
1	1414
1	1415
1	1416
1	1417
1	1418
1	1419
1	1420
1	1421
1	1422
1	1423
1	1424
1	1425
1	1426
1	1427
1	1428
1	1429
1	1430
1	1431
1	1432
1	1433
1	1444
1	1445
1	1446
1	1447
1	1448
1	1449
1	1450
1	1451
1	1452
1	1453
1	1454
1	1773
1	1774
1	1775
1	1776
1	1777
1	1778
1	1779
1	1780
1	1781
1	1782
1	1783
1	1784
1	1785
1	1786
1	1787
1	1788
1	1789
1	1790
1	282
1	283
1	284
1	285
1	286
1	287
1	288
1	289
1	290
1	291
1	292
1	293
1	294
1	295
1	296
1	297
1	298
1	299
1	300
1	301
1	302
1	303
1	304
1	305
1	306
1	307
1	308
1	309
1	310
1	311
1	312
1	2216
1	2217
1	2218
1	2219
1	2220
1	2221
1	2222
1	2223
1	2224
1	2225
1	2226
1	2227
1	2228
1	3038
1	3039
1	3040
1	3041
1	3042
1	3043
1	3044
1	3045
1	3046
1	3047
1	3048
1	3049
1	3050
1	3051
1	1
1	6
1	7
1	8
1	9
1	10
1	11
1	12
1	13
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	2
1	3
1	4
1	5
1	23
1	24
1	25
1	26
1	27
1	28
1	29
1	30
1	31
1	32
1	33
1	34
1	35
1	36
1	37
1	38
1	39
1	40
1	41
1	42
1	43
1	44
1	45
1	46
1	47
1	48
1	49
1	50
1	51
1	52
1	53
1	54
1	55
1	56
1	57
1	58
1	59
1	60
1	61
1	62
1	85
1	86
1	87
1	88
1	89
1	90
1	91
1	92
1	93
1	94
1	95
1	96
1	97
1	98
1	675
1	676
1	677
1	678
1	679
1	680
1	681
1	682
1	683
1	684
1	685
1	686
1	687
1	688
1	689
1	690
1	691
1	692
1	693
1	694
1	695
1	696
1	697
1	698
1	699
1	700
1	701
1	702
1	703
1	704
1	705
1	706
1	707
1	708
1	709
1	710
1	711
1	712
1	713
1	714
1	2609
1	2610
1	2611
1	2612
1	2613
1	2614
1	2615
1	2616
1	2617
1	2618
1	2619
1	2620
1	2621
1	2622
1	2623
1	2624
1	2625
1	2626
1	2627
1	2628
1	2629
1	2630
1	2631
1	2632
1	2633
1	2634
1	2635
1	2636
1	2637
1	2638
1	489
1	490
1	491
1	492
1	493
1	494
1	495
1	496
1	497
1	498
1	499
1	500
1	816
1	817
1	818
1	819
1	820
1	821
1	822
1	823
1	824
1	825
1	745
1	746
1	747
1	748
1	749
1	750
1	751
1	752
1	753
1	754
1	755
1	756
1	757
1	758
1	759
1	760
1	620
1	621
1	622
1	623
1	761
1	762
1	763
1	764
1	765
1	766
1	767
1	768
1	769
1	770
1	771
1	772
1	773
1	774
1	775
1	776
1	777
1	778
1	779
1	780
1	781
1	782
1	783
1	784
1	785
1	543
1	544
1	545
1	546
1	547
1	548
1	549
1	786
1	787
1	788
1	789
1	790
1	791
1	792
1	793
1	794
1	795
1	796
1	797
1	798
1	799
1	800
1	801
1	802
1	803
1	804
1	805
1	806
1	807
1	808
1	809
1	810
1	811
1	812
1	813
1	814
1	815
1	826
1	827
1	828
1	829
1	830
1	831
1	832
1	833
1	834
1	835
1	836
1	837
1	838
1	839
1	840
1	841
1	2639
1	2640
1	2641
1	2642
1	2643
1	2644
1	2645
1	2646
1	2647
1	2648
1	2649
1	3225
1	949
1	950
1	951
1	952
1	953
1	954
1	955
1	956
1	957
1	958
1	959
1	960
1	961
1	962
1	963
1	1020
1	1021
1	1022
1	1023
1	1024
1	1025
1	1026
1	1027
1	1028
1	1029
1	1030
1	1031
1	1032
1	989
1	990
1	991
1	992
1	993
1	994
1	995
1	996
1	997
1	998
1	999
1	1000
1	1001
1	1002
1	1003
1	1004
1	1005
1	1006
1	1007
1	1008
1	351
1	352
1	353
1	354
1	355
1	356
1	357
1	358
1	359
1	1146
1	1147
1	1148
1	1149
1	1150
1	1151
1	1152
1	1153
1	1154
1	1155
1	1156
1	1157
1	1158
1	1159
1	1160
1	1161
1	1162
1	1163
1	1164
1	1165
1	1166
1	1167
1	1168
1	1169
1	1170
1	1171
1	1172
1	1173
1	1235
1	1236
1	1237
1	1238
1	1239
1	1240
1	1241
1	1242
1	1243
1	1244
1	1256
1	1257
1	1258
1	1259
1	1260
1	1261
1	1262
1	1263
1	1264
1	1265
1	1266
1	1267
1	1305
1	1306
1	1307
1	1308
1	1309
1	1310
1	1311
1	1312
1	1313
1	1314
1	1315
1	1316
1	1317
1	1318
1	1319
1	1320
1	1321
1	1322
1	1323
1	1324
1	1201
1	1202
1	1203
1	1204
1	1205
1	1206
1	1207
1	1208
1	1209
1	1210
1	1211
1	1393
1	1362
1	1363
1	1365
1	1366
1	1367
1	1368
1	1369
1	1370
1	1406
1	1407
1	1408
1	1409
1	1410
1	1411
1	1412
1	1413
1	1395
1	1396
1	1397
1	1398
1	1399
1	1400
1	1401
1	1402
1	1403
1	1404
1	1405
1	1434
1	1435
1	1436
1	1437
1	1438
1	1439
1	1440
1	1441
1	1442
1	1443
1	1479
1	1480
1	1481
1	1482
1	1483
1	1484
1	1485
1	1486
1	1487
1	1488
1	1489
1	1490
1	1491
1	1492
1	1493
1	1494
1	1495
1	1496
1	1497
1	1498
1	1499
1	1500
1	1501
1	1502
1	1503
1	1504
1	1505
1	436
1	437
1	438
1	439
1	440
1	441
1	442
1	443
1	444
1	445
1	446
1	447
1	448
1	449
1	450
1	451
1	452
1	453
1	454
1	455
1	1562
1	1563
1	1564
1	1565
1	1566
1	1567
1	1568
1	1569
1	1570
1	1571
1	1572
1	1573
1	1574
1	1575
1	1576
1	337
1	338
1	339
1	340
1	341
1	342
1	343
1	344
1	345
1	346
1	347
1	348
1	349
1	350
1	1577
1	1578
1	1579
1	1580
1	1581
1	1582
1	1583
1	1584
1	1585
1	1586
1	1587
1	1588
1	1589
1	1590
1	1591
1	1592
1	1593
1	1594
1	1595
1	1596
1	1597
1	1598
1	1599
1	1600
1	1601
1	1602
1	1603
1	1604
1	1605
1	1606
1	1607
1	1608
1	1609
1	1610
1	1611
1	1612
1	1613
1	1614
1	1615
1	1616
1	1617
1	1618
1	1619
1	1620
1	1621
1	1622
1	1623
1	1624
1	1625
1	1626
1	1627
1	1628
1	1629
1	1630
1	1631
1	1632
1	1633
1	1634
1	1635
1	1636
1	1637
1	1638
1	1639
1	1640
1	1641
1	1642
1	1643
1	1644
1	1645
1	550
1	551
1	552
1	553
1	554
1	555
1	1646
1	1647
1	1648
1	1649
1	1650
1	1651
1	1652
1	1653
1	1654
1	1655
1	1656
1	1657
1	1658
1	1659
1	1660
1	1661
1	1662
1	1663
1	1664
1	1665
1	1666
1	1667
1	1668
1	1669
1	1670
1	1702
1	1703
1	1704
1	1705
1	1706
1	1707
1	1708
1	1709
1	1710
1	1711
1	1712
1	1713
1	1714
1	1715
1	1716
1	1745
1	1746
1	1747
1	1748
1	1749
1	1750
1	1751
1	1752
1	1753
1	1754
1	1791
1	1792
1	1793
1	1794
1	1795
1	1796
1	1797
1	1798
1	1799
1	1800
1	1986
1	1987
1	1988
1	1989
1	1990
1	1991
1	1992
1	1993
1	1994
1	1995
1	1996
1	1997
1	1998
1	1999
1	2000
1	2001
1	2002
1	2003
1	2004
1	2005
1	2006
1	2007
1	2008
1	2009
1	2010
1	2011
1	2012
1	2013
1	2014
1	2015
1	2016
1	2017
1	2018
1	2019
1	2020
1	2021
1	2022
1	2023
1	2024
1	2025
1	2026
1	2027
1	2028
1	2029
1	2093
1	2094
1	2095
1	2096
1	2097
1	2098
1	3276
1	3277
1	3278
1	3279
1	3280
1	3281
1	3282
1	3283
1	3284
1	3285
1	3286
1	3287
1	2113
1	2114
1	2115
1	2116
1	2117
1	2118
1	2119
1	2120
1	2121
1	2122
1	2123
1	2124
1	2139
1	2140
1	2141
1	2142
1	2143
1	2144
1	2145
1	2146
1	2147
1	2148
1	2149
1	2150
1	2151
1	2152
1	2153
1	2154
1	2155
1	2156
1	2157
1	2158
1	2159
1	2160
1	2161
1	2162
1	2163
1	2164
1	2178
1	2179
1	2180
1	2181
1	2182
1	2183
1	2184
1	2185
1	2186
1	2187
1	2188
1	2189
1	2190
1	2191
1	2192
1	2193
1	2194
1	2195
1	2196
1	2197
1	2198
1	2199
1	2200
1	2201
1	2202
1	2203
1	2204
1	2205
1	2206
1	2207
1	2208
1	2209
1	2210
1	2211
1	2212
1	2213
1	2214
1	2215
1	2229
1	2230
1	2231
1	2232
1	2233
1	2234
1	2235
1	2236
1	2237
1	2650
1	2651
1	2652
1	2653
1	2654
1	2655
1	2656
1	2657
1	2658
1	2659
1	2660
1	2661
1	2662
1	2663
1	3353
1	3355
1	2254
1	2255
1	2256
1	2257
1	2258
1	2259
1	2260
1	2261
1	2262
1	2263
1	2264
1	2265
1	2266
1	2267
1	2268
1	2269
1	2270
1	419
1	420
1	421
1	422
1	423
1	424
1	425
1	426
1	427
1	428
1	429
1	430
1	431
1	432
1	433
1	434
1	435
1	2271
1	2272
1	2273
1	2274
1	2275
1	2276
1	2277
1	2278
1	2279
1	2280
1	2281
1	2296
1	2297
1	2298
1	2299
1	2300
1	2301
1	2302
1	2303
1	2304
1	2305
1	2306
1	2307
1	2308
1	2309
1	2344
1	2345
1	2346
1	2347
1	2348
1	2349
1	2350
1	2351
1	2352
1	2353
1	2354
1	2355
1	2356
1	2357
1	2375
1	2376
1	2377
1	2378
1	2379
1	2380
1	2381
1	2382
1	2383
1	2384
1	2385
1	2386
1	2387
1	2388
1	2389
1	2390
1	2391
1	2392
1	2393
1	2394
1	2395
1	2396
1	2397
1	2398
1	2399
1	2400
1	2401
1	2402
1	2403
1	2404
1	2405
1	2664
1	2665
1	2666
1	2667
1	2668
1	2669
1	2670
1	2671
1	2672
1	2673
1	2674
1	2675
1	2676
1	2677
1	2678
1	2679
1	2680
1	2681
1	2682
1	2683
1	2684
1	2685
1	2686
1	2687
1	2688
1	2689
1	2690
1	2691
1	2692
1	2693
1	2694
1	2695
1	2696
1	2697
1	2698
1	2699
1	2700
1	2701
1	2702
1	2703
1	2704
1	2406
1	2407
1	2408
1	2409
1	2410
1	2411
1	2412
1	2413
1	2414
1	2415
1	2416
1	2417
1	2418
1	2419
1	2420
1	2421
1	2422
1	2423
1	2424
1	2425
1	2426
1	2427
1	2428
1	2429
1	2430
1	2431
1	2432
1	2433
1	570
1	573
1	577
1	580
1	581
1	571
1	579
1	582
1	572
1	575
1	578
1	574
1	576
1	3288
1	3289
1	3290
1	3291
1	3292
1	3293
1	3294
1	3295
1	3296
1	3297
1	3298
1	3299
1	2434
1	2435
1	2436
1	2437
1	2438
1	2439
1	2440
1	2441
1	2442
1	2443
1	2444
1	2445
1	2446
1	2447
1	2448
1	2449
1	2450
1	2451
1	2452
1	2453
1	2454
1	2455
1	2456
1	2457
1	2458
1	2459
1	2460
1	2461
1	2462
1	2463
1	2464
1	2465
1	2466
1	2467
1	2468
1	2469
1	2470
1	2471
1	2506
1	2507
1	2508
1	2509
1	2510
1	2511
1	2512
1	2513
1	2514
1	2515
1	2516
1	2517
1	2518
1	2519
1	2520
1	2521
1	2522
1	2542
1	2543
1	2544
1	2545
1	2546
1	2547
1	2548
1	2549
1	2550
1	2551
1	2552
1	2553
1	2565
1	2566
1	2567
1	2568
1	2569
1	2570
1	2571
1	2926
1	2927
1	2928
1	2929
1	2930
1	2931
1	2932
1	2933
1	2934
1	2935
1	2936
1	2937
1	2938
1	2939
1	2940
1	2941
1	2942
1	2943
1	2944
1	2945
1	2946
1	2947
1	2948
1	2949
1	2950
1	2951
1	2952
1	2953
1	2954
1	2955
1	2956
1	2957
1	2958
1	2959
1	2960
1	2961
1	2962
1	2963
1	3004
1	3005
1	3006
1	3007
1	3008
1	3009
1	3010
1	3011
1	3012
1	3013
1	3014
1	3015
1	3016
1	3017
1	2964
1	2965
1	2966
1	2967
1	2968
1	2969
1	2970
1	2971
1	2972
1	2973
1	2974
1	2975
1	2976
1	2977
1	2978
1	2979
1	2980
1	2981
1	2982
1	2983
1	2984
1	2985
1	2986
1	2987
1	2988
1	2989
1	2990
1	2991
1	2992
1	2993
1	2994
1	2995
1	2996
1	2997
1	2998
1	2999
1	3000
1	3001
1	3002
1	3003
1	3018
1	3019
1	3020
1	3021
1	3022
1	3023
1	3024
1	3025
1	3026
1	3027
1	3028
1	3029
1	3030
1	3031
1	3032
1	3033
1	3034
1	3035
1	3036
1	3037
1	3064
1	3065
1	3066
1	3067
1	3068
1	3069
1	3070
1	3071
1	3072
1	3073
1	3074
1	3075
1	3076
1	3077
1	3078
1	3079
1	3080
1	3052
1	3053
1	3054
1	3055
1	3056
1	3057
1	3058
1	3059
1	3060
1	3061
1	3062
1	3063
1	3081
1	3082
1	3083
1	3084
1	3085
1	3086
1	3087
1	3088
1	3089
1	3090
1	3091
1	3092
1	3093
1	3094
1	3095
1	3096
1	3097
1	3098
1	3099
1	3100
1	3101
1	3102
1	3103
1	3104
1	3105
1	3106
1	3107
1	3108
1	3109
1	3110
1	3111
1	3112
1	3113
1	3114
1	3115
1	3116
1	2731
1	2732
1	2733
1	2734
1	2735
1	2736
1	2737
1	2738
1	2739
1	2740
1	2741
1	2742
1	2743
1	2744
1	2745
1	2746
1	2747
1	2748
1	2749
1	2750
1	111
1	112
1	113
1	114
1	115
1	116
1	117
1	118
1	119
1	120
1	121
1	122
1	1073
1	1074
1	1075
1	1076
1	1077
1	1078
1	1079
1	1080
1	1081
1	1082
1	1083
1	1084
1	1085
1	1086
1	2125
1	2126
1	2127
1	2128
1	2129
1	2130
1	2131
1	2132
1	2133
1	2134
1	2135
1	2136
1	2137
1	2138
1	3503
1	360
1	361
1	362
1	363
1	364
1	365
1	366
1	367
1	368
1	369
1	370
1	371
1	372
1	373
1	3354
1	3351
1	1532
1	1533
1	1534
1	1535
1	1536
1	1537
1	1538
1	1539
1	1540
1	1541
1	1542
1	1543
1	1544
1	1545
1	1957
1	1958
1	1959
1	1960
1	1961
1	1962
1	1963
1	1964
1	1965
1	1966
1	1967
1	1968
3	3250
3	2819
3	2820
3	2821
3	2822
3	2823
3	2824
3	2825
3	2826
3	2827
3	2828
3	2829
3	2830
3	2831
3	2832
3	2833
3	2834
3	2835
3	2836
3	2837
3	2838
3	3226
3	3227
3	3228
3	3229
3	3230
3	3231
3	3232
3	3233
3	3234
3	3235
3	3236
3	3237
3	3238
3	3239
3	3240
3	3241
3	3242
3	3243
3	3244
3	3245
3	3246
3	3247
3	3248
3	3249
3	2839
3	2840
3	2841
3	2842
3	2843
3	2844
3	2845
3	2846
3	2847
3	2848
3	2849
3	2850
3	2851
3	2852
3	2853
3	2854
3	2855
3	2856
3	3166
3	3167
3	3168
3	3171
3	3223
3	2858
3	2861
3	2865
3	2868
3	2871
3	2873
3	2877
3	2880
3	2883
3	2885
3	2888
3	2893
3	2894
3	2898
3	2901
3	2904
3	2906
3	2911
3	2913
3	2915
3	2917
3	2919
3	2921
3	2923
3	2925
3	2859
3	2860
3	2864
3	2867
3	2869
3	2872
3	2878
3	2879
3	2884
3	2887
3	2889
3	2892
3	2896
3	2897
3	2902
3	2905
3	2907
3	2910
3	2914
3	2916
3	2918
3	2920
3	2922
3	2924
3	2857
3	2862
3	2863
3	2866
3	2870
3	2874
3	2875
3	2876
3	2881
3	2882
3	2886
3	2890
3	2891
3	2895
3	2899
3	2900
3	2903
3	2908
3	2909
3	2912
3	3165
3	3169
3	3170
3	3252
3	3224
3	3251
3	3340
3	3339
3	3338
3	3337
3	3341
3	3345
3	3342
3	3346
3	3343
3	3347
3	3344
3	3348
3	3360
3	3361
3	3362
3	3363
3	3364
3	3172
3	3173
3	3174
3	3175
3	3176
3	3177
3	3178
3	3179
3	3180
3	3181
3	3182
3	3183
3	3184
3	3185
3	3186
3	3187
3	3188
3	3189
3	3190
3	3191
3	3192
3	3193
3	3194
3	3195
3	3196
3	3197
3	3198
3	3199
3	3200
3	3201
3	3202
3	3203
3	3204
3	3205
3	3206
3	3428
3	3207
3	3208
3	3209
3	3210
3	3211
3	3212
3	3429
3	3213
3	3214
3	3215
3	3216
3	3217
3	3218
3	3219
3	3220
3	3221
3	3222
5	51
5	52
5	53
5	54
5	55
5	56
5	57
5	58
5	59
5	60
5	61
5	62
5	798
5	799
5	800
5	801
5	802
5	803
5	804
5	805
5	806
5	3225
5	1325
5	1326
5	1327
5	1328
5	1329
5	1330
5	1331
5	1332
5	1333
5	1334
5	1557
5	2506
5	2591
5	2592
5	2593
5	2594
5	2595
5	2596
5	2597
5	2598
5	2599
5	2600
5	2601
5	2602
5	2603
5	2604
5	2605
5	2606
5	2607
5	2608
5	2627
5	2631
5	2638
5	1158
5	1159
5	1160
5	1161
5	1162
5	1163
5	1164
5	1165
5	1166
5	1167
5	1168
5	1169
5	1170
5	1171
5	1172
5	1173
5	1174
5	1175
5	1176
5	1177
5	1178
5	1179
5	1180
5	1181
5	1182
5	1183
5	1184
5	1185
5	1186
5	1187
5	1414
5	1415
5	1416
5	1417
5	1418
5	1419
5	1420
5	1421
5	1422
5	1423
5	1424
5	1425
5	1426
5	1427
5	1428
5	1429
5	1430
5	1431
5	1432
5	1433
5	1801
5	1802
5	1803
5	1804
5	1805
5	1806
5	1807
5	1808
5	1809
5	1810
5	1811
5	1812
5	2003
5	2004
5	2005
5	2006
5	2007
5	2008
5	2009
5	2010
5	2011
5	2012
5	2013
5	2014
5	2193
5	2194
5	2195
5	2196
5	2197
5	2198
5	2199
5	2200
5	2201
5	2202
5	2203
5	424
5	428
5	430
5	434
5	2310
5	2311
5	2312
5	2313
5	2314
5	2315
5	2316
5	2317
5	2282
5	2283
5	2284
5	2358
5	2359
5	2360
5	2361
5	2362
5	2363
5	2364
5	2365
5	2366
5	2367
5	2368
5	2369
5	2370
5	2371
5	2372
5	2373
5	2374
5	2420
5	2421
5	2422
5	2423
5	2424
5	2425
5	2426
5	2427
5	2488
5	2489
5	2511
5	2512
5	2513
5	2711
5	2715
5	3365
5	3366
5	3367
5	3368
5	3369
5	3370
5	3371
5	3372
5	3373
5	3374
5	2926
5	2927
5	2928
5	2929
5	2930
5	2931
5	2932
5	2933
5	2934
5	2935
5	2936
5	2937
5	3075
5	3076
5	166
5	167
5	168
5	169
5	170
5	171
5	172
5	173
5	174
5	175
5	176
5	177
5	178
5	179
5	180
5	181
5	182
5	3426
5	2625
5	816
5	817
5	818
5	819
5	820
5	821
5	822
5	823
5	824
5	825
5	768
5	769
5	770
5	771
5	772
5	773
5	774
5	775
5	776
5	777
5	778
5	909
5	910
5	911
5	912
5	913
5	914
5	915
5	916
5	917
5	918
5	919
5	920
5	921
5	922
5	935
5	936
5	937
5	938
5	939
5	940
5	941
5	942
5	943
5	944
5	945
5	946
5	947
5	948
5	3301
5	3300
5	3302
5	3303
5	3304
5	3305
5	3306
5	3307
5	3308
5	3309
5	3310
5	3311
5	3312
5	3313
5	3314
5	3315
5	3316
5	3317
5	3318
5	1256
5	1257
5	1258
5	1259
5	1260
5	1261
5	1262
5	1263
5	1264
5	1265
5	1266
5	1267
5	2490
5	2542
5	2543
5	2544
5	2545
5	2546
5	2547
5	2548
5	2549
5	2550
5	2551
5	2552
5	2553
5	3411
5	3403
5	3423
5	1212
5	1213
5	1214
5	1215
5	1216
5	1217
5	1218
5	1219
5	1220
5	1221
5	1222
5	1223
5	1224
5	1225
5	1226
5	1227
5	1228
5	1229
5	1230
5	1231
5	1232
5	1233
5	1234
5	1434
5	1435
5	1436
5	1437
5	1438
5	1439
5	1440
5	1441
5	1442
5	1443
5	2204
5	2205
5	2206
5	2207
5	2208
5	2209
5	2210
5	2211
5	2212
5	2213
5	2214
5	2215
5	3404
5	2491
5	2492
5	2493
5	3028
5	3029
5	3030
5	3031
5	3032
5	3033
5	3034
5	3035
5	3036
5	3037
5	23
5	24
5	25
5	26
5	27
5	28
5	29
5	30
5	31
5	32
5	33
5	34
5	35
5	36
5	37
5	111
5	112
5	113
5	114
5	115
5	116
5	117
5	118
5	119
5	120
5	121
5	122
5	515
5	516
5	517
5	518
5	519
5	520
5	521
5	522
5	523
5	524
5	525
5	526
5	527
5	528
5	269
5	270
5	271
5	272
5	273
5	274
5	275
5	276
5	277
5	278
5	279
5	280
5	281
5	891
5	892
5	893
5	894
5	895
5	896
5	897
5	898
5	899
5	900
5	901
5	902
5	903
5	904
5	905
5	906
5	907
5	908
5	1105
5	1106
5	1107
5	1108
5	1109
5	1110
5	1111
5	1112
5	1113
5	1114
5	1115
5	1116
5	1117
5	1118
5	1119
5	1120
5	470
5	471
5	472
5	473
5	474
5	3424
5	2690
5	2691
5	2692
5	2693
5	2694
5	2695
5	2696
5	2697
5	2698
5	2699
5	2700
5	2701
5	2702
5	2703
5	2704
5	2494
5	2514
5	2515
5	2516
5	2517
5	3132
5	3133
5	3134
5	3135
5	3136
5	3137
5	3138
5	3139
5	3140
5	3141
5	3142
5	3143
5	3144
5	3145
5	3408
5	3
5	4
5	5
5	38
5	39
5	40
5	41
5	42
5	43
5	44
5	45
5	46
5	47
5	48
5	49
5	50
5	826
5	827
5	828
5	829
5	830
5	831
5	832
5	833
5	834
5	835
5	836
5	837
5	838
5	839
5	840
5	841
5	949
5	950
5	951
5	952
5	953
5	954
5	955
5	956
5	957
5	958
5	959
5	960
5	961
5	962
5	963
5	475
5	476
5	477
5	478
5	479
5	480
5	3354
5	3351
5	1395
5	1396
5	1397
5	1398
5	1399
5	1400
5	1401
5	1402
5	1403
5	1404
5	1405
5	1455
5	1456
5	1457
5	1458
5	1459
5	1460
5	1461
5	1462
5	1463
5	1464
5	1465
5	1520
5	1521
5	1522
5	1523
5	1524
5	1525
5	1526
5	1527
5	1528
5	1529
5	1530
5	1531
5	3276
5	3277
5	3278
5	3279
5	3280
5	3281
5	3282
5	3283
5	3284
5	3285
5	3286
5	3287
5	2125
5	2126
5	2127
5	2128
5	2129
5	2130
5	2131
5	2132
5	2133
5	2134
5	2135
5	2136
5	2137
5	2138
5	3410
5	2476
5	2484
5	2495
5	2496
5	2497
5	2498
5	2709
5	2710
5	2712
5	3038
5	3039
5	3040
5	3041
5	3042
5	3043
5	3044
5	3045
5	3046
5	3047
5	3048
5	3049
5	3050
5	3051
5	3077
5	77
5	78
5	79
5	80
5	81
5	82
5	83
5	84
5	3421
5	246
5	247
5	248
5	249
5	250
5	251
5	252
5	253
5	254
5	255
5	256
5	257
5	258
5	259
5	260
5	261
5	262
5	263
5	264
5	265
5	266
5	267
5	268
5	786
5	787
5	788
5	789
5	790
5	791
5	792
5	793
5	794
5	795
5	796
5	797
5	1562
5	1563
5	1564
5	1565
5	1566
5	1567
5	1568
5	1569
5	1570
5	1571
5	1572
5	1573
5	1574
5	1575
5	1576
5	1839
5	1840
5	1841
5	1842
5	1843
5	1844
5	1845
5	1846
5	1847
5	1848
5	1849
5	1850
5	1851
5	1852
5	1986
5	1987
5	1988
5	1989
5	1990
5	1991
5	1992
5	1993
5	1994
5	1995
5	1996
5	1997
5	1998
5	1999
5	2000
5	2001
5	2002
5	3415
5	2650
5	2651
5	2652
5	2653
5	2654
5	2655
5	2656
5	2657
5	2658
5	2659
5	2660
5	2661
5	2662
5	2663
5	2296
5	2297
5	2298
5	2299
5	2300
5	2301
5	2302
5	2303
5	2304
5	2305
5	2306
5	2307
5	2308
5	2309
5	2334
5	2335
5	2336
5	2337
5	2338
5	2339
5	2340
5	2341
5	2342
5	2343
5	2434
5	2435
5	2436
5	2437
5	2438
5	2439
5	2440
5	2441
5	2442
5	2443
5	2444
5	2445
5	2446
5	2447
5	2448
5	2461
5	2462
5	2463
5	2464
5	2465
5	2466
5	2467
5	2468
5	2469
5	2470
5	2471
5	2478
5	2518
5	2519
5	2520
5	2521
5	2522
5	456
5	457
5	458
5	459
5	460
5	461
5	462
5	463
5	464
5	465
5	466
5	467
5	3078
5	3079
5	3080
5	3416
5	923
5	924
5	925
5	926
5	927
5	928
5	929
5	930
5	931
5	932
5	933
5	934
5	1020
5	1021
5	1022
5	1023
5	1024
5	1025
5	1026
5	1027
5	1028
5	1029
5	1030
5	1031
5	1032
5	481
5	482
5	483
5	484
5	1188
5	1189
5	1190
5	1191
5	1192
5	1193
5	1194
5	1195
5	1196
5	1197
5	1198
5	1199
5	1200
5	436
5	437
5	438
5	439
5	440
5	441
5	442
5	443
5	444
5	445
5	446
5	447
5	448
5	449
5	450
5	451
5	453
5	454
5	455
5	337
5	338
5	339
5	340
5	341
5	342
5	343
5	344
5	345
5	346
5	347
5	348
5	349
5	350
5	1577
5	1578
5	1579
5	1580
5	1581
5	1582
5	1583
5	1584
5	1585
5	1586
5	1861
5	1862
5	1863
5	1864
5	1865
5	1866
5	1867
5	1868
5	1869
5	1870
5	1871
5	1872
5	1873
5	3359
5	2406
5	2407
5	2408
5	2409
5	2410
5	2411
5	2412
5	2413
5	2414
5	2415
5	2416
5	2417
5	2418
5	2419
5	2499
5	2706
5	2708
5	2713
5	2716
5	2720
5	2721
5	2722
5	2723
5	2724
5	2725
5	2726
5	2727
5	2728
5	2729
5	2730
5	2565
5	2566
5	2567
5	2568
5	2569
5	2570
5	2571
5	2781
5	2782
5	2783
5	2784
5	2785
5	2786
5	2787
5	2788
5	2789
5	2790
5	2791
5	2792
5	2793
5	2794
5	2795
5	2796
5	2797
5	2798
5	2799
5	2800
5	2801
5	2802
5	2975
5	2976
5	2977
5	2978
5	2979
5	2980
5	2981
5	2982
5	2983
5	2984
5	2985
5	2986
5	183
5	184
5	185
5	186
5	187
5	188
5	189
5	190
5	191
5	192
5	193
5	205
5	206
5	207
5	208
5	209
5	210
5	211
5	212
5	213
5	214
5	215
5	216
5	217
5	218
5	219
5	220
5	221
5	222
5	3417
5	583
5	584
5	585
5	586
5	587
5	588
5	589
5	590
5	591
5	592
5	593
5	594
5	595
5	596
5	976
5	977
5	978
5	979
5	984
5	1087
5	1088
5	1089
5	1090
5	1091
5	1092
5	1093
5	1094
5	1095
5	1096
5	1097
5	1098
5	1099
5	1100
5	1101
5	1305
5	1306
5	1307
5	1308
5	1309
5	1310
5	1311
5	1312
5	1313
5	1314
5	1315
5	1316
5	1317
5	1318
5	1319
5	1320
5	1321
5	1322
5	1323
5	1324
5	1406
5	1407
5	1408
5	1409
5	1410
5	1411
5	1412
5	1413
5	1686
5	1687
5	1688
5	1689
5	1690
5	1691
5	1692
5	1693
5	1694
5	1695
5	1696
5	1697
5	1698
5	1699
5	1700
5	1701
5	408
5	409
5	410
5	411
5	412
5	413
5	414
5	415
5	416
5	417
5	418
5	1813
5	1814
5	1815
5	1816
5	1817
5	1818
5	1819
5	1820
5	1821
5	1822
5	1823
5	1824
5	1825
5	1826
5	1827
5	1828
5	1969
5	1970
5	1971
5	1972
5	1973
5	1974
5	1975
5	1976
5	1977
5	1978
5	1979
5	1980
5	1981
5	1982
5	1983
5	1984
5	1985
5	2113
5	2114
5	2115
5	2116
5	2117
5	2118
5	2119
5	2120
5	2121
5	2122
5	2123
5	2124
5	2149
5	2150
5	2151
5	2152
5	2153
5	2154
5	2155
5	2156
5	2157
5	2158
5	2159
5	2160
5	2161
5	2162
5	2163
5	2164
5	2676
5	2677
5	2678
5	2679
5	2680
5	2681
5	2682
5	2683
5	2684
5	2685
5	2686
5	2687
5	2688
5	2689
5	3418
5	2500
5	2501
5	2803
5	2804
5	2805
5	2806
5	2807
5	2808
5	2809
5	2810
5	2811
5	2812
5	2813
5	2814
5	2815
5	2816
5	2817
5	2818
5	2949
5	2950
5	2951
5	2952
5	2953
5	2954
5	2955
5	2956
5	2957
5	2958
5	2959
5	2960
5	2961
5	2962
5	2963
5	3004
5	3005
5	3006
5	3007
5	3008
5	3009
5	3010
5	3011
5	3012
5	3013
5	3014
5	3015
5	3016
5	3017
5	3092
5	3093
5	3094
5	3095
5	3096
5	3097
5	3098
5	3099
5	3100
5	3101
5	3102
5	3103
5	3409
5	299
5	300
5	301
5	302
5	303
5	304
5	305
5	306
5	307
5	308
5	309
5	310
5	311
5	312
5	851
5	852
5	853
5	854
5	855
5	856
5	857
5	858
5	859
5	860
5	861
5	862
5	863
5	864
5	865
5	866
5	867
5	868
5	869
5	870
5	871
5	872
5	873
5	874
5	875
5	876
5	1057
5	1058
5	1059
5	1060
5	1061
5	1062
5	1063
5	1064
5	1065
5	1066
5	1067
5	1068
5	1069
5	1070
5	1071
5	1072
5	501
5	502
5	503
5	504
5	505
5	506
5	507
5	508
5	509
5	510
5	511
5	512
5	513
5	514
5	1444
5	1445
5	1446
5	1447
5	1448
5	1449
5	1450
5	1451
5	1452
5	1453
5	1454
5	1496
5	1497
5	1498
5	1499
5	1500
5	1501
5	1502
5	1503
5	1504
5	1505
5	1671
5	1672
5	1673
5	1674
5	1675
5	1676
5	1677
5	1678
5	1679
5	1680
5	1681
5	1682
5	1683
5	1684
5	1685
5	2044
5	2045
5	2046
5	2047
5	2048
5	2049
5	2050
5	2051
5	2052
5	2053
5	2054
5	2055
5	2056
5	2057
5	2058
5	2059
5	2060
5	2061
5	2062
5	2063
5	2064
5	2238
5	2239
5	2240
5	2241
5	2242
5	2243
5	2244
5	2245
5	2246
5	2247
5	2248
5	2249
5	2250
5	2251
5	2252
5	2253
5	2391
5	2392
5	2393
5	2394
5	2395
5	2396
5	2397
5	2398
5	2399
5	2400
5	2401
5	2402
5	2403
5	2404
5	2405
5	570
5	573
5	577
5	580
5	581
5	571
5	579
5	582
5	572
5	575
5	578
5	574
5	576
5	2707
5	2714
5	2717
5	2718
5	3146
5	3147
5	3148
5	3149
5	3150
5	3151
5	3152
5	3153
5	3154
5	3155
5	3156
5	3157
5	3158
5	3159
5	3160
5	3161
5	3162
5	3163
5	3164
5	3438
5	3442
5	3436
5	3454
5	3432
5	3447
5	3434
5	3449
5	3445
5	3439
5	3435
5	3448
5	3437
5	3446
5	3444
5	3451
5	3430
5	3482
5	3485
5	3499
5	3490
5	3489
5	3492
5	3493
5	3498
5	3481
5	3503
8	3427
8	3357
8	1
8	6
8	7
8	8
8	9
8	10
8	11
8	12
8	13
8	14
8	15
8	16
8	17
8	18
8	19
8	20
8	21
8	22
8	3411
8	3412
8	3419
8	2
8	3
8	4
8	5
8	23
8	24
8	25
8	26
8	27
8	28
8	29
8	30
8	31
8	32
8	33
8	34
8	35
8	36
8	37
8	3256
8	3350
8	3349
8	38
8	39
8	40
8	41
8	42
8	43
8	44
8	45
8	46
8	47
8	48
8	49
8	50
8	3403
8	51
8	52
8	53
8	54
8	55
8	56
8	57
8	58
8	59
8	60
8	61
8	62
8	3406
8	379
8	391
8	63
8	64
8	65
8	66
8	67
8	68
8	69
8	70
8	71
8	72
8	73
8	74
8	75
8	76
8	77
8	78
8	79
8	80
8	81
8	82
8	83
8	84
8	85
8	86
8	87
8	88
8	89
8	90
8	91
8	92
8	93
8	94
8	95
8	96
8	97
8	98
8	99
8	100
8	101
8	102
8	103
8	104
8	105
8	106
8	107
8	108
8	109
8	110
8	3402
8	3389
8	3390
8	3391
8	3392
8	3393
8	3394
8	3395
8	3396
8	3397
8	3398
8	3399
8	3400
8	3401
8	3262
8	376
8	397
8	382
8	111
8	112
8	113
8	114
8	115
8	116
8	117
8	118
8	119
8	120
8	121
8	122
8	389
8	404
8	406
8	3421
8	380
8	394
8	3268
8	3413
8	3263
8	123
8	124
8	125
8	126
8	127
8	128
8	129
8	130
8	2572
8	2573
8	2574
8	2575
8	2576
8	2577
8	2578
8	2579
8	2580
8	2581
8	2582
8	2583
8	2584
8	2585
8	2586
8	2587
8	2588
8	2589
8	2590
8	3266
8	131
8	132
8	133
8	134
8	135
8	136
8	137
8	138
8	139
8	140
8	141
8	142
8	143
8	144
8	145
8	146
8	147
8	148
8	149
8	150
8	151
8	152
8	153
8	154
8	155
8	156
8	157
8	158
8	159
8	160
8	161
8	162
8	163
8	164
8	165
8	166
8	167
8	168
8	169
8	170
8	171
8	172
8	173
8	174
8	175
8	176
8	177
8	178
8	179
8	180
8	181
8	182
8	3426
8	3416
8	183
8	184
8	185
8	186
8	187
8	188
8	189
8	190
8	191
8	192
8	193
8	194
8	195
8	196
8	197
8	198
8	199
8	200
8	201
8	202
8	203
8	204
8	515
8	516
8	517
8	518
8	519
8	520
8	521
8	522
8	523
8	524
8	525
8	526
8	527
8	528
8	205
8	206
8	207
8	208
8	209
8	210
8	211
8	212
8	213
8	214
8	215
8	216
8	217
8	218
8	219
8	220
8	221
8	222
8	223
8	224
8	225
8	3336
8	715
8	716
8	717
8	718
8	719
8	720
8	721
8	722
8	723
8	724
8	725
8	726
8	727
8	728
8	729
8	730
8	731
8	732
8	733
8	734
8	735
8	736
8	737
8	738
8	739
8	740
8	741
8	742
8	743
8	744
8	3324
8	3417
8	226
8	227
8	228
8	229
8	230
8	231
8	232
8	233
8	234
8	235
8	236
8	237
8	238
8	239
8	240
8	241
8	242
8	243
8	244
8	245
8	246
8	247
8	248
8	249
8	250
8	251
8	252
8	253
8	254
8	255
8	256
8	257
8	258
8	259
8	260
8	261
8	262
8	263
8	264
8	265
8	266
8	267
8	268
8	269
8	270
8	271
8	272
8	273
8	274
8	275
8	276
8	277
8	278
8	279
8	280
8	281
8	3375
8	3376
8	3377
8	3378
8	3379
8	3380
8	3381
8	3382
8	3383
8	3384
8	3385
8	3386
8	3387
8	3388
8	3255
8	282
8	283
8	284
8	285
8	286
8	287
8	288
8	289
8	290
8	291
8	292
8	293
8	294
8	295
8	296
8	297
8	298
8	299
8	300
8	301
8	302
8	303
8	304
8	305
8	306
8	307
8	308
8	309
8	310
8	311
8	312
8	2591
8	2592
8	2593
8	2594
8	2595
8	2596
8	2597
8	2598
8	2599
8	2600
8	2601
8	2602
8	2603
8	2604
8	2605
8	2606
8	2607
8	2608
8	313
8	314
8	315
8	316
8	317
8	318
8	319
8	320
8	321
8	322
8	399
8	3259
8	675
8	676
8	677
8	678
8	679
8	680
8	681
8	682
8	683
8	684
8	685
8	686
8	687
8	688
8	689
8	690
8	691
8	692
8	693
8	694
8	695
8	696
8	697
8	698
8	699
8	700
8	701
8	702
8	703
8	704
8	705
8	706
8	707
8	708
8	709
8	710
8	711
8	712
8	713
8	714
8	2609
8	2610
8	2611
8	2612
8	2613
8	2614
8	2615
8	2616
8	2617
8	2618
8	2619
8	2620
8	2621
8	2622
8	2623
8	2624
8	2625
8	2626
8	2627
8	2628
8	2629
8	2630
8	2631
8	2632
8	2633
8	2634
8	2635
8	2636
8	2637
8	2638
8	489
8	490
8	491
8	492
8	493
8	494
8	495
8	496
8	497
8	498
8	499
8	500
8	816
8	817
8	818
8	819
8	820
8	821
8	822
8	823
8	824
8	825
8	745
8	746
8	747
8	748
8	749
8	750
8	751
8	752
8	753
8	754
8	755
8	756
8	757
8	758
8	759
8	760
8	620
8	621
8	622
8	623
8	761
8	762
8	763
8	764
8	765
8	766
8	767
8	768
8	769
8	770
8	771
8	772
8	773
8	774
8	775
8	776
8	777
8	778
8	779
8	780
8	781
8	782
8	783
8	784
8	785
8	543
8	544
8	545
8	546
8	547
8	548
8	549
8	786
8	787
8	788
8	789
8	790
8	791
8	792
8	793
8	794
8	795
8	796
8	797
8	798
8	799
8	800
8	801
8	802
8	803
8	804
8	805
8	806
8	807
8	808
8	809
8	810
8	811
8	812
8	813
8	814
8	815
8	826
8	827
8	828
8	829
8	830
8	831
8	832
8	833
8	834
8	835
8	836
8	837
8	838
8	839
8	840
8	841
8	842
8	843
8	844
8	845
8	846
8	847
8	848
8	849
8	850
8	3260
8	3331
8	851
8	852
8	853
8	854
8	855
8	856
8	857
8	858
8	859
8	860
8	861
8	862
8	863
8	864
8	865
8	866
8	867
8	868
8	869
8	870
8	871
8	872
8	873
8	874
8	875
8	876
8	2639
8	2640
8	2641
8	2642
8	2643
8	2644
8	2645
8	2646
8	2647
8	2648
8	2649
8	3225
8	583
8	584
8	585
8	586
8	587
8	588
8	589
8	590
8	591
8	592
8	593
8	594
8	595
8	596
8	388
8	402
8	407
8	396
8	877
8	878
8	879
8	880
8	881
8	882
8	883
8	884
8	885
8	886
8	887
8	888
8	889
8	890
8	3405
8	891
8	892
8	893
8	894
8	895
8	896
8	897
8	898
8	899
8	900
8	901
8	902
8	903
8	904
8	905
8	906
8	907
8	908
8	909
8	910
8	911
8	912
8	913
8	914
8	915
8	916
8	917
8	918
8	919
8	920
8	921
8	922
8	3423
8	923
8	924
8	925
8	926
8	927
8	928
8	929
8	930
8	931
8	932
8	933
8	934
8	935
8	936
8	937
8	938
8	939
8	940
8	941
8	942
8	943
8	944
8	945
8	946
8	947
8	948
8	949
8	950
8	951
8	952
8	953
8	954
8	955
8	956
8	957
8	958
8	959
8	960
8	961
8	962
8	963
8	964
8	965
8	966
8	967
8	968
8	969
8	970
8	971
8	972
8	973
8	974
8	975
8	976
8	977
8	978
8	979
8	980
8	981
8	982
8	983
8	984
8	985
8	986
8	987
8	988
8	390
8	3273
8	1020
8	1021
8	1022
8	1023
8	1024
8	1025
8	1026
8	1027
8	1028
8	1029
8	1030
8	1031
8	1032
8	989
8	990
8	991
8	992
8	993
8	994
8	995
8	996
8	997
8	998
8	999
8	1000
8	1001
8	1002
8	1003
8	1004
8	1005
8	1006
8	1007
8	1008
8	1009
8	1010
8	1011
8	1012
8	1013
8	1014
8	1015
8	1016
8	1017
8	1018
8	1019
8	1033
8	1034
8	1035
8	1036
8	1037
8	1038
8	1039
8	1040
8	1041
8	1042
8	1043
8	1044
8	1045
8	1046
8	1047
8	1048
8	1049
8	1050
8	1051
8	1052
8	1053
8	1054
8	1055
8	1056
8	351
8	352
8	353
8	354
8	355
8	356
8	357
8	358
8	359
8	3332
8	1057
8	1058
8	1059
8	1060
8	1061
8	1062
8	1063
8	1064
8	1065
8	1066
8	1067
8	1068
8	1069
8	1070
8	1071
8	1072
8	624
8	625
8	626
8	627
8	628
8	629
8	630
8	631
8	632
8	633
8	634
8	635
8	636
8	637
8	638
8	639
8	640
8	641
8	642
8	643
8	644
8	645
8	1073
8	1074
8	1075
8	1076
8	1077
8	1078
8	1079
8	1080
8	1081
8	1082
8	1083
8	1084
8	1085
8	1086
8	377
8	395
8	1102
8	1103
8	1104
8	1087
8	1088
8	1089
8	1090
8	1091
8	1092
8	1093
8	1094
8	1095
8	1096
8	1097
8	1098
8	1099
8	1100
8	1101
8	1105
8	1106
8	1107
8	1108
8	1109
8	1110
8	1111
8	1112
8	1113
8	1114
8	1115
8	1116
8	1117
8	1118
8	1119
8	1120
8	1121
8	1122
8	1123
8	1124
8	1125
8	1126
8	1127
8	1128
8	1129
8	1130
8	1131
8	1132
8	501
8	502
8	503
8	504
8	505
8	506
8	507
8	508
8	509
8	510
8	511
8	512
8	513
8	514
8	1133
8	1134
8	1135
8	1136
8	1137
8	1138
8	1139
8	1140
8	1141
8	1142
8	1143
8	1144
8	1145
8	3265
8	468
8	469
8	470
8	471
8	472
8	473
8	474
8	475
8	476
8	477
8	478
8	479
8	480
8	481
8	482
8	483
8	484
8	485
8	486
8	487
8	488
8	1146
8	1147
8	1148
8	1149
8	1150
8	1151
8	1152
8	1153
8	1154
8	1155
8	1156
8	1157
8	1158
8	1159
8	1160
8	1161
8	1162
8	1163
8	1164
8	1165
8	1166
8	1167
8	1168
8	1169
8	1170
8	1171
8	1172
8	1173
8	1174
8	1175
8	1176
8	1177
8	1178
8	1179
8	1180
8	1181
8	1182
8	1183
8	1184
8	1185
8	1186
8	1187
8	3322
8	3354
8	3351
8	3422
8	405
8	3407
8	3301
8	3300
8	3302
8	3303
8	3304
8	3305
8	3306
8	3307
8	3308
8	3309
8	3310
8	3311
8	3312
8	3313
8	3314
8	3315
8	3316
8	3317
8	3318
8	1188
8	1189
8	1190
8	1191
8	1192
8	1193
8	1194
8	1195
8	1196
8	1197
8	1198
8	1199
8	1200
8	3329
8	1235
8	1236
8	1237
8	1238
8	1239
8	1240
8	1241
8	1242
8	1243
8	1244
8	1245
8	1246
8	1247
8	1248
8	1249
8	1250
8	1251
8	1252
8	1253
8	1254
8	1255
8	1256
8	1257
8	1258
8	1259
8	1260
8	1261
8	1262
8	1263
8	1264
8	1265
8	1266
8	1267
8	1268
8	1269
8	1270
8	1271
8	1272
8	1273
8	1274
8	1275
8	1276
8	1277
8	1278
8	1279
8	1280
8	1281
8	1282
8	1283
8	1284
8	1285
8	1286
8	1287
8	1288
8	1289
8	1290
8	1291
8	1292
8	1293
8	1294
8	1295
8	1296
8	1297
8	1298
8	1299
8	1300
8	1301
8	1302
8	1303
8	1304
8	1305
8	1306
8	1307
8	1308
8	1309
8	1310
8	1311
8	1312
8	1313
8	1314
8	1315
8	1316
8	1317
8	1318
8	1319
8	1320
8	1321
8	1322
8	1323
8	1324
8	1201
8	1202
8	1203
8	1204
8	1205
8	1206
8	1207
8	1208
8	1209
8	1210
8	1211
8	1325
8	1326
8	1327
8	1328
8	1329
8	1330
8	1331
8	1332
8	1333
8	1334
8	1391
8	1393
8	1388
8	1394
8	1387
8	1392
8	1389
8	1390
8	1335
8	1336
8	1337
8	1338
8	1339
8	1340
8	1341
8	1342
8	1343
8	1344
8	1345
8	1346
8	1347
8	1348
8	1349
8	1350
8	1351
8	1212
8	1213
8	1214
8	1215
8	1216
8	1217
8	1218
8	1219
8	1220
8	1221
8	1222
8	1223
8	1224
8	1225
8	1226
8	1227
8	1228
8	1229
8	1230
8	1231
8	1232
8	1233
8	1234
8	1352
8	1353
8	1354
8	1355
8	1356
8	1357
8	1358
8	1359
8	1360
8	1361
8	1362
8	1363
8	1364
8	1365
8	1366
8	1367
8	1368
8	1369
8	1370
8	1371
8	1372
8	1373
8	1374
8	1375
8	1376
8	1377
8	1378
8	1379
8	1380
8	1381
8	1382
8	1386
8	1383
8	1385
8	1384
8	1406
8	1407
8	1408
8	1409
8	1410
8	1411
8	1412
8	1413
8	1395
8	1396
8	1397
8	1398
8	1399
8	1400
8	1401
8	1402
8	1403
8	1404
8	1405
8	3274
8	3267
8	3261
8	3272
8	1414
8	1415
8	1416
8	1417
8	1418
8	1419
8	1420
8	1421
8	1422
8	1423
8	1424
8	1425
8	1426
8	1427
8	1428
8	1429
8	1430
8	1431
8	1432
8	1433
8	1434
8	1435
8	1436
8	1437
8	1438
8	1439
8	1440
8	1441
8	1442
8	1443
8	1455
8	1456
8	1457
8	1458
8	1459
8	1460
8	1461
8	1462
8	1463
8	1464
8	1465
8	1444
8	1445
8	1446
8	1447
8	1448
8	1449
8	1450
8	1451
8	1452
8	1453
8	1454
8	1466
8	1467
8	1468
8	1469
8	1470
8	1471
8	1472
8	1473
8	1474
8	1475
8	1476
8	1477
8	1478
8	1479
8	1480
8	1481
8	1482
8	1483
8	1484
8	1485
8	1486
8	1487
8	1488
8	1489
8	1490
8	1491
8	1492
8	1493
8	1494
8	1495
8	378
8	392
8	1532
8	1533
8	1534
8	1535
8	1536
8	1537
8	1538
8	1539
8	1540
8	1541
8	1542
8	1543
8	1544
8	1545
8	1496
8	1497
8	1498
8	1499
8	1500
8	1501
8	1502
8	1503
8	1504
8	1505
8	403
8	1506
8	1507
8	1508
8	1509
8	1510
8	1511
8	1512
8	1513
8	1514
8	1515
8	1516
8	1517
8	1518
8	1519
8	381
8	1520
8	1521
8	1522
8	1523
8	1524
8	1525
8	1526
8	1527
8	1528
8	1529
8	1530
8	1531
8	1546
8	1547
8	1548
8	1549
8	1550
8	1551
8	1552
8	1553
8	1554
8	1555
8	1556
8	1557
8	1558
8	1559
8	1560
8	1561
8	3352
8	3358
8	400
8	436
8	437
8	438
8	439
8	440
8	441
8	442
8	443
8	444
8	445
8	446
8	447
8	448
8	449
8	450
8	451
8	452
8	453
8	454
8	455
8	1562
8	1563
8	1564
8	1565
8	1566
8	1567
8	1568
8	1569
8	1570
8	1571
8	1572
8	1573
8	1574
8	1575
8	1576
8	337
8	338
8	339
8	340
8	341
8	342
8	343
8	344
8	345
8	346
8	347
8	348
8	349
8	350
8	1577
8	1578
8	1579
8	1580
8	1581
8	1582
8	1583
8	1584
8	1585
8	1586
8	1587
8	1588
8	1589
8	1590
8	1591
8	1592
8	1593
8	1594
8	1595
8	1596
8	1597
8	1598
8	1599
8	1600
8	1601
8	1602
8	1603
8	1604
8	1605
8	1606
8	1607
8	1608
8	1609
8	1610
8	1611
8	1612
8	1613
8	1614
8	1615
8	1616
8	1617
8	1618
8	1619
8	1620
8	1621
8	1622
8	1623
8	1624
8	1625
8	1626
8	1627
8	1628
8	1629
8	1630
8	1631
8	1632
8	1633
8	1634
8	1635
8	1636
8	1637
8	1638
8	1639
8	1640
8	1641
8	1642
8	1643
8	1644
8	1645
8	550
8	551
8	552
8	553
8	554
8	555
8	1646
8	1647
8	1648
8	1649
8	1650
8	1651
8	1652
8	1653
8	1654
8	1655
8	1656
8	1657
8	1658
8	1659
8	1660
8	1661
8	1662
8	1663
8	1664
8	1665
8	1666
8	1667
8	1668
8	1669
8	1670
8	1686
8	1687
8	1688
8	1689
8	1690
8	1691
8	1692
8	1693
8	1694
8	1695
8	1696
8	1697
8	1698
8	1699
8	1700
8	1701
8	1671
8	1672
8	1673
8	1674
8	1675
8	1676
8	1677
8	1678
8	1679
8	1680
8	1681
8	1682
8	1683
8	1684
8	1685
8	1702
8	1703
8	1704
8	1705
8	1706
8	1707
8	1708
8	1709
8	1710
8	1711
8	1712
8	1713
8	1714
8	1715
8	1716
8	3257
8	3425
8	3420
8	3326
8	3258
8	3356
8	3424
8	384
8	1717
8	1720
8	1722
8	1723
8	1726
8	1727
8	1730
8	1731
8	1733
8	1736
8	1737
8	1740
8	1742
8	1743
8	1718
8	1719
8	1721
8	1724
8	1725
8	1728
8	1729
8	1732
8	1734
8	1735
8	1738
8	1739
8	1741
8	1744
8	374
8	1745
8	1746
8	1747
8	1748
8	1749
8	1750
8	1751
8	1752
8	1753
8	1754
8	1755
8	1762
8	1763
8	1756
8	1764
8	1757
8	1758
8	1765
8	1766
8	1759
8	1760
8	1767
8	1761
8	1768
8	1769
8	1770
8	1771
8	1772
8	1773
8	1774
8	1775
8	1776
8	1777
8	1778
8	1779
8	1780
8	1781
8	1782
8	1783
8	1784
8	1785
8	1786
8	1787
8	1788
8	1789
8	1790
8	3270
8	1791
8	1792
8	1793
8	1794
8	1795
8	1796
8	1797
8	1798
8	1799
8	1800
8	1893
8	1894
8	1895
8	1896
8	1897
8	1898
8	1899
8	1900
8	1901
8	1801
8	1802
8	1803
8	1804
8	1805
8	1806
8	1807
8	1808
8	1809
8	1810
8	1811
8	1812
8	408
8	409
8	410
8	411
8	412
8	413
8	414
8	415
8	416
8	417
8	418
8	1813
8	1814
8	1815
8	1816
8	1817
8	1818
8	1819
8	1820
8	1821
8	1822
8	1823
8	1824
8	1825
8	1826
8	1827
8	1828
8	1829
8	1830
8	1831
8	1832
8	1833
8	1834
8	1835
8	1836
8	1837
8	1838
8	1839
8	1840
8	1841
8	1842
8	1843
8	1844
8	1845
8	1846
8	1847
8	1848
8	1849
8	1850
8	1851
8	1852
8	1853
8	1854
8	1855
8	1856
8	1857
8	1858
8	1859
8	1860
8	1861
8	1862
8	1863
8	1864
8	1865
8	1866
8	1867
8	1868
8	1869
8	1870
8	1871
8	1872
8	1873
8	1874
8	1875
8	1876
8	1877
8	1878
8	1879
8	1880
8	1881
8	1882
8	1883
8	1884
8	1885
8	1886
8	1887
8	1888
8	1889
8	1890
8	1891
8	1892
8	597
8	598
8	599
8	600
8	601
8	602
8	603
8	604
8	605
8	606
8	607
8	608
8	609
8	610
8	611
8	612
8	613
8	614
8	615
8	616
8	617
8	618
8	619
8	1902
8	1903
8	1904
8	1905
8	1906
8	1907
8	1908
8	1909
8	1910
8	1911
8	1912
8	1913
8	1914
8	1915
8	398
8	1916
8	1917
8	1918
8	1919
8	1920
8	1921
8	1922
8	1923
8	1924
8	1925
8	1926
8	1927
8	1928
8	1929
8	1930
8	1931
8	1932
8	1933
8	1934
8	1935
8	1936
8	1937
8	1938
8	1939
8	1940
8	1941
8	375
8	1957
8	1958
8	1959
8	1960
8	1961
8	1962
8	1963
8	1964
8	1965
8	1966
8	1967
8	1968
8	1969
8	1970
8	1971
8	1972
8	1973
8	1974
8	1975
8	1976
8	1977
8	1978
8	1979
8	1980
8	1981
8	1982
8	1983
8	1984
8	1985
8	1942
8	1943
8	1944
8	1945
8	1946
8	1947
8	1948
8	1949
8	1950
8	1951
8	1952
8	1953
8	1954
8	1955
8	1956
8	3327
8	3330
8	385
8	3321
8	383
8	3359
8	1986
8	1987
8	1988
8	1989
8	1990
8	1991
8	1992
8	1993
8	1994
8	1995
8	1996
8	1997
8	1998
8	1999
8	2000
8	2001
8	2002
8	2003
8	2004
8	2005
8	2006
8	2007
8	2008
8	2009
8	2010
8	2011
8	2012
8	2013
8	2014
8	387
8	3319
8	2015
8	2016
8	2017
8	2018
8	2019
8	2020
8	2021
8	2022
8	2023
8	2024
8	2025
8	2026
8	2027
8	2028
8	2029
8	2030
8	2031
8	2032
8	2033
8	2034
8	2035
8	2036
8	2037
8	2038
8	2039
8	2040
8	2041
8	2042
8	2043
8	3415
8	393
8	529
8	530
8	531
8	532
8	533
8	534
8	535
8	536
8	537
8	538
8	539
8	540
8	541
8	542
8	2044
8	2045
8	2046
8	2047
8	2048
8	2049
8	2050
8	2051
8	2052
8	2053
8	2054
8	2055
8	2056
8	2057
8	2058
8	2059
8	2060
8	2061
8	2062
8	2063
8	2064
8	2065
8	2066
8	2067
8	2068
8	2069
8	2070
8	2071
8	2072
8	2073
8	2074
8	2075
8	2076
8	2077
8	2078
8	2079
8	2080
8	2081
8	2082
8	2083
8	2084
8	2085
8	2086
8	2087
8	2088
8	2089
8	2090
8	2091
8	2092
8	3328
8	2093
8	2094
8	2095
8	2096
8	2097
8	2098
8	3276
8	3277
8	3278
8	3279
8	3280
8	3281
8	3282
8	3283
8	3284
8	3285
8	3286
8	3287
8	2099
8	2100
8	2101
8	2102
8	2103
8	2104
8	2105
8	2106
8	2107
8	2108
8	2109
8	2110
8	2111
8	2112
8	2113
8	2114
8	2115
8	2116
8	2117
8	2118
8	2119
8	2120
8	2121
8	2122
8	2123
8	2124
8	2125
8	2126
8	2127
8	2128
8	2129
8	2130
8	2131
8	2132
8	2133
8	2134
8	2135
8	2136
8	2137
8	2138
8	2139
8	2140
8	2141
8	2142
8	2143
8	2144
8	2145
8	2146
8	2147
8	2148
8	2149
8	2150
8	2151
8	2152
8	2153
8	2154
8	2155
8	2156
8	2157
8	2158
8	2159
8	2160
8	2161
8	2162
8	2163
8	2164
8	2165
8	2166
8	2167
8	2168
8	2169
8	2170
8	2171
8	2172
8	2173
8	2174
8	2175
8	2176
8	2177
8	2178
8	2179
8	2180
8	2181
8	2182
8	2183
8	2184
8	2185
8	2186
8	2187
8	2188
8	2189
8	2190
8	2191
8	2192
8	2193
8	2194
8	2195
8	2196
8	2197
8	2198
8	2199
8	2200
8	2201
8	2202
8	2203
8	2204
8	2205
8	2206
8	2207
8	2208
8	2209
8	2210
8	2211
8	2212
8	2213
8	2214
8	2215
8	386
8	3325
8	2216
8	2217
8	2218
8	2219
8	2220
8	2221
8	2222
8	2223
8	2224
8	2225
8	2226
8	2227
8	2228
8	2229
8	2230
8	2231
8	2232
8	2233
8	2234
8	2235
8	2236
8	2237
8	2238
8	2239
8	2240
8	2241
8	2242
8	2243
8	2244
8	2245
8	2246
8	2247
8	2248
8	2249
8	2250
8	2251
8	2252
8	2253
8	2650
8	2651
8	2652
8	2653
8	2654
8	2655
8	2656
8	2657
8	2658
8	2659
8	2660
8	2661
8	2662
8	2663
8	3353
8	3355
8	3271
8	2254
8	2255
8	2256
8	2257
8	2258
8	2259
8	2260
8	2261
8	2262
8	2263
8	2264
8	2265
8	2266
8	2267
8	2268
8	2269
8	2270
8	419
8	420
8	421
8	422
8	423
8	424
8	425
8	426
8	427
8	428
8	429
8	430
8	431
8	432
8	433
8	434
8	435
8	2271
8	2272
8	2273
8	2274
8	2275
8	2276
8	2277
8	2278
8	2279
8	2280
8	2281
8	2318
8	2319
8	2320
8	2321
8	2322
8	2323
8	2324
8	2325
8	2326
8	2327
8	2328
8	2329
8	2330
8	2331
8	2332
8	2333
8	2285
8	2286
8	2287
8	2288
8	2289
8	2290
8	2291
8	2292
8	2293
8	2294
8	2295
8	3254
8	2296
8	2297
8	2298
8	2299
8	2300
8	2301
8	2302
8	2303
8	2304
8	2305
8	2306
8	2307
8	2308
8	2309
8	2310
8	2311
8	2312
8	2313
8	2314
8	2315
8	2316
8	2317
8	2282
8	2283
8	2284
8	2334
8	2335
8	2336
8	2337
8	2338
8	2339
8	2340
8	2341
8	2342
8	2343
8	2344
8	2345
8	2346
8	2347
8	2348
8	2349
8	2350
8	2351
8	2352
8	2353
8	2354
8	2355
8	2356
8	2357
8	2358
8	2359
8	2360
8	2361
8	2362
8	2363
8	2364
8	2365
8	2366
8	2367
8	2368
8	2369
8	2370
8	2371
8	2372
8	2373
8	2374
8	2375
8	2376
8	2377
8	2378
8	2379
8	2380
8	2381
8	2382
8	2383
8	2384
8	2385
8	2386
8	2387
8	2388
8	2389
8	2390
8	2391
8	2392
8	2393
8	2394
8	2395
8	2396
8	2397
8	2398
8	2399
8	2400
8	2401
8	2402
8	2403
8	2404
8	2405
8	3275
8	3404
8	3323
8	2664
8	2665
8	2666
8	2667
8	2668
8	2669
8	2670
8	2671
8	2672
8	2673
8	2674
8	2675
8	2676
8	2677
8	2678
8	2679
8	2680
8	2681
8	2682
8	2683
8	2684
8	2685
8	2686
8	2687
8	2688
8	2689
8	2690
8	2691
8	2692
8	2693
8	2694
8	2695
8	2696
8	2697
8	2698
8	2699
8	2700
8	2701
8	2702
8	2703
8	2704
8	3414
8	2406
8	2407
8	2408
8	2409
8	2410
8	2411
8	2412
8	2413
8	2414
8	2415
8	2416
8	2417
8	2418
8	2419
8	3334
8	401
8	2420
8	2421
8	2422
8	2423
8	2424
8	2425
8	2426
8	2427
8	2428
8	2429
8	2430
8	2431
8	2432
8	2433
8	570
8	573
8	577
8	580
8	581
8	571
8	579
8	582
8	572
8	575
8	578
8	574
8	576
8	3410
8	3288
8	3289
8	3290
8	3291
8	3292
8	3293
8	3294
8	3295
8	3296
8	3297
8	3298
8	3299
8	3333
8	2434
8	2435
8	2436
8	2437
8	2438
8	2439
8	2440
8	2441
8	2442
8	2443
8	2444
8	2445
8	2446
8	2447
8	2448
8	3418
8	2449
8	2450
8	2451
8	2452
8	2453
8	2454
8	2455
8	2456
8	2457
8	2458
8	2459
8	2460
8	2461
8	2462
8	2463
8	2464
8	2465
8	2466
8	2467
8	2468
8	2469
8	2470
8	2471
8	2472
8	2473
8	2474
8	2475
8	2476
8	2477
8	2478
8	2479
8	2480
8	2481
8	2482
8	2483
8	2484
8	2485
8	2486
8	2487
8	2488
8	2489
8	2490
8	2491
8	2492
8	2493
8	2494
8	2495
8	2496
8	2497
8	2498
8	2499
8	2500
8	2501
8	2502
8	2503
8	2504
8	2505
8	3269
8	2506
8	2507
8	2508
8	2509
8	2510
8	2511
8	2512
8	2513
8	2514
8	2515
8	2516
8	2517
8	2518
8	2519
8	2520
8	2521
8	2522
8	456
8	457
8	458
8	459
8	460
8	461
8	462
8	463
8	464
8	465
8	466
8	467
8	2523
8	2524
8	2525
8	2526
8	2527
8	2528
8	2529
8	2530
8	2531
8	3335
8	2532
8	2533
8	2534
8	2535
8	2536
8	2537
8	2538
8	2539
8	2540
8	2541
8	2542
8	2543
8	2544
8	2545
8	2546
8	2547
8	2548
8	2549
8	2550
8	2551
8	2552
8	2553
8	2554
8	2555
8	2556
8	2557
8	2558
8	2559
8	2560
8	2561
8	2562
8	2563
8	2564
8	2705
8	2706
8	2707
8	2708
8	2709
8	2710
8	2711
8	2712
8	2713
8	2714
8	2715
8	2716
8	2717
8	2718
8	2719
8	2720
8	2721
8	2722
8	2723
8	2724
8	2725
8	2726
8	2727
8	2728
8	2729
8	2730
8	3365
8	3366
8	3367
8	3368
8	3369
8	3370
8	3371
8	3372
8	3373
8	3374
8	2565
8	2566
8	2567
8	2568
8	2569
8	2570
8	2571
8	2751
8	2752
8	2753
8	2754
8	2755
8	2756
8	2757
8	2758
8	2759
8	2760
8	2761
8	2762
8	2763
8	2764
8	2765
8	2766
8	2767
8	2768
8	2769
8	2770
8	2771
8	2772
8	2773
8	2774
8	2775
8	2776
8	2777
8	2778
8	2779
8	2780
8	2781
8	2782
8	2783
8	2784
8	2785
8	2786
8	2787
8	2788
8	2789
8	2790
8	2791
8	2792
8	2793
8	2794
8	2795
8	2796
8	2797
8	2798
8	2799
8	2800
8	2801
8	2802
8	2803
8	2804
8	2805
8	2806
8	2807
8	2808
8	2809
8	2810
8	2811
8	2812
8	2813
8	2814
8	2815
8	2816
8	2817
8	2818
8	646
8	647
8	648
8	649
8	651
8	653
8	655
8	658
8	2926
8	2927
8	2928
8	2929
8	2930
8	2931
8	2932
8	2933
8	2934
8	2935
8	2936
8	2937
8	2938
8	2939
8	2940
8	2941
8	2942
8	2943
8	2944
8	2945
8	2946
8	2947
8	2948
8	2949
8	2950
8	2951
8	2952
8	2953
8	2954
8	2955
8	2956
8	2957
8	2958
8	2959
8	2960
8	2961
8	2962
8	2963
8	3004
8	3005
8	3006
8	3007
8	3008
8	3009
8	3010
8	3011
8	3012
8	3013
8	3014
8	3015
8	3016
8	3017
8	2964
8	2965
8	2966
8	2967
8	2968
8	2969
8	2970
8	2971
8	2972
8	2973
8	2974
8	3253
8	2975
8	2976
8	2977
8	2978
8	2979
8	2980
8	2981
8	2982
8	2983
8	2984
8	2985
8	2986
8	2987
8	2988
8	2989
8	2990
8	2991
8	2992
8	2993
8	2994
8	2995
8	2996
8	2997
8	2998
8	2999
8	3000
8	3001
8	3002
8	3003
8	3018
8	3019
8	3020
8	3021
8	3022
8	3023
8	3024
8	3025
8	3026
8	3027
8	3028
8	3029
8	3030
8	3031
8	3032
8	3033
8	3034
8	3035
8	3036
8	3037
8	3038
8	3039
8	3040
8	3041
8	3042
8	3043
8	3044
8	3045
8	3046
8	3047
8	3048
8	3049
8	3050
8	3051
8	3064
8	3065
8	3066
8	3067
8	3068
8	3069
8	3070
8	3071
8	3072
8	3073
8	3074
8	3075
8	3076
8	3077
8	3078
8	3079
8	3080
8	3052
8	3053
8	3054
8	3055
8	3056
8	3057
8	3058
8	3059
8	3060
8	3061
8	3062
8	3063
8	3081
8	3082
8	3083
8	3084
8	3085
8	3086
8	3087
8	3088
8	3089
8	3090
8	3091
8	3092
8	3093
8	3094
8	3095
8	3096
8	3097
8	3098
8	3099
8	3100
8	3101
8	3102
8	3103
8	323
8	324
8	325
8	326
8	327
8	328
8	329
8	330
8	331
8	332
8	333
8	334
8	335
8	336
8	360
8	361
8	362
8	363
8	364
8	365
8	366
8	367
8	368
8	369
8	370
8	371
8	372
8	373
8	556
8	557
8	558
8	559
8	560
8	561
8	562
8	563
8	564
8	565
8	566
8	567
8	568
8	569
8	661
8	662
8	663
8	664
8	665
8	666
8	667
8	668
8	669
8	670
8	671
8	672
8	673
8	674
8	3104
8	3105
8	3106
8	3107
8	3108
8	3109
8	3110
8	3111
8	3112
8	3113
8	3114
8	3115
8	3116
8	3117
8	3118
8	3119
8	3120
8	3121
8	3122
8	3123
8	3124
8	3125
8	3126
8	3127
8	3128
8	3129
8	3130
8	3131
8	652
8	656
8	657
8	650
8	659
8	654
8	660
8	3132
8	3133
8	3134
8	3135
8	3136
8	3137
8	3138
8	3139
8	3140
8	3141
8	3142
8	3143
8	3144
8	3145
8	2731
8	2732
8	2733
8	2734
8	2735
8	2736
8	2737
8	2738
8	2739
8	2740
8	2741
8	2742
8	2743
8	2744
8	2745
8	2746
8	2747
8	2748
8	2749
8	2750
8	3408
8	3320
8	3409
8	3264
8	3146
8	3147
8	3148
8	3149
8	3150
8	3151
8	3152
8	3153
8	3154
8	3155
8	3156
8	3157
8	3158
8	3159
8	3160
8	3161
8	3162
8	3163
8	3164
8	3438
8	3442
8	3436
8	3450
8	3454
8	3432
8	3443
8	3447
8	3452
8	3441
8	3434
8	3449
8	3445
8	3440
8	3453
8	3439
8	3435
8	3448
8	3437
8	3446
8	3444
8	3433
8	3431
8	3451
8	3430
8	3455
8	3456
8	3457
8	3458
8	3459
8	3460
8	3461
8	3462
8	3463
8	3464
8	3465
8	3466
8	3467
8	3468
8	3469
8	3470
8	3471
8	3472
8	3473
8	3474
8	3475
8	3476
8	3477
8	3478
8	3482
8	3485
8	3491
8	3501
8	3487
8	3500
8	3488
8	3499
8	3497
8	3494
8	3495
8	3490
8	3489
8	3492
8	3483
8	3493
8	3498
8	3496
8	3502
8	3479
8	3481
8	3503
8	3486
8	3480
8	3484
9	3402
10	3250
10	2819
10	2820
10	2821
10	2822
10	2823
10	2824
10	2825
10	2826
10	2827
10	2828
10	2829
10	2830
10	2831
10	2832
10	2833
10	2834
10	2835
10	2836
10	2837
10	2838
10	3226
10	3227
10	3228
10	3229
10	3230
10	3231
10	3232
10	3233
10	3234
10	3235
10	3236
10	3237
10	3238
10	3239
10	3240
10	3241
10	3242
10	3243
10	3244
10	3245
10	3246
10	3247
10	3248
10	3249
10	2839
10	2840
10	2841
10	2842
10	2843
10	2844
10	2845
10	2846
10	2847
10	2848
10	2849
10	2850
10	2851
10	2852
10	2853
10	2854
10	2855
10	2856
10	3166
10	3167
10	3168
10	3171
10	3223
10	2858
10	2861
10	2865
10	2868
10	2871
10	2873
10	2877
10	2880
10	2883
10	2885
10	2888
10	2893
10	2894
10	2898
10	2901
10	2904
10	2906
10	2911
10	2913
10	2915
10	2917
10	2919
10	2921
10	2923
10	2925
10	2859
10	2860
10	2864
10	2867
10	2869
10	2872
10	2878
10	2879
10	2884
10	2887
10	2889
10	2892
10	2896
10	2897
10	2902
10	2905
10	2907
10	2910
10	2914
10	2916
10	2918
10	2920
10	2922
10	2924
10	2857
10	2862
10	2863
10	2866
10	2870
10	2874
10	2875
10	2876
10	2881
10	2882
10	2886
10	2890
10	2891
10	2895
10	2899
10	2900
10	2903
10	2908
10	2909
10	2912
10	3165
10	3169
10	3170
10	3252
10	3224
10	3251
10	3340
10	3339
10	3338
10	3337
10	3341
10	3345
10	3342
10	3346
10	3343
10	3347
10	3344
10	3348
10	3360
10	3361
10	3362
10	3363
10	3364
10	3172
10	3173
10	3174
10	3175
10	3176
10	3177
10	3178
10	3179
10	3180
10	3181
10	3182
10	3183
10	3184
10	3185
10	3186
10	3187
10	3188
10	3189
10	3190
10	3191
10	3192
10	3193
10	3194
10	3195
10	3196
10	3197
10	3198
10	3199
10	3200
10	3201
10	3202
10	3203
10	3204
10	3205
10	3206
10	3207
10	3208
10	3209
10	3210
10	3211
10	3212
10	3213
10	3214
10	3215
10	3216
10	3217
10	3218
10	3219
10	3220
10	3221
10	3222
10	3428
10	3429
11	391
11	516
11	523
11	219
11	220
11	215
11	730
11	738
11	228
11	230
11	236
11	852
11	858
11	864
11	867
11	874
11	877
11	885
11	888
11	1088
11	1093
11	1099
11	1105
11	501
11	504
11	1518
11	1519
11	1514
11	1916
11	1928
11	1921
11	2752
11	2753
11	2754
11	2758
11	2767
11	2768
11	2769
11	393
12	3479
12	3480
12	3481
12	3482
12	3483
12	3484
12	3485
12	3486
12	3487
12	3488
12	3489
12	3490
12	3491
12	3492
12	3493
12	3494
12	3495
12	3496
12	3497
12	3498
12	3499
12	3500
12	3501
12	3502
12	3503
12	3430
12	3431
12	3432
12	3433
12	3434
12	3435
12	3436
12	3437
12	3438
12	3439
12	3440
12	3441
12	3442
12	3443
12	3444
12	3445
12	3446
12	3447
12	3448
12	3449
12	3450
12	3451
12	3452
12	3453
12	3454
12	3403
12	3404
12	3405
12	3406
12	3407
12	3408
12	3409
12	3410
12	3411
12	3412
12	3413
12	3414
12	3415
12	3416
12	3417
12	3418
12	3419
12	3420
12	3421
12	3422
12	3423
12	3424
12	3425
12	3426
12	3427
13	3479
13	3480
13	3481
13	3482
13	3483
13	3484
13	3485
13	3486
13	3487
13	3488
13	3489
13	3490
13	3491
13	3492
13	3493
13	3494
13	3495
13	3496
13	3497
13	3498
13	3499
13	3500
13	3501
13	3502
13	3503
14	3430
14	3431
14	3432
14	3433
14	3434
14	3435
14	3436
14	3437
14	3438
14	3439
14	3440
14	3441
14	3442
14	3443
14	3444
14	3445
14	3446
14	3447
14	3448
14	3449
14	3450
14	3451
14	3452
14	3453
14	3454
15	3403
15	3404
15	3405
15	3406
15	3407
15	3408
15	3409
15	3410
15	3411
15	3412
15	3413
15	3414
15	3415
15	3416
15	3417
15	3418
15	3419
15	3420
15	3421
15	3422
15	3423
15	3424
15	3425
15	3426
15	3427
16	3367
16	52
16	2194
16	2195
16	2198
16	2206
16	2512
16	2516
16	2550
16	2003
16	2004
16	2005
16	2007
16	2010
16	2013
17	1
17	2
17	3
17	4
17	5
17	152
17	160
17	1278
17	1283
17	1392
17	1335
17	1345
17	1380
17	1801
17	1830
17	1837
17	1854
17	1876
17	1880
17	1984
17	1942
17	1945
17	2094
17	2095
17	2096
17	3290
18	597
\.


--
-- Data for Name: Track; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Track" ("TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Composer", "Milliseconds", "Bytes", "UnitPrice") FROM stdin;
1	For Those About To Rock (We Salute You)	1	1	1	Angus Young, Malcolm Young, Brian Johnson	343719	11170334	0.99
2	Balls to the Wall	2	2	1	\N	342562	5510424	0.99
3	Fast As a Shark	3	2	1	F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman	230619	3990994	0.99
4	Restless and Wild	3	2	1	F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider & W. Hoffman	252051	4331779	0.99
5	Princess of the Dawn	3	2	1	Deaffy & R.A. Smith-Diesel	375418	6290521	0.99
6	Put The Finger On You	1	1	1	Angus Young, Malcolm Young, Brian Johnson	205662	6713451	0.99
7	Let's Get It Up	1	1	1	Angus Young, Malcolm Young, Brian Johnson	233926	7636561	0.99
8	Inject The Venom	1	1	1	Angus Young, Malcolm Young, Brian Johnson	210834	6852860	0.99
9	Snowballed	1	1	1	Angus Young, Malcolm Young, Brian Johnson	203102	6599424	0.99
10	Evil Walks	1	1	1	Angus Young, Malcolm Young, Brian Johnson	263497	8611245	0.99
11	C.O.D.	1	1	1	Angus Young, Malcolm Young, Brian Johnson	199836	6566314	0.99
12	Breaking The Rules	1	1	1	Angus Young, Malcolm Young, Brian Johnson	263288	8596840	0.99
13	Night Of The Long Knives	1	1	1	Angus Young, Malcolm Young, Brian Johnson	205688	6706347	0.99
14	Spellbound	1	1	1	Angus Young, Malcolm Young, Brian Johnson	270863	8817038	0.99
15	Go Down	4	1	1	AC/DC	331180	10847611	0.99
16	Dog Eat Dog	4	1	1	AC/DC	215196	7032162	0.99
17	Let There Be Rock	4	1	1	AC/DC	366654	12021261	0.99
18	Bad Boy Boogie	4	1	1	AC/DC	267728	8776140	0.99
19	Problem Child	4	1	1	AC/DC	325041	10617116	0.99
20	Overdose	4	1	1	AC/DC	369319	12066294	0.99
21	Hell Ain't A Bad Place To Be	4	1	1	AC/DC	254380	8331286	0.99
22	Whole Lotta Rosie	4	1	1	AC/DC	323761	10547154	0.99
23	Walk On Water	5	1	1	Steven Tyler, Joe Perry, Jack Blades, Tommy Shaw	295680	9719579	0.99
24	Love In An Elevator	5	1	1	Steven Tyler, Joe Perry	321828	10552051	0.99
25	Rag Doll	5	1	1	Steven Tyler, Joe Perry, Jim Vallance, Holly Knight	264698	8675345	0.99
26	What It Takes	5	1	1	Steven Tyler, Joe Perry, Desmond Child	310622	10144730	0.99
27	Dude (Looks Like A Lady)	5	1	1	Steven Tyler, Joe Perry, Desmond Child	264855	8679940	0.99
28	Janie's Got A Gun	5	1	1	Steven Tyler, Tom Hamilton	330736	10869391	0.99
29	Cryin'	5	1	1	Steven Tyler, Joe Perry, Taylor Rhodes	309263	10056995	0.99
30	Amazing	5	1	1	Steven Tyler, Richie Supa	356519	11616195	0.99
31	Blind Man	5	1	1	Steven Tyler, Joe Perry, Taylor Rhodes	240718	7877453	0.99
32	Deuces Are Wild	5	1	1	Steven Tyler, Jim Vallance	215875	7074167	0.99
33	The Other Side	5	1	1	Steven Tyler, Jim Vallance	244375	7983270	0.99
34	Crazy	5	1	1	Steven Tyler, Joe Perry, Desmond Child	316656	10402398	0.99
35	Eat The Rich	5	1	1	Steven Tyler, Joe Perry, Jim Vallance	251036	8262039	0.99
36	Angel	5	1	1	Steven Tyler, Desmond Child	307617	9989331	0.99
37	Livin' On The Edge	5	1	1	Steven Tyler, Joe Perry, Mark Hudson	381231	12374569	0.99
38	All I Really Want	6	1	1	Alanis Morissette & Glenn Ballard	284891	9375567	0.99
39	You Oughta Know	6	1	1	Alanis Morissette & Glenn Ballard	249234	8196916	0.99
40	Perfect	6	1	1	Alanis Morissette & Glenn Ballard	188133	6145404	0.99
41	Hand In My Pocket	6	1	1	Alanis Morissette & Glenn Ballard	221570	7224246	0.99
42	Right Through You	6	1	1	Alanis Morissette & Glenn Ballard	176117	5793082	0.99
43	Forgiven	6	1	1	Alanis Morissette & Glenn Ballard	300355	9753256	0.99
44	You Learn	6	1	1	Alanis Morissette & Glenn Ballard	239699	7824837	0.99
45	Head Over Feet	6	1	1	Alanis Morissette & Glenn Ballard	267493	8758008	0.99
46	Mary Jane	6	1	1	Alanis Morissette & Glenn Ballard	280607	9163588	0.99
47	Ironic	6	1	1	Alanis Morissette & Glenn Ballard	229825	7598866	0.99
48	Not The Doctor	6	1	1	Alanis Morissette & Glenn Ballard	227631	7604601	0.99
49	Wake Up	6	1	1	Alanis Morissette & Glenn Ballard	293485	9703359	0.99
50	You Oughta Know (Alternate)	6	1	1	Alanis Morissette & Glenn Ballard	491885	16008629	0.99
51	We Die Young	7	1	1	Jerry Cantrell	152084	4925362	0.99
52	Man In The Box	7	1	1	Jerry Cantrell, Layne Staley	286641	9310272	0.99
53	Sea Of Sorrow	7	1	1	Jerry Cantrell	349831	11316328	0.99
54	Bleed The Freak	7	1	1	Jerry Cantrell	241946	7847716	0.99
55	I Can't Remember	7	1	1	Jerry Cantrell, Layne Staley	222955	7302550	0.99
56	Love, Hate, Love	7	1	1	Jerry Cantrell, Layne Staley	387134	12575396	0.99
57	It Ain't Like That	7	1	1	Jerry Cantrell, Michael Starr, Sean Kinney	277577	8993793	0.99
58	Sunshine	7	1	1	Jerry Cantrell	284969	9216057	0.99
59	Put You Down	7	1	1	Jerry Cantrell	196231	6420530	0.99
60	Confusion	7	1	1	Jerry Cantrell, Michael Starr, Layne Staley	344163	11183647	0.99
61	I Know Somethin (Bout You)	7	1	1	Jerry Cantrell	261955	8497788	0.99
62	Real Thing	7	1	1	Jerry Cantrell, Layne Staley	243879	7937731	0.99
63	Desafinado	8	1	2	\N	185338	5990473	0.99
64	Garota De Ipanema	8	1	2	\N	285048	9348428	0.99
65	Samba De Uma Nota S� (One Note Samba)	8	1	2	\N	137273	4535401	0.99
66	Por Causa De Voc�	8	1	2	\N	169900	5536496	0.99
67	Ligia	8	1	2	\N	251977	8226934	0.99
68	Fotografia	8	1	2	\N	129227	4198774	0.99
69	Dindi (Dindi)	8	1	2	\N	253178	8149148	0.99
70	Se Todos Fossem Iguais A Voc� (Instrumental)	8	1	2	\N	134948	4393377	0.99
71	Falando De Amor	8	1	2	\N	219663	7121735	0.99
72	Angela	8	1	2	\N	169508	5574957	0.99
73	Corcovado (Quiet Nights Of Quiet Stars)	8	1	2	\N	205662	6687994	0.99
74	Outra Vez	8	1	2	\N	126511	4110053	0.99
75	O Boto (B�to)	8	1	2	\N	366837	12089673	0.99
76	Canta, Canta Mais	8	1	2	\N	271856	8719426	0.99
77	Enter Sandman	9	1	3	Apocalyptica	221701	7286305	0.99
78	Master Of Puppets	9	1	3	Apocalyptica	436453	14375310	0.99
79	Harvester Of Sorrow	9	1	3	Apocalyptica	374543	12372536	0.99
80	The Unforgiven	9	1	3	Apocalyptica	322925	10422447	0.99
81	Sad But True	9	1	3	Apocalyptica	288208	9405526	0.99
82	Creeping Death	9	1	3	Apocalyptica	308035	10110980	0.99
83	Wherever I May Roam	9	1	3	Apocalyptica	369345	12033110	0.99
84	Welcome Home (Sanitarium)	9	1	3	Apocalyptica	350197	11406431	0.99
85	Cochise	10	1	1	Audioslave/Chris Cornell	222380	5339931	0.99
86	Show Me How to Live	10	1	1	Audioslave/Chris Cornell	277890	6672176	0.99
87	Gasoline	10	1	1	Audioslave/Chris Cornell	279457	6709793	0.99
88	What You Are	10	1	1	Audioslave/Chris Cornell	249391	5988186	0.99
89	Like a Stone	10	1	1	Audioslave/Chris Cornell	294034	7059624	0.99
90	Set It Off	10	1	1	Audioslave/Chris Cornell	263262	6321091	0.99
91	Shadow on the Sun	10	1	1	Audioslave/Chris Cornell	343457	8245793	0.99
92	I am the Highway	10	1	1	Audioslave/Chris Cornell	334942	8041411	0.99
93	Exploder	10	1	1	Audioslave/Chris Cornell	206053	4948095	0.99
94	Hypnotize	10	1	1	Audioslave/Chris Cornell	206628	4961887	0.99
95	Bring'em Back Alive	10	1	1	Audioslave/Chris Cornell	329534	7911634	0.99
96	Light My Way	10	1	1	Audioslave/Chris Cornell	303595	7289084	0.99
97	Getaway Car	10	1	1	Audioslave/Chris Cornell	299598	7193162	0.99
98	The Last Remaining Light	10	1	1	Audioslave/Chris Cornell	317492	7622615	0.99
99	Your Time Has Come	11	1	4	Cornell, Commerford, Morello, Wilk	255529	8273592	0.99
100	Out Of Exile	11	1	4	Cornell, Commerford, Morello, Wilk	291291	9506571	0.99
101	Be Yourself	11	1	4	Cornell, Commerford, Morello, Wilk	279484	9106160	0.99
102	Doesn't Remind Me	11	1	4	Cornell, Commerford, Morello, Wilk	255869	8357387	0.99
103	Drown Me Slowly	11	1	4	Cornell, Commerford, Morello, Wilk	233691	7609178	0.99
104	Heaven's Dead	11	1	4	Cornell, Commerford, Morello, Wilk	276688	9006158	0.99
105	The Worm	11	1	4	Cornell, Commerford, Morello, Wilk	237714	7710800	0.99
106	Man Or Animal	11	1	4	Cornell, Commerford, Morello, Wilk	233195	7542942	0.99
107	Yesterday To Tomorrow	11	1	4	Cornell, Commerford, Morello, Wilk	273763	8944205	0.99
108	Dandelion	11	1	4	Cornell, Commerford, Morello, Wilk	278125	9003592	0.99
109	#1 Zero	11	1	4	Cornell, Commerford, Morello, Wilk	299102	9731988	0.99
110	The Curse	11	1	4	Cornell, Commerford, Morello, Wilk	309786	10029406	0.99
111	Money	12	1	5	Berry Gordy, Jr./Janie Bradford	147591	2365897	0.99
112	Long Tall Sally	12	1	5	Enotris Johnson/Little Richard/Robert "Bumps" Blackwell	106396	1707084	0.99
113	Bad Boy	12	1	5	Larry Williams	116088	1862126	0.99
114	Twist And Shout	12	1	5	Bert Russell/Phil Medley	161123	2582553	0.99
115	Please Mr. Postman	12	1	5	Brian Holland/Freddie Gorman/Georgia Dobbins/Robert Bateman/William Garrett	137639	2206986	0.99
116	C'Mon Everybody	12	1	5	Eddie Cochran/Jerry Capehart	140199	2247846	0.99
117	Rock 'N' Roll Music	12	1	5	Chuck Berry	141923	2276788	0.99
118	Slow Down	12	1	5	Larry Williams	163265	2616981	0.99
119	Roadrunner	12	1	5	Bo Diddley	143595	2301989	0.99
120	Carol	12	1	5	Chuck Berry	143830	2306019	0.99
121	Good Golly Miss Molly	12	1	5	Little Richard	106266	1704918	0.99
122	20 Flight Rock	12	1	5	Ned Fairchild	107807	1299960	0.99
123	Quadrant	13	1	2	Billy Cobham	261851	8538199	0.99
124	Snoopy's search-Red baron	13	1	2	Billy Cobham	456071	15075616	0.99
125	Spanish moss-"A sound portrait"-Spanish moss	13	1	2	Billy Cobham	248084	8217867	0.99
126	Moon germs	13	1	2	Billy Cobham	294060	9714812	0.99
127	Stratus	13	1	2	Billy Cobham	582086	19115680	0.99
128	The pleasant pheasant	13	1	2	Billy Cobham	318066	10630578	0.99
129	Solo-Panhandler	13	1	2	Billy Cobham	246151	8230661	0.99
130	Do what cha wanna	13	1	2	George Duke	274155	9018565	0.99
131	Intro/ Low Down	14	1	3	\N	323683	10642901	0.99
132	13 Years Of Grief	14	1	3	\N	246987	8137421	0.99
133	Stronger Than Death	14	1	3	\N	300747	9869647	0.99
134	All For You	14	1	3	\N	235833	7726948	0.99
135	Super Terrorizer	14	1	3	\N	319373	10513905	0.99
136	Phoney Smile Fake Hellos	14	1	3	\N	273606	9011701	0.99
137	Lost My Better Half	14	1	3	\N	284081	9355309	0.99
138	Bored To Tears	14	1	3	\N	247327	8130090	0.99
139	A.N.D.R.O.T.A.Z.	14	1	3	\N	266266	8574746	0.99
140	Born To Booze	14	1	3	\N	282122	9257358	0.99
141	World Of Trouble	14	1	3	\N	359157	11820932	0.99
142	No More Tears	14	1	3	\N	555075	18041629	0.99
143	The Begining... At Last	14	1	3	\N	365662	11965109	0.99
144	Heart Of Gold	15	1	3	\N	194873	6417460	0.99
145	Snowblind	15	1	3	\N	420022	13842549	0.99
146	Like A Bird	15	1	3	\N	276532	9115657	0.99
147	Blood In The Wall	15	1	3	\N	284368	9359475	0.99
148	The Beginning...At Last	15	1	3	\N	271960	8975814	0.99
149	Black Sabbath	16	1	3	\N	382066	12440200	0.99
150	The Wizard	16	1	3	\N	264829	8646737	0.99
151	Behind The Wall Of Sleep	16	1	3	\N	217573	7169049	0.99
152	N.I.B.	16	1	3	\N	368770	12029390	0.99
153	Evil Woman	16	1	3	\N	204930	6655170	0.99
154	Sleeping Village	16	1	3	\N	644571	21128525	0.99
155	Warning	16	1	3	\N	212062	6893363	0.99
156	Wheels Of Confusion / The Straightener	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	494524	16065830	0.99
157	Tomorrow's Dream	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	192496	6252071	0.99
158	Changes	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	286275	9175517	0.99
159	FX	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	103157	3331776	0.99
160	Supernaut	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	285779	9245971	0.99
161	Snowblind	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	331676	10813386	0.99
162	Cornucopia	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	234814	7653880	0.99
163	Laguna Sunrise	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	173087	5671374	0.99
164	St. Vitus Dance	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	149655	4884969	0.99
165	Under The Sun/Every Day Comes and Goes	17	1	3	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	350458	11360486	0.99
166	Smoked Pork	18	1	4	\N	47333	1549074	0.99
167	Body Count's In The House	18	1	4	\N	204251	6715413	0.99
168	Now Sports	18	1	4	\N	4884	161266	0.99
169	Body Count	18	1	4	\N	317936	10489139	0.99
170	A Statistic	18	1	4	\N	6373	211997	0.99
171	Bowels Of The Devil	18	1	4	\N	223216	7324125	0.99
172	The Real Problem	18	1	4	\N	11650	387360	0.99
173	KKK Bitch	18	1	4	\N	173008	5709631	0.99
174	D Note	18	1	4	\N	95738	3067064	0.99
175	Voodoo	18	1	4	\N	300721	9875962	0.99
176	The Winner Loses	18	1	4	\N	392254	12843821	0.99
177	There Goes The Neighborhood	18	1	4	\N	350171	11443471	0.99
178	Oprah	18	1	4	\N	6635	224313	0.99
179	Evil Dick	18	1	4	\N	239020	7828873	0.99
180	Body Count Anthem	18	1	4	\N	166426	5463690	0.99
181	Momma's Gotta Die Tonight	18	1	4	\N	371539	12122946	0.99
182	Freedom Of Speech	18	1	4	\N	281234	9337917	0.99
183	King In Crimson	19	1	3	Roy Z	283167	9218499	0.99
184	Chemical Wedding	19	1	3	Roy Z	246177	8022764	0.99
185	The Tower	19	1	3	Roy Z	285257	9435693	0.99
186	Killing Floor	19	1	3	Adrian Smith	269557	8854240	0.99
187	Book Of Thel	19	1	3	Eddie Casillas/Roy Z	494393	16034404	0.99
188	Gates Of Urizen	19	1	3	Roy Z	265351	8627004	0.99
189	Jerusalem	19	1	3	Roy Z	402390	13194463	0.99
190	Trupets Of Jericho	19	1	3	Roy Z	359131	11820908	0.99
191	Machine Men	19	1	3	Adrian Smith	341655	11138147	0.99
192	The Alchemist	19	1	3	Roy Z	509413	16545657	0.99
193	Realword	19	1	3	Roy Z	237531	7802095	0.99
194	First Time I Met The Blues	20	1	6	Eurreal Montgomery	140434	4604995	0.99
195	Let Me Love You Baby	20	1	6	Willie Dixon	175386	5716994	0.99
196	Stone Crazy	20	1	6	Buddy Guy	433397	14184984	0.99
197	Pretty Baby	20	1	6	Willie Dixon	237662	7848282	0.99
198	When My Left Eye Jumps	20	1	6	Al Perkins/Willie Dixon	235311	7685363	0.99
199	Leave My Girl Alone	20	1	6	Buddy Guy	204721	6859518	0.99
200	She Suits Me To A Tee	20	1	6	Buddy Guy	136803	4456321	0.99
201	Keep It To Myself (Aka Keep It To Yourself)	20	1	6	Sonny Boy Williamson [I]	166060	5487056	0.99
202	My Time After Awhile	20	1	6	Robert Geddins/Ron Badger/Sheldon Feinberg	182491	6022698	0.99
203	Too Many Ways (Alternate)	20	1	6	Willie Dixon	135053	4459946	0.99
204	Talkin' 'Bout Women Obviously	20	1	6	Amos Blakemore/Buddy Guy	589531	19161377	0.99
205	Jorge Da Capad�cia	21	1	7	Jorge Ben	177397	5842196	0.99
206	Prenda Minha	21	1	7	Tradicional	99369	3225364	0.99
207	Medita��o	21	1	7	Tom Jobim - Newton Mendo�a	148793	4865597	0.99
208	Terra	21	1	7	Caetano Veloso	482429	15889054	0.99
209	Eclipse Oculto	21	1	7	Caetano Veloso	221936	7382703	0.99
210	Texto "Verdade Tropical"	21	1	7	Caetano Veloso	84088	2752161	0.99
211	Bem Devagar	21	1	7	Gilberto Gil	133172	4333651	0.99
212	Dr�o	21	1	7	Gilberto Gil	156264	5065932	0.99
213	Saudosismo	21	1	7	Caetano Veloso	144326	4726981	0.99
214	Carolina	21	1	7	Chico Buarque	181812	5924159	0.99
215	Sozinho	21	1	7	Peninha	190589	6253200	0.99
216	Esse Cara	21	1	7	Caetano Veloso	223111	7217126	0.99
217	Mel	21	1	7	Caetano Veloso - Waly Salom�o	294765	9854062	0.99
218	Linha Do Equador	21	1	7	Caetano Veloso - Djavan	299337	10003747	0.99
219	Odara	21	1	7	Caetano Veloso	141270	4704104	0.99
220	A Luz De Tieta	21	1	7	Caetano Veloso	251742	8507446	0.99
221	Atr�s Da Verd-E-Rosa S� N�o Vai Quem J� Morreu	21	1	7	David Corr�a - Paulinho Carvalho - Carlos Sena - Bira do Ponto	307252	10364247	0.99
222	Vida Boa	21	1	7	Fausto Nilo - Armandinho	281730	9411272	0.99
223	Sozinho (Hitmakers Classic Mix)	22	1	7	\N	436636	14462072	0.99
224	Sozinho (Hitmakers Classic Radio Edit)	22	1	7	\N	195004	6455134	0.99
225	Sozinho (Ca�drum 'n' Bass)	22	1	7	\N	328071	10975007	0.99
226	Carolina	23	1	7	\N	163056	5375395	0.99
227	Essa Mo�a Ta Diferente	23	1	7	\N	167235	5568574	0.99
228	Vai Passar	23	1	7	\N	369763	12359161	0.99
229	Samba De Orly	23	1	7	\N	162429	5431854	0.99
230	Bye, Bye Brasil	23	1	7	\N	283402	9499590	0.99
231	Atras Da Porta	23	1	7	\N	189675	6132843	0.99
232	Tatuagem	23	1	7	\N	172120	5645703	0.99
233	O Que Ser� (� Flor Da Terra)	23	1	7	\N	167288	5574848	0.99
234	Morena De Angola	23	1	7	\N	186801	6373932	0.99
235	Apesar De Voc�	23	1	7	\N	234501	7886937	0.99
236	A Banda	23	1	7	\N	132493	4349539	0.99
237	Minha Historia	23	1	7	\N	182256	6029673	0.99
238	Com A��car E Com Afeto	23	1	7	\N	175386	5846442	0.99
239	Brejo Da Cruz	23	1	7	\N	214099	7270749	0.99
240	Meu Caro Amigo	23	1	7	\N	260257	8778172	0.99
241	Geni E O Zepelim	23	1	7	\N	317570	10342226	0.99
242	Trocando Em Mi�dos	23	1	7	\N	169717	5461468	0.99
243	Vai Trabalhar Vagabundo	23	1	7	\N	139154	4693941	0.99
244	Gota D'�gua	23	1	7	\N	153208	5074189	0.99
245	Constru��o / Deus Lhe Pague	23	1	7	\N	383059	12675305	0.99
246	Mateus Enter	24	1	7	Chico Science	33149	1103013	0.99
247	O Cidad�o Do Mundo	24	1	7	Chico Science	200933	6724966	0.99
248	Etnia	24	1	7	Chico Science	152555	5061413	0.99
249	Quilombo Groove [Instrumental]	24	1	7	Chico Science	151823	5042447	0.99
250	Mac�	24	1	7	Chico Science	249600	8253934	0.99
251	Um Passeio No Mundo Livre	24	1	7	Chico Science	240091	7984291	0.99
252	Samba Do Lado	24	1	7	Chico Science	227317	7541688	0.99
253	Maracatu At�mico	24	1	7	Chico Science	284264	9670057	0.99
254	O Encontro De Isaac Asimov Com Santos Dumont No C�u	24	1	7	Chico Science	99108	3240816	0.99
255	Corpo De Lama	24	1	7	Chico Science	232672	7714954	0.99
256	Sobremesa	24	1	7	Chico Science	240091	7960868	0.99
257	Manguetown	24	1	7	Chico Science	194560	6475159	0.99
258	Um Sat�lite Na Cabe�a	24	1	7	Chico Science	126615	4272821	0.99
259	Bai�o Ambiental [Instrumental]	24	1	7	Chico Science	152659	5198539	0.99
260	Sangue De Bairro	24	1	7	Chico Science	132231	4415557	0.99
261	Enquanto O Mundo Explode	24	1	7	Chico Science	88764	2968650	0.99
262	Interlude Zumbi	24	1	7	Chico Science	71627	2408550	0.99
263	Crian�a De Domingo	24	1	7	Chico Science	208222	6984813	0.99
264	Amor De Muito	24	1	7	Chico Science	175333	5881293	0.99
265	Samidarish [Instrumental]	24	1	7	Chico Science	272431	8911641	0.99
266	Maracatu At�mico [Atomic Version]	24	1	7	Chico Science	273084	9019677	0.99
267	Maracatu At�mico [Ragga Mix]	24	1	7	Chico Science	210155	6986421	0.99
268	Maracatu At�mico [Trip Hop]	24	1	7	Chico Science	221492	7380787	0.99
269	Banditismo Por Uma Questa	25	1	7	\N	307095	10251097	0.99
270	Banditismo Por Uma Questa	25	1	7	\N	243644	8147224	0.99
271	Rios Pontes & Overdrives	25	1	7	\N	286720	9659152	0.99
272	Cidade	25	1	7	\N	216346	7241817	0.99
273	Praiera	25	1	7	\N	183640	6172781	0.99
274	Samba Makossa	25	1	7	\N	271856	9095410	0.99
275	Da Lama Ao Caos	25	1	7	\N	251559	8378065	0.99
276	Maracatu De Tiro Certeiro	25	1	7	\N	88868	2901397	0.99
277	Salustiano Song	25	1	7	\N	215405	7183969	0.99
278	Antene Se	25	1	7	\N	248372	8253618	0.99
279	Risoflora	25	1	7	\N	105586	3536938	0.99
280	Lixo Do Mangue	25	1	7	\N	193253	6534200	0.99
281	Computadores Fazem Arte	25	1	7	\N	404323	13702771	0.99
282	Girassol	26	1	8	Bino Farias/Da Gama/Laz�o/Pedro Luis/Toni Garrido	249808	8327676	0.99
283	A Sombra Da Maldade	26	1	8	Da Gama/Toni Garrido	230922	7697230	0.99
284	Johnny B. Goode	26	1	8	Chuck Berry	254615	8505985	0.99
285	Soldado Da Paz	26	1	8	Herbert Vianna	194220	6455080	0.99
286	Firmamento	26	1	8	Bino Farias/Da Gama/Henry Lawes/Laz�o/Toni Garrido/Winston Foser-Vers	222145	7402658	0.99
287	Extra	26	1	8	Gilberto Gil	304352	10078050	0.99
288	O Er�	26	1	8	Bernardo Vilhena/Bino Farias/Da Gama/Laz�o/Toni Garrido	236382	7866924	0.99
289	Podes Crer	26	1	8	Bino Farias/Da Gama/Laz�o/Toni Garrido	232280	7747747	0.99
290	A Estrada	26	1	8	Bino Farias/Da Gama/Laz�o/Toni Garrido	248842	8275673	0.99
291	Berlim	26	1	8	Da Gama/Toni Garrido	207542	6920424	0.99
292	J� Foi	26	1	8	Bino Farias/Da Gama/Laz�o/Toni Garrido	221544	7388466	0.99
293	Onde Voc� Mora?	26	1	8	Marisa Monte/Nando Reis	256026	8502588	0.99
294	Pensamento	26	1	8	Bino Farias/Da Gamma/Laz�o/R�s Bernard	173008	5748424	0.99
295	Concilia��o	26	1	8	Da Gama/Laz�o/R�s Bernardo	257619	8552474	0.99
296	Realidade Virtual	26	1	8	Bino Farias/Da Gama/Laz�o/Toni Garrido	195239	6503533	0.99
297	Mensagem	26	1	8	Bino Farias/Da Gama/Laz�o/R�s Bernardo	225332	7488852	0.99
298	A Cor Do Sol	26	1	8	Bernardo Vilhena/Da Gama/Laz�o	231392	7663348	0.99
299	Onde Voc� Mora?	27	1	8	Marisa Monte/Nando Reis	298396	10056970	0.99
300	O Er�	27	1	8	Bernardo Vilhena/Bino/Da Gama/Lazao/Toni Garrido	206942	6950332	0.99
301	A Sombra Da Maldade	27	1	8	Da Gama/Toni Garrido	285231	9544383	0.99
302	A Estrada	27	1	8	Da Gama/Lazao/Toni Garrido	282174	9344477	0.99
303	Falar A Verdade	27	1	8	Bino/Da Gama/Ras Bernardo	244950	8189093	0.99
304	Firmamento	27	1	8	Harry Lawes/Winston Foster-Vers	225488	7507866	0.99
305	Pensamento	27	1	8	Bino/Da Gama/Ras Bernardo	192391	6399761	0.99
306	Realidade Virtual	27	1	8	Bino/Da Gamma/Lazao/Toni Garrido	240300	8069934	0.99
307	Doutor	27	1	8	Bino/Da Gama/Toni Garrido	178155	5950952	0.99
308	Na Frente Da TV	27	1	8	Bino/Da Gama/Lazao/Ras Bernardo	289750	9633659	0.99
309	Downtown	27	1	8	Cidade Negra	239725	8024386	0.99
310	S�bado A Noite	27	1	8	Lulu Santos	267363	8895073	0.99
311	A Cor Do Sol	27	1	8	Bernardo Vilhena/Da Gama/Lazao	273031	9142937	0.99
312	Eu Tamb�m Quero Beijar	27	1	8	Fausto Nilo/Moraes Moreira/Pepeu Gomes	211147	7029400	0.99
313	Noite Do Prazer	28	1	7	\N	311353	10309980	0.99
314	� Francesa	28	1	7	\N	244532	8150846	0.99
315	Cada Um Cada Um (A Namoradeira)	28	1	7	\N	253492	8441034	0.99
316	Linha Do Equador	28	1	7	\N	244715	8123466	0.99
317	Amor Demais	28	1	7	\N	254040	8420093	0.99
318	F�rias	28	1	7	\N	264202	8731945	0.99
319	Gostava Tanto De Voc�	28	1	7	\N	230452	7685326	0.99
320	Flor Do Futuro	28	1	7	\N	275748	9205941	0.99
321	Felicidade Urgente	28	1	7	\N	266605	8873358	0.99
322	Livre Pra Viver	28	1	7	\N	214595	7111596	0.99
323	Dig-Dig, Lambe-Lambe (Ao Vivo)	29	1	9	Cassiano Costa/Cintia Maviane/J.F./Lucas Costa	205479	6892516	0.99
324	Perer�	29	1	9	Augusto Concei��o/Chiclete Com Banana	198661	6643207	0.99
325	TriboTchan	29	1	9	Cal Adan/Paulo Levi	194194	6507950	0.99
326	Tapa Aqui, Descobre Ali	29	1	9	Paulo Levi/W. Rangel	188630	6327391	0.99
327	Daniela	29	1	9	Jorge Cardoso/Pierre Onasis	230791	7748006	0.99
328	Bate Lata	29	1	9	F�bio Nolasco/Gal Sales/Ivan Brasil	206733	7034985	0.99
329	Garotas do Brasil	29	1	9	Garay, Ricardo Engels/Luca Predabom/Ludwig, Carlos Henrique/Maur�cio Vieira	210155	6973625	0.99
330	Levada do Amor (Ailoviu)	29	1	9	Luiz Wanderley/Paulo Levi	190093	6457752	0.99
331	Lavadeira	29	1	9	Do Vale, Valverde/Gal Oliveira/Luciano Pinto	214256	7254147	0.99
332	Reboladeira	29	1	9	Cal Adan/Ferrugem/Julinho Carioca/Tr�ona N� Dhomhnaill	210599	7027525	0.99
333	� que Nessa Encarna��o Eu Nasci Manga	29	1	9	Lucina/Luli	196519	6568081	0.99
334	Reggae Tchan	29	1	9	Cal Adan/Del Rey, Tension/Edu Casanova	206654	6931328	0.99
335	My Love	29	1	9	Jauperi/Zeu G�es	203493	6772813	0.99
336	Latinha de Cerveja	29	1	9	Adriano Bernandes/Edmar Neves	166687	5532564	0.99
337	You Shook Me	30	1	1	J B Lenoir/Willie Dixon	315951	10249958	0.99
338	I Can't Quit You Baby	30	1	1	Willie Dixon	263836	8581414	0.99
339	Communication Breakdown	30	1	1	Jimmy Page/John Bonham/John Paul Jones	192653	6287257	0.99
340	Dazed and Confused	30	1	1	Jimmy Page	401920	13035765	0.99
341	The Girl I Love She Got Long Black Wavy Hair	30	1	1	Jimmy Page/John Bonham/John Estes/John Paul Jones/Robert Plant	183327	5995686	0.99
342	What is and Should Never Be	30	1	1	Jimmy Page/Robert Plant	260675	8497116	0.99
343	Communication Breakdown(2)	30	1	1	Jimmy Page/John Bonham/John Paul Jones	161149	5261022	0.99
344	Travelling Riverside Blues	30	1	1	Jimmy Page/Robert Johnson/Robert Plant	312032	10232581	0.99
345	Whole Lotta Love	30	1	1	Jimmy Page/John Bonham/John Paul Jones/Robert Plant/Willie Dixon	373394	12258175	0.99
346	Somethin' Else	30	1	1	Bob Cochran/Sharon Sheeley	127869	4165650	0.99
347	Communication Breakdown(3)	30	1	1	Jimmy Page/John Bonham/John Paul Jones	185260	6041133	0.99
348	I Can't Quit You Baby(2)	30	1	1	Willie Dixon	380551	12377615	0.99
349	You Shook Me(2)	30	1	1	J B Lenoir/Willie Dixon	619467	20138673	0.99
350	How Many More Times	30	1	1	Chester Burnett/Jimmy Page/John Bonham/John Paul Jones/Robert Plant	711836	23092953	0.99
351	Debra Kadabra	31	1	1	Frank Zappa	234553	7649679	0.99
352	Carolina Hard-Core Ecstasy	31	1	1	Frank Zappa	359680	11731061	0.99
353	Sam With The Showing Scalp Flat Top	31	1	1	Don Van Vliet	171284	5572993	0.99
354	Poofter's Froth Wyoming Plans Ahead	31	1	1	Frank Zappa	183902	6007019	0.99
355	200 Years Old	31	1	1	Frank Zappa	272561	8912465	0.99
356	Cucamonga	31	1	1	Frank Zappa	144483	4728586	0.99
357	Advance Romance	31	1	1	Frank Zappa	677694	22080051	0.99
358	Man With The Woman Head	31	1	1	Don Van Vliet	88894	2922044	0.99
359	Muffin Man	31	1	1	Frank Zappa	332878	10891682	0.99
360	Vai-Vai 2001	32	1	10	\N	276349	9402241	0.99
361	X-9 2001	32	1	10	\N	273920	9310370	0.99
362	Gavioes 2001	32	1	10	\N	282723	9616640	0.99
363	Nene 2001	32	1	10	\N	284969	9694508	0.99
364	Rosas De Ouro 2001	32	1	10	\N	284342	9721084	0.99
365	Mocidade Alegre 2001	32	1	10	\N	282488	9599937	0.99
366	Camisa Verde 2001	32	1	10	\N	283454	9633755	0.99
367	Leandro De Itaquera 2001	32	1	10	\N	274808	9451845	0.99
368	Tucuruvi 2001	32	1	10	\N	287921	9883335	0.99
369	Aguia De Ouro 2001	32	1	10	\N	284160	9698729	0.99
370	Ipiranga 2001	32	1	10	\N	248293	8522591	0.99
371	Morro Da Casa Verde 2001	32	1	10	\N	284708	9718778	0.99
372	Perola Negra 2001	32	1	10	\N	281626	9619196	0.99
373	Sao Lucas 2001	32	1	10	\N	296254	10020122	0.99
374	Guanabara	33	1	7	Marcos Valle	247614	8499591	0.99
375	Mas Que Nada	33	1	7	Jorge Ben	248398	8255254	0.99
376	V�o Sobre o Horizonte	33	1	7	J.r.Bertami/Parana	225097	7528825	0.99
377	A Paz	33	1	7	Donato/Gilberto Gil	263183	8619173	0.99
378	Wave (Vou te Contar)	33	1	7	Antonio Carlos Jobim	271647	9057557	0.99
379	�gua de Beber	33	1	7	Antonio Carlos Jobim/Vinicius de Moraes	146677	4866476	0.99
380	Samba da Ben�aco	33	1	7	Baden Powell/Vinicius de Moraes	282200	9440676	0.99
381	Pode Parar	33	1	7	Jorge Vercilo/Jota Maranhao	179408	6046678	0.99
382	Menino do Rio	33	1	7	Caetano Veloso	262713	8737489	0.99
383	Ando Meio Desligado	33	1	7	Caetano Veloso	195813	6547648	0.99
384	Mist�rio da Ra�a	33	1	7	Luiz Melodia/Ricardo Augusto	184320	6191752	0.99
385	All Star	33	1	7	Nando Reis	176326	5891697	0.99
386	Menina Bonita	33	1	7	Alexandre Brazil/Pedro Luis/Rodrigo Cabelo	237087	7938246	0.99
387	Pescador de Ilus�es	33	1	7	Macelo Yuka/O Rappa	245524	8267067	0.99
388	� Vontade (Live Mix)	33	1	7	Bombom/Ed Motta	180636	5972430	0.99
389	Maria Fuma�a	33	1	7	Luiz Carlos/Oberdan	141008	4743149	0.99
390	Sambassim (dj patife remix)	33	1	7	Alba Carvalho/Fernando Porto	213655	7243166	0.99
391	Garota De Ipanema	34	1	7	V�rios	279536	9141343	0.99
392	Tim Tim Por Tim Tim	34	1	7	V�rios	213237	7143328	0.99
393	Tarde Em Itapo�	34	1	7	V�rios	313704	10344491	0.99
394	Tanto Tempo	34	1	7	V�rios	170292	5572240	0.99
395	Eu Vim Da Bahia - Live	34	1	7	V�rios	157988	5115428	0.99
396	Al� Al� Marciano	34	1	7	V�rios	238106	8013065	0.99
397	Linha Do Horizonte	34	1	7	V�rios	279484	9275929	0.99
398	Only A Dream In Rio	34	1	7	V�rios	371356	12192989	0.99
399	Abrir A Porta	34	1	7	V�rios	271960	8991141	0.99
400	Alice	34	1	7	V�rios	165982	5594341	0.99
401	Momentos Que Marcam	34	1	7	V�rios	280137	9313740	0.99
402	Um Jantar Pra Dois	34	1	7	V�rios	237714	7819755	0.99
403	Bumbo Da Mangueira	34	1	7	V�rios	270158	9073350	0.99
404	Mr Funk Samba	34	1	7	V�rios	213890	7102545	0.99
405	Santo Antonio	34	1	7	V�rios	162716	5492069	0.99
406	Por Voc�	34	1	7	V�rios	205557	6792493	0.99
407	S� Tinha De Ser Com Voc�	34	1	7	V�rios	389642	13085596	0.99
408	Free Speech For The Dumb	35	1	3	Molaney/Morris/Roberts/Wainwright	155428	5076048	0.99
409	It's Electric	35	1	3	Harris/Tatler	213995	6978601	0.99
410	Sabbra Cadabra	35	1	3	Black Sabbath	380342	12418147	0.99
411	Turn The Page	35	1	3	Seger	366524	11946327	0.99
412	Die Die My Darling	35	1	3	Danzig	149315	4867667	0.99
413	Loverman	35	1	3	Cave	472764	15446975	0.99
414	Mercyful Fate	35	1	3	Diamond/Shermann	671712	21942829	0.99
415	Astronomy	35	1	3	A.Bouchard/J.Bouchard/S.Pearlman	397531	13065612	0.99
416	Whiskey In The Jar	35	1	3	Traditional	305005	9943129	0.99
417	Tuesday's Gone	35	1	3	Collins/Van Zandt	545750	17900787	0.99
418	The More I See	35	1	3	Molaney/Morris/Roberts/Wainwright	287973	9378873	0.99
419	A Kind Of Magic	36	1	1	Roger Taylor	262608	8689618	0.99
420	Under Pressure	36	1	1	Queen & David Bowie	236617	7739042	0.99
421	Radio GA GA	36	1	1	Roger Taylor	343745	11358573	0.99
422	I Want It All	36	1	1	Queen	241684	7876564	0.99
423	I Want To Break Free	36	1	1	John Deacon	259108	8552861	0.99
424	Innuendo	36	1	1	Queen	387761	12664591	0.99
425	It's A Hard Life	36	1	1	Freddie Mercury	249417	8112242	0.99
426	Breakthru	36	1	1	Queen	249234	8150479	0.99
427	Who Wants To Live Forever	36	1	1	Brian May	297691	9577577	0.99
428	Headlong	36	1	1	Queen	273057	8921404	0.99
429	The Miracle	36	1	1	Queen	294974	9671923	0.99
430	I'm Going Slightly Mad	36	1	1	Queen	248032	8192339	0.99
431	The Invisible Man	36	1	1	Queen	238994	7920353	0.99
432	Hammer To Fall	36	1	1	Brian May	220316	7255404	0.99
433	Friends Will Be Friends	36	1	1	Freddie Mercury & John Deacon	248920	8114582	0.99
434	The Show Must Go On	36	1	1	Queen	263784	8526760	0.99
435	One Vision	36	1	1	Queen	242599	7936928	0.99
436	Detroit Rock City	37	1	1	Paul Stanley, B. Ezrin	218880	7146372	0.99
437	Black Diamond	37	1	1	Paul Stanley	314148	10266007	0.99
438	Hard Luck Woman	37	1	1	Paul Stanley	216032	7109267	0.99
439	Sure Know Something	37	1	1	Paul Stanley, Vincent Poncia	242468	7939886	0.99
440	Love Gun	37	1	1	Paul Stanley	196257	6424915	0.99
441	Deuce	37	1	1	Gene Simmons	185077	6097210	0.99
442	Goin' Blind	37	1	1	Gene Simmons, S. Coronel	216215	7045314	0.99
443	Shock Me	37	1	1	Ace Frehley	227291	7529336	0.99
444	Do You Love Me	37	1	1	Paul Stanley, B. Ezrin, K. Fowley	214987	6976194	0.99
445	She	37	1	1	Gene Simmons, S. Coronel	248346	8229734	0.99
446	I Was Made For Loving You	37	1	1	Paul Stanley, Vincent Poncia, Desmond Child	271360	9018078	0.99
447	Shout It Out Loud	37	1	1	Paul Stanley, Gene Simmons, B. Ezrin	219742	7194424	0.99
448	God Of Thunder	37	1	1	Paul Stanley	255791	8309077	0.99
449	Calling Dr. Love	37	1	1	Gene Simmons	225332	7395034	0.99
450	Beth	37	1	1	S. Penridge, Bob Ezrin, Peter Criss	166974	5360574	0.99
451	Strutter	37	1	1	Paul Stanley, Gene Simmons	192496	6317021	0.99
452	Rock And Roll All Nite	37	1	1	Paul Stanley, Gene Simmons	173609	5735902	0.99
453	Cold Gin	37	1	1	Ace Frehley	262243	8609783	0.99
454	Plaster Caster	37	1	1	Gene Simmons	207333	6801116	0.99
455	God Gave Rock 'n' Roll To You	37	1	1	Paul Stanley, Gene Simmons, Rus Ballard, Bob Ezrin	320444	10441590	0.99
456	Heart of the Night	38	1	2	\N	273737	9098263	0.99
457	De La Luz	38	1	2	\N	315219	10518284	0.99
458	Westwood Moon	38	1	2	\N	295627	9765802	0.99
459	Midnight	38	1	2	\N	266866	8851060	0.99
460	Playtime	38	1	2	\N	273580	9070880	0.99
461	Surrender	38	1	2	\N	287634	9422926	0.99
462	Valentino's	38	1	2	\N	296124	9848545	0.99
463	Believe	38	1	2	\N	310778	10317185	0.99
464	As We Sleep	38	1	2	\N	316865	10429398	0.99
465	When Evening Falls	38	1	2	\N	298135	9863942	0.99
466	J Squared	38	1	2	\N	288757	9480777	0.99
467	Best Thing	38	1	2	\N	274259	9069394	0.99
468	Maria	39	1	4	Billie Joe Armstrong -Words Green Day -Music	167262	5484747	0.99
469	Poprocks And Coke	39	1	4	Billie Joe Armstrong -Words Green Day -Music	158354	5243078	0.99
470	Longview	39	1	4	Billie Joe Armstrong -Words Green Day -Music	234083	7714939	0.99
471	Welcome To Paradise	39	1	4	Billie Joe Armstrong -Words Green Day -Music	224208	7406008	0.99
472	Basket Case	39	1	4	Billie Joe Armstrong -Words Green Day -Music	181629	5951736	0.99
473	When I Come Around	39	1	4	Billie Joe Armstrong -Words Green Day -Music	178364	5839426	0.99
474	She	39	1	4	Billie Joe Armstrong -Words Green Day -Music	134164	4425128	0.99
475	J.A.R. (Jason Andrew Relva)	39	1	4	Mike Dirnt -Words Green Day -Music	170997	5645755	0.99
476	Geek Stink Breath	39	1	4	Billie Joe Armstrong -Words Green Day -Music	135888	4408983	0.99
477	Brain Stew	39	1	4	Billie Joe Armstrong -Words Green Day -Music	193149	6305550	0.99
478	Jaded	39	1	4	Billie Joe Armstrong -Words Green Day -Music	90331	2950224	0.99
479	Walking Contradiction	39	1	4	Billie Joe Armstrong -Words Green Day -Music	151170	4932366	0.99
480	Stuck With Me	39	1	4	Billie Joe Armstrong -Words Green Day -Music	135523	4431357	0.99
481	Hitchin' A Ride	39	1	4	Billie Joe Armstrong -Words Green Day -Music	171546	5616891	0.99
482	Good Riddance (Time Of Your Life)	39	1	4	Billie Joe Armstrong -Words Green Day -Music	153600	5075241	0.99
483	Redundant	39	1	4	Billie Joe Armstrong -Words Green Day -Music	198164	6481753	0.99
484	Nice Guys Finish Last	39	1	4	Billie Joe Armstrong -Words Green Day -Music	170187	5604618	0.99
485	Minority	39	1	4	Billie Joe Armstrong -Words Green Day -Music	168803	5535061	0.99
486	Warning	39	1	4	Billie Joe Armstrong -Words Green Day -Music	221910	7343176	0.99
487	Waiting	39	1	4	Billie Joe Armstrong -Words Green Day -Music	192757	6316430	0.99
488	Macy's Day Parade	39	1	4	Billie Joe Armstrong -Words Green Day -Music	213420	7075573	0.99
489	Into The Light	40	1	1	David Coverdale	76303	2452653	0.99
490	River Song	40	1	1	David Coverdale	439510	14359478	0.99
491	She Give Me ...	40	1	1	David Coverdale	252551	8385478	0.99
492	Don't You Cry	40	1	1	David Coverdale	347036	11269612	0.99
493	Love Is Blind	40	1	1	David Coverdale/Earl Slick	344999	11409720	0.99
494	Slave	40	1	1	David Coverdale/Earl Slick	291892	9425200	0.99
495	Cry For Love	40	1	1	Bossi/David Coverdale/Earl Slick	293015	9567075	0.99
496	Living On Love	40	1	1	Bossi/David Coverdale/Earl Slick	391549	12785876	0.99
497	Midnight Blue	40	1	1	David Coverdale/Earl Slick	298631	9750990	0.99
498	Too Many Tears	40	1	1	Adrian Vanderberg/David Coverdale	359497	11810238	0.99
499	Don't Lie To Me	40	1	1	David Coverdale/Earl Slick	283585	9288007	0.99
500	Wherever You May Go	40	1	1	David Coverdale	239699	7803074	0.99
501	Grito De Alerta	41	1	7	Gonzaga Jr.	202213	6539422	0.99
502	N�o D� Mais Pra Segurar (Explode Cora��o)	41	1	7	\N	219768	7083012	0.99
503	Come�aria Tudo Outra Vez	41	1	7	\N	196545	6473395	0.99
504	O Que � O Que � ?	41	1	7	\N	259291	8650647	0.99
505	Sangrando	41	1	7	Gonzaga Jr/Gonzaguinha	169717	5494406	0.99
506	Diga L�, Cora��o	41	1	7	\N	255921	8280636	0.99
507	Lindo Lago Do Amor	41	1	7	Gonzaga Jr.	249678	8353191	0.99
508	Eu Apenas Queria Que Vo�� Soubesse	41	1	7	\N	155637	5130056	0.99
509	Com A Perna No Mundo	41	1	7	Gonzaga Jr.	227448	7747108	0.99
510	E Vamos � Luta	41	1	7	\N	222406	7585112	0.99
511	Um Homem Tamb�m Chora (Guerreiro Menino)	41	1	7	\N	207229	6854219	0.99
512	Comportamento Geral	41	1	7	Gonzaga Jr	181577	5997444	0.99
513	Ponto De Interroga��o	41	1	7	\N	180950	5946265	0.99
514	Espere Por Mim, Morena	41	1	7	Gonzaguinha	207072	6796523	0.99
515	Meia-Lua Inteira	23	1	7	\N	222093	7466288	0.99
516	Voce e Linda	23	1	7	\N	242938	8050268	0.99
517	Um Indio	23	1	7	\N	195944	6453213	0.99
518	Podres Poderes	23	1	7	\N	259761	8622495	0.99
519	Voce Nao Entende Nada - Cotidiano	23	1	7	\N	421982	13885612	0.99
520	O Estrangeiro	23	1	7	\N	374700	12472890	0.99
521	Menino Do Rio	23	1	7	\N	147670	4862277	0.99
522	Qualquer Coisa	23	1	7	\N	193410	6372433	0.99
523	Sampa	23	1	7	\N	185051	6151831	0.99
524	Queixa	23	1	7	\N	299676	9953962	0.99
525	O Leaozinho	23	1	7	\N	184398	6098150	0.99
526	Fora Da Ordem	23	1	7	\N	354011	11746781	0.99
527	Terra	23	1	7	\N	401319	13224055	0.99
528	Alegria, Alegria	23	1	7	\N	169221	5497025	0.99
529	Balada Do Louco	42	1	4	Arnaldo Baptista - Rita Lee	241057	7852328	0.99
530	Ando Meio Desligado	42	1	4	Arnaldo Baptista - Rita Lee -  S�rgio Dias	287817	9484504	0.99
531	Top Top	42	1	4	Os Mutantes - Arnolpho Lima Filho	146938	4875374	0.99
532	Baby	42	1	4	Caetano Veloso	177188	5798202	0.99
533	A E O Z	42	1	4	Mutantes	518556	16873005	0.99
534	Panis Et Circenses	42	1	4	Caetano Veloso - Gilberto Gil	125152	4069688	0.99
535	Ch�o De Estrelas	42	1	4	Orestes Barbosa-S�lvio Caldas	284813	9433620	0.99
536	Vida De Cachorro	42	1	4	Rita Lee - Arnaldo Baptista - S�rgio Baptista	195186	6411149	0.99
537	Bat Macumba	42	1	4	Gilberto Gil - Caetano Veloso	187794	6295223	0.99
538	Desculpe Babe	42	1	4	Arnaldo Baptista - Rita Lee	170422	5637959	0.99
539	Rita Lee	42	1	4	Arnaldo Baptista/Rita Lee/S�rgio Dias	189257	6270503	0.99
540	Posso Perder Minha Mulher, Minha M�e, Desde Que Eu Tenha O Rock And Roll	42	1	4	Arnaldo Baptista - Rita Lee - Arnolpho Lima Filho	222955	7346254	0.99
541	Banho De Lua	42	1	4	B. de Filippi - F. Migliaci - Vers�o: Fred Jorge	221831	7232123	0.99
542	Meu Refrigerador N�o Funciona	42	1	4	Arnaldo Baptista - Rita Lee - S�rgio Dias	382981	12495906	0.99
543	Burn	43	1	1	Coverdale/Lord/Paice	453955	14775708	0.99
544	Stormbringer	43	1	1	Coverdale	277133	9050022	0.99
545	Gypsy	43	1	1	Coverdale/Hughes/Lord/Paice	339173	11046952	0.99
546	Lady Double Dealer	43	1	1	Coverdale	233586	7608759	0.99
547	Mistreated	43	1	1	Coverdale	758648	24596235	0.99
548	Smoke On The Water	43	1	1	Gillan/Glover/Lord/Paice	618031	20103125	0.99
549	You Fool No One	43	1	1	Coverdale/Lord/Paice	804101	26369966	0.99
550	Custard Pie	44	1	1	Jimmy Page/Robert Plant	253962	8348257	0.99
551	The Rover	44	1	1	Jimmy Page/Robert Plant	337084	11011286	0.99
552	In My Time Of Dying	44	1	1	John Bonham/John Paul Jones	666017	21676727	0.99
553	Houses Of The Holy	44	1	1	Jimmy Page/Robert Plant	242494	7972503	0.99
554	Trampled Under Foot	44	1	1	John Paul Jones	336692	11154468	0.99
555	Kashmir	44	1	1	John Bonham	508604	16686580	0.99
556	Imperatriz	45	1	7	Guga/Marquinho Lessa/Tuninho Professor	339173	11348710	0.99
557	Beija-Flor	45	1	7	Caruso/Cleber/Deo/Osmar	327000	10991159	0.99
558	Viradouro	45	1	7	Dadinho/Gilbreto Gomes/Gustavo/P.C. Portugal/R. Mocoto	344320	11484362	0.99
559	Mocidade	45	1	7	Domenil/J. Brito/Joaozinho/Rap, Marcelo Do	261720	8817757	0.99
560	Unidos Da Tijuca	45	1	7	Douglas/Neves, Vicente Das/Silva, Gilmar L./Toninho Gentil/Wantuir	338834	11440689	0.99
561	Salgueiro	45	1	7	Augusto/Craig Negoescu/Rocco Filho/Saara, Ze Carlos Da	305920	10294741	0.99
562	Mangueira	45	1	7	Bizuca/Cl�vis P�/Gilson Bernini/Marelo D'Aguia	298318	9999506	0.99
563	Uni�o Da Ilha	45	1	7	Dito/Djalma Falcao/Ilha, Almir Da/M�rcio Andr�	330945	11100945	0.99
564	Grande Rio	45	1	7	Carlos Santos/Ciro/Claudio Russo/Z� Luiz	307252	10251428	0.99
565	Portela	45	1	7	Flavio Bororo/Paulo Apparicio/Wagner Alves/Zeca Sereno	319608	10712216	0.99
566	Caprichosos	45	1	7	Gule/Jorge 101/Lequinho/Luiz Piao	351320	11870956	0.99
567	Tradi��o	45	1	7	Adalto Magalha/Lourenco	269165	9114880	0.99
568	Imp�rio Serrano	45	1	7	Arlindo Cruz/Carlos Sena/Elmo Caetano/Mauricao	334942	11161196	0.99
569	Tuiuti	45	1	7	Claudio Martins/David Lima/Kleber Rodrigues/Livre, Cesare Som	259657	8749492	0.99
570	(Da Le) Yaleo	46	1	1	Santana	353488	11769507	0.99
571	Love Of My Life	46	1	1	Carlos Santana & Dave Matthews	347820	11634337	0.99
572	Put Your Lights On	46	1	1	E. Shrody	285178	9394769	0.99
573	Africa Bamba	46	1	1	I. Toure, S. Tidiane Toure, Carlos Santana & K. Perazzo	282827	9492487	0.99
574	Smooth	46	1	1	M. Itaal Shur & Rob Thomas	298161	9867455	0.99
575	Do You Like The Way	46	1	1	L. Hill	354899	11741062	0.99
576	Maria Maria	46	1	1	W. Jean, J. Duplessis, Carlos Santana, K. Perazzo & R. Rekow	262635	8664601	0.99
577	Migra	46	1	1	R. Taha, Carlos Santana & T. Lindsay	329064	10963305	0.99
578	Corazon Espinado	46	1	1	F. Olivera	276114	9206802	0.99
579	Wishing It Was	46	1	1	Eale-Eye Cherry, M. Simpson, J. King & M. Nishita	292832	9771348	0.99
580	El Farol	46	1	1	Carlos Santana & KC Porter	291160	9599353	0.99
581	Primavera	46	1	1	KC Porter & JB Eckl	378618	12504234	0.99
582	The Calling	46	1	1	Carlos Santana & C. Thompson	747755	24703884	0.99
583	Solu��o	47	1	7	\N	247431	8100449	0.99
584	Manuel	47	1	7	\N	230269	7677671	0.99
585	Entre E Ou�a	47	1	7	\N	286302	9391004	0.99
586	Um Contrato Com Deus	47	1	7	\N	202501	6636465	0.99
587	Um Jantar Pra Dois	47	1	7	\N	244009	8021589	0.99
588	Vamos Dan�ar	47	1	7	\N	226194	7617432	0.99
589	Um Love	47	1	7	\N	181603	6095524	0.99
590	Seis Da Tarde	47	1	7	\N	238445	7935898	0.99
591	Baixo Rio	47	1	7	\N	198008	6521676	0.99
592	Sombras Do Meu Destino	47	1	7	\N	280685	9161539	0.99
593	Do You Have Other Loves?	47	1	7	\N	295235	9604273	0.99
594	Agora Que O Dia Acordou	47	1	7	\N	323213	10572752	0.99
595	J�!!!	47	1	7	\N	217782	7103608	0.99
596	A Rua	47	1	7	\N	238027	7930264	0.99
597	Now's The Time	48	1	2	Miles Davis	197459	6358868	0.99
598	Jeru	48	1	2	Miles Davis	193410	6222536	0.99
599	Compulsion	48	1	2	Miles Davis	345025	11254474	0.99
600	Tempus Fugit	48	1	2	Miles Davis	231784	7548434	0.99
601	Walkin'	48	1	2	Miles Davis	807392	26411634	0.99
602	'Round Midnight	48	1	2	Miles Davis	357459	11590284	0.99
603	Bye Bye Blackbird	48	1	2	Miles Davis	476003	15549224	0.99
604	New Rhumba	48	1	2	Miles Davis	277968	9018024	0.99
605	Generique	48	1	2	Miles Davis	168777	5437017	0.99
606	Summertime	48	1	2	Miles Davis	200437	6461370	0.99
607	So What	48	1	2	Miles Davis	564009	18360449	0.99
608	The Pan Piper	48	1	2	Miles Davis	233769	7593713	0.99
609	Someday My Prince Will Come	48	1	2	Miles Davis	544078	17890773	0.99
610	My Funny Valentine (Live)	49	1	2	Miles Davis	907520	29416781	0.99
611	E.S.P.	49	1	2	Miles Davis	330684	11079866	0.99
612	Nefertiti	49	1	2	Miles Davis	473495	15478450	0.99
613	Petits Machins (Little Stuff)	49	1	2	Miles Davis	487392	16131272	0.99
614	Miles Runs The Voodoo Down	49	1	2	Miles Davis	843964	27967919	0.99
615	Little Church (Live)	49	1	2	Miles Davis	196101	6273225	0.99
616	Black Satin	49	1	2	Miles Davis	316682	10529483	0.99
617	Jean Pierre (Live)	49	1	2	Miles Davis	243461	7955114	0.99
618	Time After Time	49	1	2	Miles Davis	220734	7292197	0.99
619	Portia	49	1	2	Miles Davis	378775	12520126	0.99
620	Space Truckin'	50	1	1	Blackmore/Gillan/Glover/Lord/Paice	1196094	39267613	0.99
621	Going Down / Highway Star	50	1	1	Gillan/Glover/Lord/Nix - Blackmore/Paice	913658	29846063	0.99
622	Mistreated (Alternate Version)	50	1	1	Blackmore/Coverdale	854700	27775442	0.99
623	You Fool No One (Alternate Version)	50	1	1	Blackmore/Coverdale/Lord/Paice	763924	24887209	0.99
624	Jeepers Creepers	51	1	2	\N	185965	5991903	0.99
625	Blue Rythm Fantasy	51	1	2	\N	348212	11204006	0.99
626	Drum Boogie	51	1	2	\N	191555	6185636	0.99
627	Let Me Off Uptown	51	1	2	\N	187637	6034685	0.99
628	Leave Us Leap	51	1	2	\N	182726	5898810	0.99
629	Opus No.1	51	1	2	\N	179800	5846041	0.99
630	Boogie Blues	51	1	2	\N	204199	6603153	0.99
631	How High The Moon	51	1	2	\N	201430	6529487	0.99
632	Disc Jockey Jump	51	1	2	\N	193149	6260820	0.99
633	Up An' Atom	51	1	2	\N	179565	5822645	0.99
634	Bop Boogie	51	1	2	\N	189596	6093124	0.99
635	Lemon Drop	51	1	2	\N	194089	6287531	0.99
636	Coronation Drop	51	1	2	\N	176222	5899898	0.99
637	Overtime	51	1	2	\N	163030	5432236	0.99
638	Imagination	51	1	2	\N	289306	9444385	0.99
639	Don't Take Your Love From Me	51	1	2	\N	282331	9244238	0.99
640	Midget	51	1	2	\N	217025	7257663	0.99
641	I'm Coming Virginia	51	1	2	\N	280163	9209827	0.99
642	Payin' Them Dues Blues	51	1	2	\N	198556	6536918	0.99
643	Jungle Drums	51	1	2	\N	199627	6546063	0.99
644	Showcase	51	1	2	\N	201560	6697510	0.99
645	Swedish Schnapps	51	1	2	\N	191268	6359750	0.99
646	Samba Da B�n��o	52	1	11	\N	409965	13490008	0.99
647	Pot-Pourri N.� 4	52	1	11	\N	392437	13125975	0.99
648	Onde Anda Voc�	52	1	11	\N	168437	5550356	0.99
649	Samba Da Volta	52	1	11	\N	170631	5676090	0.99
650	Canto De Ossanha	52	1	11	\N	204956	6771624	0.99
651	Pot-Pourri N.� 5	52	1	11	\N	219898	7117769	0.99
652	Formosa	52	1	11	\N	137482	4560873	0.99
653	Como � Duro Trabalhar	52	1	11	\N	226168	7541177	0.99
654	Minha Namorada	52	1	11	\N	244297	7927967	0.99
655	Por Que Ser�	52	1	11	\N	162142	5371483	0.99
656	Berimbau	52	1	11	\N	190667	6335548	0.99
657	Deixa	52	1	11	\N	179826	5932799	0.99
658	Pot-Pourri N.� 2	52	1	11	\N	211748	6878359	0.99
659	Samba Em Prel�dio	52	1	11	\N	212636	6923473	0.99
660	Carta Ao Tom 74	52	1	11	\N	162560	5382354	0.99
661	Linha de Passe (Jo�o Bosco)	53	1	7	\N	230948	7902328	0.99
662	Pela Luz dos Olhos Teus (Mi�cha e Tom Jobim)	53	1	7	\N	163970	5399626	0.99
663	Ch�o de Giz (Elba Ramalho)	53	1	7	\N	274834	9016916	0.99
664	Marina (Dorival Caymmi)	53	1	7	\N	172643	5523628	0.99
665	Aquarela (Toquinho)	53	1	7	\N	259944	8480140	0.99
666	Cora��o do Agreste (Faf� de Bel�m)	53	1	7	\N	258194	8380320	0.99
667	Dona (Roupa Nova)	53	1	7	\N	243356	7991295	0.99
668	Come�aria Tudo Outra Vez (Maria Creuza)	53	1	7	\N	206994	6851151	0.99
669	Ca�ador de Mim (S� & Guarabyra)	53	1	7	\N	238341	7751360	0.99
670	Romaria (Renato Teixeira)	53	1	7	\N	244793	8033885	0.99
671	As Rosas N�o Falam (Beth Carvalho)	53	1	7	\N	116767	3836641	0.99
672	Wave (Os Cariocas)	53	1	7	\N	130063	4298006	0.99
673	Garota de Ipanema (Dick Farney)	53	1	7	\N	174367	5767474	0.99
674	Preciso Apender a Viver S� (Maysa)	53	1	7	\N	143464	4642359	0.99
675	Susie Q	54	1	1	Hawkins-Lewis-Broadwater	275565	9043825	0.99
676	I Put A Spell On You	54	1	1	Jay Hawkins	272091	8943000	0.99
677	Proud Mary	54	1	1	J. C. Fogerty	189022	6229590	0.99
678	Bad Moon Rising	54	1	1	J. C. Fogerty	140146	4609835	0.99
679	Lodi	54	1	1	J. C. Fogerty	191451	6260214	0.99
680	Green River	54	1	1	J. C. Fogerty	154279	5105874	0.99
681	Commotion	54	1	1	J. C. Fogerty	162899	5354252	0.99
682	Down On The Corner	54	1	1	J. C. Fogerty	164858	5521804	0.99
683	Fortunate Son	54	1	1	J. C. Fogerty	140329	4617559	0.99
684	Travelin' Band	54	1	1	J. C. Fogerty	129358	4270414	0.99
685	Who'll Stop The Rain	54	1	1	J. C. Fogerty	149394	4899579	0.99
686	Up Around The Bend	54	1	1	J. C. Fogerty	162429	5368701	0.99
687	Run Through The Jungle	54	1	1	J. C. Fogerty	186044	6156567	0.99
688	Lookin' Out My Back Door	54	1	1	J. C. Fogerty	152946	5034670	0.99
689	Long As I Can See The Light	54	1	1	J. C. Fogerty	213237	6924024	0.99
690	I Heard It Through The Grapevine	54	1	1	Whitfield-Strong	664894	21947845	0.99
691	Have You Ever Seen The Rain?	54	1	1	J. C. Fogerty	160052	5263675	0.99
692	Hey Tonight	54	1	1	J. C. Fogerty	162847	5343807	0.99
693	Sweet Hitch-Hiker	54	1	1	J. C. Fogerty	175490	5716603	0.99
694	Someday Never Comes	54	1	1	J. C. Fogerty	239360	7945235	0.99
695	Walking On The Water	55	1	1	J.C. Fogerty	281286	9302129	0.99
696	Suzie-Q, Pt. 2	55	1	1	J.C. Fogerty	244114	7986637	0.99
697	Born On The Bayou	55	1	1	J.C. Fogerty	316630	10361866	0.99
698	Good Golly Miss Molly	55	1	1	J.C. Fogerty	163604	5348175	0.99
699	Tombstone Shadow	55	1	1	J.C. Fogerty	218880	7209080	0.99
700	Wrote A Song For Everyone	55	1	1	J.C. Fogerty	296385	9675875	0.99
701	Night Time Is The Right Time	55	1	1	J.C. Fogerty	190119	6211173	0.99
702	Cotton Fields	55	1	1	J.C. Fogerty	178181	5919224	0.99
703	It Came Out Of The Sky	55	1	1	J.C. Fogerty	176718	5807474	0.99
704	Don't Look Now	55	1	1	J.C. Fogerty	131918	4366455	0.99
705	The Midnight Special	55	1	1	J.C. Fogerty	253596	8297482	0.99
706	Before You Accuse Me	55	1	1	J.C. Fogerty	207804	6815126	0.99
707	My Baby Left Me	55	1	1	J.C. Fogerty	140460	4633440	0.99
708	Pagan Baby	55	1	1	J.C. Fogerty	385619	12713813	0.99
709	(Wish I Could) Hideaway	55	1	1	J.C. Fogerty	228466	7432978	0.99
710	It's Just A Thought	55	1	1	J.C. Fogerty	237374	7778319	0.99
711	Molina	55	1	1	J.C. Fogerty	163239	5390811	0.99
712	Born To Move	55	1	1	J.C. Fogerty	342804	11260814	0.99
713	Lookin' For A Reason	55	1	1	J.C. Fogerty	209789	6933135	0.99
714	Hello Mary Lou	55	1	1	J.C. Fogerty	132832	4476563	0.99
715	Gatas Extraordin�rias	56	1	7	\N	212506	7095702	0.99
716	Brasil	56	1	7	\N	243696	7911683	0.99
717	Eu Sou Neguinha (Ao Vivo)	56	1	7	\N	251768	8376000	0.99
718	Gera��o Coca-Cola (Ao Vivo)	56	1	7	\N	228153	7573301	0.99
719	Lanterna Dos Afogados	56	1	7	\N	204538	6714582	0.99
720	Coron� Antonio Bento	56	1	7	\N	200437	6713066	0.99
721	Voc� Passa, Eu Acho Gra�a (Ao Vivo)	56	1	7	\N	206733	6943576	0.99
722	Meu Mundo Fica Completo (Com Voc�)	56	1	7	\N	247771	8322240	0.99
723	1� De Julho	56	1	7	\N	270262	9017535	0.99
724	M�sica Urbana 2	56	1	7	\N	194899	6383472	0.99
725	Vida Bandida (Ao Vivo)	56	1	7	\N	192626	6360785	0.99
726	Palavras Ao Vento	56	1	7	\N	212453	7048676	0.99
727	N�o Sei O Que Eu Quero Da Vida	56	1	7	\N	151849	5024963	0.99
728	Woman Is The Nigger Of The World (Ao Vivo)	56	1	7	\N	298919	9724145	0.99
729	Juventude Transviada (Ao Vivo)	56	1	7	\N	278622	9183808	0.99
730	Malandragem	57	1	7	\N	247588	8165048	0.99
731	O Segundo Sol	57	1	7	\N	252133	8335629	0.99
732	Smells Like Teen Spirit (Ao Vivo)	57	1	7	\N	316865	10384506	0.99
733	E.C.T.	57	1	7	\N	227500	7571834	0.99
734	Todo Amor Que Houver Nesta Vida	57	1	7	\N	227160	7420347	0.99
735	Metr�. Linha 743	57	1	7	\N	174654	5837495	0.99
736	N�s (Ao Vivo)	57	1	7	\N	193828	6498661	0.99
737	Na Cad�ncia Do Samba	57	1	7	\N	196075	6483952	0.99
738	Admir�vel Gado Novo	57	1	7	\N	274390	9144031	0.99
739	Eleanor Rigby	57	1	7	\N	189466	6303205	0.99
740	Socorro	57	1	7	\N	258586	8549393	0.99
741	Blues Da Piedade	57	1	7	\N	257123	8472964	0.99
742	Rubens	57	1	7	\N	211853	7026317	0.99
743	N�o Deixe O Samba Morrer - Cassia Eller e Alcione	57	1	7	\N	268173	8936345	0.99
744	Mis Penas Lloraba Yo (Ao Vivo) Soy Gitano (Tangos)	57	1	7	\N	188473	6195854	0.99
745	Comin' Home	58	1	1	Bolin/Coverdale/Paice	235781	7644604	0.99
746	Lady Luck	58	1	1	Cook/Coverdale	168202	5501379	0.99
747	Gettin' Tighter	58	1	1	Bolin/Hughes	218044	7176909	0.99
748	Dealer	58	1	1	Bolin/Coverdale	230922	7591066	0.99
749	I Need Love	58	1	1	Bolin/Coverdale	263836	8701064	0.99
750	Drifter	58	1	1	Bolin/Coverdale	242834	8001505	0.99
751	Love Child	58	1	1	Bolin/Coverdale	188160	6173806	0.99
752	This Time Around / Owed to 'G' [Instrumental]	58	1	1	Bolin/Hughes/Lord	370102	11995679	0.99
753	You Keep On Moving	58	1	1	Coverdale/Hughes	319111	10447868	0.99
754	Speed King	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	264385	8587578	0.99
755	Bloodsucker	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	256261	8344405	0.99
756	Child In Time	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	620460	20230089	0.99
757	Flight Of The Rat	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	478302	15563967	0.99
758	Into The Fire	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	210259	6849310	0.99
759	Living Wreck	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	274886	8993056	0.99
760	Hard Lovin' Man	59	1	1	Blackmore, Gillan, Glover, Lord, Paice	431203	13931179	0.99
761	Fireball	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	204721	6714807	0.99
762	No No No	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	414902	13646606	0.99
763	Strange Kind Of Woman	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	247092	8072036	0.99
764	Anyone's Daughter	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	284682	9354480	0.99
765	The Mule	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	322063	10638390	0.99
766	Fools	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	500427	16279366	0.99
767	No One Came	60	1	1	Ritchie Blackmore, Ian Gillan, Roger Glover, Jon Lord, Ian Paice	385880	12643813	0.99
768	Knocking At Your Back Door	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover	424829	13779332	0.99
769	Bad Attitude	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord	307905	10035180	0.99
770	Child In Time (Son Of Aleric - Instrumental)	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord, Ian Paice	602880	19712753	0.99
771	Nobody's Home	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord, Ian Paice	243017	7929493	0.99
772	Black Night	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord, Ian Paice	368770	12058906	0.99
773	Perfect Strangers	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover	321149	10445353	0.99
774	The Unwritten Law	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Ian Paice	295053	9740361	0.99
775	Call Of The Wild	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord	293851	9575295	0.99
776	Hush	61	1	1	South	213054	6944928	0.99
777	Smoke On The Water	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord, Ian Paice	464378	15180849	0.99
778	Space Trucking	61	1	1	Richie Blackmore, Ian Gillian, Roger Glover, Jon Lord, Ian Paice	341185	11122183	0.99
779	Highway Star	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	368770	12012452	0.99
780	Maybe I'm A Leo	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	290455	9502646	0.99
781	Pictures Of Home	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	303777	9903835	0.99
782	Never Before	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	239830	7832790	0.99
783	Smoke On The Water	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	340871	11246496	0.99
784	Lazy	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	442096	14397671	0.99
785	Space Truckin'	62	1	1	Ian Gillan/Ian Paice/Jon Lord/Ritchie Blckmore/Roger Glover	272796	8981030	0.99
786	Vavoom : Ted The Mechanic	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	257384	8510755	0.99
787	Loosen My Strings	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	359680	11702232	0.99
788	Soon Forgotten	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	287791	9401383	0.99
789	Sometimes I Feel Like Screaming	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	451840	14789410	0.99
790	Cascades : I'm Not Your Lover	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	283689	9209693	0.99
791	The Aviator	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	320992	10532053	0.99
792	Rosa's Cantina	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	312372	10323804	0.99
793	A Castle Full Of Rascals	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	311693	10159566	0.99
794	A Touch Away	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	276323	9098561	0.99
795	Hey Cisco	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	354089	11600029	0.99
796	Somebody Stole My Guitar	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	249443	8180421	0.99
797	The Purpendicular Waltz	63	1	1	Ian Gillan, Roger Glover, Jon Lord, Steve Morse, Ian Paice	283924	9299131	0.99
798	King Of Dreams	64	1	1	Blackmore, Glover, Turner	328385	10733847	0.99
799	The Cut Runs Deep	64	1	1	Blackmore, Glover, Turner, Lord, Paice	342752	11191650	0.99
800	Fire In The Basement	64	1	1	Blackmore, Glover, Turner, Lord, Paice	283977	9267550	0.99
801	Truth Hurts	64	1	1	Blackmore, Glover, Turner	314827	10224612	0.99
802	Breakfast In Bed	64	1	1	Blackmore, Glover, Turner	317126	10323804	0.99
803	Love Conquers All	64	1	1	Blackmore, Glover, Turner	227186	7328516	0.99
804	Fortuneteller	64	1	1	Blackmore, Glover, Turner, Lord, Paice	349335	11369671	0.99
805	Too Much Is Not Enough	64	1	1	Turner, Held, Greenwood	257724	8382800	0.99
806	Wicked Ways	64	1	1	Blackmore, Glover, Turner, Lord, Paice	393691	12826582	0.99
807	Stormbringer	65	1	1	D.Coverdale/R.Blackmore/Ritchie Blackmore	246413	8044864	0.99
808	Love Don't Mean a Thing	65	1	1	D.Coverdale/G.Hughes/Glenn Hughes/I.Paice/Ian Paice/J.Lord/John Lord/R.Blackmore/Ritchie Blackmore	263862	8675026	0.99
809	Holy Man	65	1	1	D.Coverdale/G.Hughes/Glenn Hughes/J.Lord/John Lord	270236	8818093	0.99
810	Hold On	65	1	1	D.Coverdal/G.Hughes/Glenn Hughes/I.Paice/Ian Paice/J.Lord/John Lord	306860	10022428	0.99
811	Lady Double Dealer	65	1	1	D.Coverdale/R.Blackmore/Ritchie Blackmore	201482	6554330	0.99
812	You Can't Do it Right (With the One You Love)	65	1	1	D.Coverdale/G.Hughes/Glenn Hughes/R.Blackmore/Ritchie Blackmore	203755	6709579	0.99
813	High Ball Shooter	65	1	1	D.Coverdale/G.Hughes/Glenn Hughes/I.Paice/Ian Paice/J.Lord/John Lord/R.Blackmore/Ritchie Blackmore	267833	8772471	0.99
814	The Gypsy	65	1	1	D.Coverdale/G.Hughes/Glenn Hughes/I.Paice/Ian Paice/J.Lord/John Lord/R.Blackmore/Ritchie Blackmore	242886	7946614	0.99
815	Soldier Of Fortune	65	1	1	D.Coverdale/R.Blackmore/Ritchie Blackmore	193750	6315321	0.99
816	The Battle Rages On	66	1	1	ian paice/jon lord	356963	11626228	0.99
817	Lick It Up	66	1	1	roger glover	240274	7792604	0.99
818	Anya	66	1	1	jon lord/roger glover	392437	12754921	0.99
819	Talk About Love	66	1	1	roger glover	247823	8072171	0.99
820	Time To Kill	66	1	1	roger glover	351033	11354742	0.99
821	Ramshackle Man	66	1	1	roger glover	334445	10874679	0.99
822	A Twist In The Tail	66	1	1	roger glover	257462	8413103	0.99
823	Nasty Piece Of Work	66	1	1	jon lord/roger glover	276662	9076997	0.99
824	Solitaire	66	1	1	roger glover	282226	9157021	0.99
825	One Man's Meat	66	1	1	roger glover	278804	9068960	0.99
826	Pour Some Sugar On Me	67	1	1	\N	292519	9518842	0.99
827	Photograph	67	1	1	\N	248633	8108507	0.99
828	Love Bites	67	1	1	\N	346853	11305791	0.99
829	Let's Get Rocked	67	1	1	\N	296019	9724150	0.99
830	Two Steps Behind [Acoustic Version]	67	1	1	\N	259787	8523388	0.99
831	Animal	67	1	1	\N	244741	7985133	0.99
832	Heaven Is	67	1	1	\N	214021	6988128	0.99
833	Rocket	67	1	1	\N	247248	8092463	0.99
834	When Love & Hate Collide	67	1	1	\N	257280	8364633	0.99
835	Action	67	1	1	\N	220604	7130830	0.99
836	Make Love Like A Man	67	1	1	\N	255660	8309725	0.99
837	Armageddon It	67	1	1	\N	322455	10522352	0.99
838	Have You Ever Needed Someone So Bad	67	1	1	\N	319320	10400020	0.99
839	Rock Of Ages	67	1	1	\N	248424	8150318	0.99
840	Hysteria	67	1	1	\N	355056	11622738	0.99
841	Bringin' On The Heartbreak	67	1	1	\N	272457	8853324	0.99
842	Roll Call	68	1	2	Jim Beard	321358	10653494	0.99
843	Otay	68	1	2	John Scofield, Robert Aries, Milton Chambers and Gary Grainger	423653	14176083	0.99
844	Groovus Interruptus	68	1	2	Jim Beard	319373	10602166	0.99
845	Paris On Mine	68	1	2	Jon Herington	368875	12059507	0.99
846	In Time	68	1	2	Sylvester Stewart	368953	12287103	0.99
847	Plan B	68	1	2	Dean Brown, Dennis Chambers & Jim Beard	272039	9032315	0.99
848	Outbreak	68	1	2	Jim Beard & Jon Herington	659226	21685807	0.99
849	Baltimore, DC	68	1	2	John Scofield	346932	11394473	0.99
850	Talkin Loud and Saying Nothin	68	1	2	James Brown & Bobby Byrd	360411	11994859	0.99
851	P�tala	69	1	7	\N	270080	8856165	0.99
852	Meu Bem-Querer	69	1	7	\N	255608	8330047	0.99
853	Cigano	69	1	7	\N	304692	10037362	0.99
854	Boa Noite	69	1	7	\N	338755	11283582	0.99
855	Fato Consumado	69	1	7	\N	211565	7018586	0.99
856	Faltando Um Peda�o	69	1	7	\N	267728	8788760	0.99
857	�libi	69	1	7	\N	213237	6928434	0.99
858	Esquinas	69	1	7	\N	280999	9096726	0.99
859	Se...	69	1	7	\N	286432	9413777	0.99
860	Eu Te Devoro	69	1	7	\N	311614	10312775	0.99
861	Lil�s	69	1	7	\N	274181	9049542	0.99
862	Acelerou	69	1	7	\N	284081	9396942	0.99
863	Um Amor Puro	69	1	7	\N	327784	10687311	0.99
864	Samurai	70	1	7	Djavan	330997	10872787	0.99
865	Nem Um Dia	70	1	7	Djavan	337423	11181446	0.99
866	Oceano	70	1	7	Djavan	217338	7026441	0.99
867	A�ai	70	1	7	Djavan	270968	8893682	0.99
868	Serrado	70	1	7	Djavan	295314	9842240	0.99
869	Flor De Lis	70	1	7	Djavan	236355	7801108	0.99
870	Amar � Tudo	70	1	7	Djavan	211617	7073899	0.99
871	Azul	70	1	7	Djavan	253962	8381029	0.99
872	Seduzir	70	1	7	Djavan	277524	9163253	0.99
873	A Carta	70	1	7	Djavan - Gabriel, O Pensador	347297	11493463	0.99
874	Sina	70	1	7	Djavan	268173	8906539	0.99
875	Acelerou	70	1	7	Djavan	284133	9391439	0.99
876	Um Amor Puro	70	1	7	Djavan	327105	10664698	0.99
877	O B�bado e a Equilibrista	71	1	7	\N	223059	7306143	0.99
878	O Mestre-Sala dos Mares	71	1	7	\N	186226	6180414	0.99
879	Atr�s da Porta	71	1	7	\N	166608	5432518	0.99
880	Dois Pra L�, Dois Pra C�	71	1	7	\N	263026	8684639	0.99
881	Casa no Campo	71	1	7	\N	170788	5531841	0.99
882	Romaria	71	1	7	\N	242834	7968525	0.99
883	Al�, Al�, Marciano	71	1	7	\N	241397	8137254	0.99
884	Me Deixas Louca	71	1	7	\N	214831	6888030	0.99
885	Fascina��o	71	1	7	\N	180793	5793959	0.99
886	Saudosa Maloca	71	1	7	\N	278125	9059416	0.99
887	As Apar�ncias Enganam	71	1	7	\N	247379	8014346	0.99
888	Madalena	71	1	7	\N	157387	5243721	0.99
889	Maria Rosa	71	1	7	\N	232803	7592504	0.99
890	Aprendendo A Jogar	71	1	7	\N	290664	9391041	0.99
891	Layla	72	1	6	Clapton/Gordon	430733	14115792	0.99
892	Badge	72	1	6	Clapton/Harrison	163552	5322942	0.99
893	I Feel Free	72	1	6	Bruce/Clapton	174576	5725684	0.99
894	Sunshine Of Your Love	72	1	6	Bruce/Clapton	252891	8225889	0.99
895	Crossroads	72	1	6	Clapton/Robert Johnson Arr: Eric Clapton	253335	8273540	0.99
896	Strange Brew	72	1	6	Clapton/Collins/Pappalardi	167810	5489787	0.99
897	White Room	72	1	6	Bruce/Clapton	301583	9872606	0.99
898	Bell Bottom Blues	72	1	6	Clapton	304744	9946681	0.99
899	Cocaine	72	1	6	Cale/Clapton	215928	7138399	0.99
900	I Shot The Sheriff	72	1	6	Marley	263862	8738973	0.99
901	After Midnight	72	1	6	Clapton/J. J. Cale	191320	6460941	0.99
902	Swing Low Sweet Chariot	72	1	6	Clapton/Trad. Arr. Clapton	208143	6896288	0.99
903	Lay Down Sally	72	1	6	Clapton/Levy	231732	7774207	0.99
904	Knockin On Heavens Door	72	1	6	Clapton/Dylan	264411	8758819	0.99
905	Wonderful Tonight	72	1	6	Clapton	221387	7326923	0.99
906	Let It Grow	72	1	6	Clapton	297064	9742568	0.99
907	Promises	72	1	6	Clapton/F.eldman/Linn	180401	6006154	0.99
908	I Can't Stand It	72	1	6	Clapton	249730	8271980	0.99
909	Signe	73	1	6	Eric Clapton	193515	6475042	0.99
910	Before You Accuse Me	73	1	6	Eugene McDaniel	224339	7456807	0.99
911	Hey Hey	73	1	6	Big Bill Broonzy	196466	6543487	0.99
912	Tears In Heaven	73	1	6	Eric Clapton, Will Jennings	274729	9032835	0.99
913	Lonely Stranger	73	1	6	Eric Clapton	328724	10894406	0.99
914	Nobody Knows You When You're Down & Out	73	1	6	Jimmy Cox	231836	7669922	0.99
915	Layla	73	1	6	Eric Clapton, Jim Gordon	285387	9490542	0.99
916	Running On Faith	73	1	6	Jerry Lynn Williams	378984	12536275	0.99
917	Walkin' Blues	73	1	6	Robert Johnson	226429	7435192	0.99
918	Alberta	73	1	6	Traditional	222406	7412975	0.99
919	San Francisco Bay Blues	73	1	6	Jesse Fuller	203363	6724021	0.99
920	Malted Milk	73	1	6	Robert Johnson	216528	7096781	0.99
921	Old Love	73	1	6	Eric Clapton, Robert Cray	472920	15780747	0.99
922	Rollin' And Tumblin'	73	1	6	McKinley Morgenfield (Muddy Waters)	251768	8407355	0.99
923	Collision	74	1	4	Jon Hudson/Mike Patton	204303	6656596	0.99
924	Stripsearch	74	1	4	Jon Hudson/Mike Bordin/Mike Patton	270106	8861119	0.99
925	Last Cup Of Sorrow	74	1	4	Bill Gould/Mike Patton	251663	8221247	0.99
926	Naked In Front Of The Computer	74	1	4	Mike Patton	128757	4225077	0.99
927	Helpless	74	1	4	Bill Gould/Mike Bordin/Mike Patton	326217	10753135	0.99
928	Mouth To Mouth	74	1	4	Bill Gould/Jon Hudson/Mike Bordin/Mike Patton	228493	7505887	0.99
929	Ashes To Ashes	74	1	4	Bill Gould/Jon Hudson/Mike Bordin/Mike Patton/Roddy Bottum	217391	7093746	0.99
930	She Loves Me Not	74	1	4	Bill Gould/Mike Bordin/Mike Patton	209867	6887544	0.99
931	Got That Feeling	74	1	4	Mike Patton	140852	4643227	0.99
932	Paths Of Glory	74	1	4	Bill Gould/Jon Hudson/Mike Bordin/Mike Patton/Roddy Bottum	257253	8436300	0.99
933	Home Sick Home	74	1	4	Mike Patton	119040	3898976	0.99
934	Pristina	74	1	4	Bill Gould/Mike Patton	232698	7497361	0.99
935	Land Of Sunshine	75	1	4	\N	223921	7353567	0.99
936	Caffeine	75	1	4	\N	267937	8747367	0.99
937	Midlife Crisis	75	1	4	\N	263235	8628841	0.99
938	RV	75	1	4	\N	223242	7288162	0.99
939	Smaller And Smaller	75	1	4	\N	310831	10180103	0.99
940	Everything's Ruined	75	1	4	\N	273658	9010917	0.99
941	Malpractice	75	1	4	\N	241371	7900683	0.99
942	Kindergarten	75	1	4	\N	270680	8853647	0.99
943	Be Aggressive	75	1	4	\N	222432	7298027	0.99
944	A Small Victory	75	1	4	\N	297168	9733572	0.99
945	Crack Hitler	75	1	4	\N	279144	9162435	0.99
946	Jizzlobber	75	1	4	\N	398341	12926140	0.99
947	Midnight Cowboy	75	1	4	\N	251924	8242626	0.99
948	Easy	75	1	4	\N	185835	6073008	0.99
949	Get Out	76	1	1	Mike Bordin, Billy Gould, Mike Patton	137482	4524972	0.99
950	Ricochet	76	1	1	Mike Bordin, Billy Gould, Mike Patton	269400	8808812	0.99
951	Evidence	76	1	1	Mike Bordin, Billy Gould, Mike Patton, Trey Spruance	293590	9626136	0.99
952	The Gentle Art Of Making Enemies	76	1	1	Mike Bordin, Billy Gould, Mike Patton	209319	6908609	0.99
953	Star A.D.	76	1	1	Mike Bordin, Billy Gould, Mike Patton	203807	6747658	0.99
954	Cuckoo For Caca	76	1	1	Mike Bordin, Billy Gould, Mike Patton, Trey Spruance	222902	7388369	0.99
955	Caralho Voador	76	1	1	Mike Bordin, Billy Gould, Mike Patton, Trey Spruance	242102	8029054	0.99
956	Ugly In The Morning	76	1	1	Mike Bordin, Billy Gould, Mike Patton	186435	6224997	0.99
957	Digging The Grave	76	1	1	Mike Bordin, Billy Gould, Mike Patton	185129	6109259	0.99
958	Take This Bottle	76	1	1	Mike Bordin, Billy Gould, Mike Patton, Trey Spruance	298997	9779971	0.99
959	King For A Day	76	1	1	Mike Bordin, Billy Gould, Mike Patton, Trey Spruance	395859	13163733	0.99
960	What A Day	76	1	1	Mike Bordin, Billy Gould, Mike Patton	158275	5203430	0.99
961	The Last To Know	76	1	1	Mike Bordin, Billy Gould, Mike Patton	267833	8736776	0.99
962	Just A Man	76	1	1	Mike Bordin, Billy Gould, Mike Patton	336666	11031254	0.99
963	Absolute Zero	76	1	1	Mike Bordin, Billy Gould, Mike Patton	181995	5929427	0.99
964	From Out Of Nowhere	77	1	4	Faith No More	202527	6587802	0.99
965	Epic	77	1	4	Faith No More	294008	9631296	0.99
966	Falling To Pieces	77	1	4	Faith No More	316055	10333123	0.99
967	Surprise! You're Dead!	77	1	4	Faith No More	147226	4823036	0.99
968	Zombie Eaters	77	1	4	Faith No More	360881	11835367	0.99
969	The Real Thing	77	1	4	Faith No More	493635	16233080	0.99
970	Underwater Love	77	1	4	Faith No More	231993	7634387	0.99
971	The Morning After	77	1	4	Faith No More	223764	7355898	0.99
972	Woodpecker From Mars	77	1	4	Faith No More	340532	11174250	0.99
973	War Pigs	77	1	4	Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne	464770	15267802	0.99
974	Edge Of The World	77	1	4	Faith No More	250357	8235607	0.99
975	Deixa Entrar	78	1	7	\N	33619	1095012	0.99
976	Falamansa Song	78	1	7	\N	237165	7921313	0.99
977	Xote Dos Milagres	78	1	7	\N	269557	8897778	0.99
978	Rindo � Toa	78	1	7	\N	222066	7365321	0.99
979	Confid�ncia	78	1	7	\N	222197	7460829	0.99
980	Forr� De T�quio	78	1	7	\N	169273	5588756	0.99
981	Zeca Violeiro	78	1	7	\N	143673	4781949	0.99
982	Avisa	78	1	7	\N	355030	11844320	0.99
983	Principiando/Decolagem	78	1	7	\N	116767	3923789	0.99
984	Asas	78	1	7	\N	231915	7711669	0.99
985	Medo De Escuro	78	1	7	\N	213760	7056323	0.99
986	Ora��o	78	1	7	\N	271072	9003882	0.99
987	Minha Gata	78	1	7	\N	181838	6039502	0.99
988	Desaforo	78	1	7	\N	174524	5853561	0.99
989	In Your Honor	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	230191	7468463	0.99
990	No Way Back	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	196675	6421400	0.99
991	Best Of You	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	255712	8363467	0.99
992	DOA	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	252186	8232342	0.99
993	Hell	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	117080	3819255	0.99
994	The Last Song	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	199523	6496742	0.99
995	Free Me	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	278700	9109340	0.99
996	Resolve	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	288731	9416186	0.99
997	The Deepest Blues Are Black	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	238419	7735473	0.99
998	End Over End	79	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett	352078	11395296	0.99
999	Still	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	313182	10323157	0.99
1000	What If I Do?	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	302994	9929799	0.99
1001	Miracle	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	209684	6877994	0.99
1002	Another Round	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	265848	8752670	0.99
1003	Friend Of A Friend	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	193280	6355088	0.99
1004	Over And Out	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	316264	10428382	0.99
1005	On The Mend	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	271908	9071997	0.99
1006	Virginia Moon	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	229198	7494639	0.99
1007	Cold Day In The Sun	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	200724	6596617	0.99
1008	Razor	80	1	1	Dave Grohl, Taylor Hawkins, Nate Mendel, Chris Shiflett/FOO FIGHTERS	293276	9721373	0.99
1009	All My Life	81	1	4	Foo Fighters	263653	8665545	0.99
1010	Low	81	1	4	Foo Fighters	268120	8847196	0.99
1011	Have It All	81	1	4	Foo Fighters	298057	9729292	0.99
1012	Times Like These	81	1	4	Foo Fighters	266370	8624691	0.99
1013	Disenchanted Lullaby	81	1	4	Foo Fighters	273528	8919111	0.99
1014	Tired Of You	81	1	4	Foo Fighters	311353	10094743	0.99
1015	Halo	81	1	4	Foo Fighters	306442	10026371	0.99
1016	Lonely As You	81	1	4	Foo Fighters	277185	9022628	0.99
1017	Overdrive	81	1	4	Foo Fighters	270550	8793187	0.99
1018	Burn Away	81	1	4	Foo Fighters	298396	9678073	0.99
1019	Come Back	81	1	4	Foo Fighters	469968	15371980	0.99
1020	Doll	82	1	1	Dave, Taylor, Nate, Chris	83487	2702572	0.99
1021	Monkey Wrench	82	1	1	Dave, Taylor, Nate, Chris	231523	7527531	0.99
1022	Hey, Johnny Park!	82	1	1	Dave, Taylor, Nate, Chris	248528	8079480	0.99
1023	My Poor Brain	82	1	1	Dave, Taylor, Nate, Chris	213446	6973746	0.99
1024	Wind Up	82	1	1	Dave, Taylor, Nate, Chris	152163	4950667	0.99
1025	Up In Arms	82	1	1	Dave, Taylor, Nate, Chris	135732	4406227	0.99
1026	My Hero	82	1	1	Dave, Taylor, Nate, Chris	260101	8472365	0.99
1027	See You	82	1	1	Dave, Taylor, Nate, Chris	146782	4888173	0.99
1028	Enough Space	82	1	1	Dave Grohl	157387	5169280	0.99
1029	February Stars	82	1	1	Dave, Taylor, Nate, Chris	289306	9344875	0.99
1030	Everlong	82	1	1	Dave Grohl	250749	8270816	0.99
1031	Walking After You	82	1	1	Dave Grohl	303856	9898992	0.99
1032	New Way Home	82	1	1	Dave, Taylor, Nate, Chris	342230	11205664	0.99
1033	My Way	83	1	12	claude fran�ois/gilles thibault/jacques revaux/paul anka	275879	8928684	0.99
1034	Strangers In The Night	83	1	12	berthold kaempfert/charles singleton/eddie snyder	155794	5055295	0.99
1035	New York, New York	83	1	12	fred ebb/john kander	206001	6707993	0.99
1036	I Get A Kick Out Of You	83	1	12	cole porter	194429	6332441	0.99
1037	Something Stupid	83	1	12	carson c. parks	158615	5210643	0.99
1038	Moon River	83	1	12	henry mancini/johnny mercer	198922	6395808	0.99
1039	What Now My Love	83	1	12	carl sigman/gilbert becaud/pierre leroyer	149995	4913383	0.99
1040	Summer Love	83	1	12	hans bradtke/heinz meier/johnny mercer	174994	5693242	0.99
1041	For Once In My Life	83	1	12	orlando murden/ronald miller	171154	5557537	0.99
1042	Love And Marriage	83	1	12	jimmy van heusen/sammy cahn	89730	2930596	0.99
1043	They Can't Take That Away From Me	83	1	12	george gershwin/ira gershwin	161227	5240043	0.99
1044	My Kind Of Town	83	1	12	jimmy van heusen/sammy cahn	188499	6119915	0.99
1045	Fly Me To The Moon	83	1	12	bart howard	149263	4856954	0.99
1046	I've Got You Under My Skin	83	1	12	cole porter	210808	6883787	0.99
1047	The Best Is Yet To Come	83	1	12	carolyn leigh/cy coleman	173583	5633730	0.99
1048	It Was A Very Good Year	83	1	12	ervin drake	266605	8554066	0.99
1049	Come Fly With Me	83	1	12	jimmy van heusen/sammy cahn	190458	6231029	0.99
1050	That's Life	83	1	12	dean kay thompson/kelly gordon	187010	6095727	0.99
1051	The Girl From Ipanema	83	1	12	antonio carlos jobim/norman gimbel/vinicius de moraes	193750	6410674	0.99
1052	The Lady Is A Tramp	83	1	12	lorenz hart/richard rodgers	184111	5987372	0.99
1053	Bad, Bad Leroy Brown	83	1	12	jim croce	169900	5548581	0.99
1054	Mack The Knife	83	1	12	bert brecht/kurt weill/marc blitzstein	292075	9541052	0.99
1055	Loves Been Good To Me	83	1	12	rod mckuen	203964	6645365	0.99
1056	L.A. Is My Lady	83	1	12	alan bergman/marilyn bergman/peggy lipton jones/quincy jones	193175	6378511	0.99
1057	Entrando Na Sua (Intro)	84	1	7	\N	179252	5840027	0.99
1058	Nervosa	84	1	7	\N	229537	7680421	0.99
1059	Funk De Bamba (Com Fernanda Abreu)	84	1	7	\N	237191	7866165	0.99
1060	Call Me At Cleo�s	84	1	7	\N	236617	7920510	0.99
1061	Olhos Coloridos (Com Sandra De S�)	84	1	7	\N	321332	10567404	0.99
1062	Zamba��o	84	1	7	\N	301113	10030604	0.99
1063	Funk Hum	84	1	7	\N	244453	8084475	0.99
1064	Forty Days (Com DJ Hum)	84	1	7	\N	221727	7347172	0.99
1065	Balada Da Paula	84	1	7	Emerson Villani	322821	10603717	0.99
1066	Dujji	84	1	7	\N	324597	10833935	0.99
1067	Meu Guarda-Chuva	84	1	7	\N	248528	8216625	0.99
1068	Mot�is	84	1	7	\N	213498	7041077	0.99
1069	Whistle Stop	84	1	7	\N	526132	17533664	0.99
1070	16 Toneladas	84	1	7	\N	191634	6390885	0.99
1071	Divirta-Se (Saindo Da Sua)	84	1	7	\N	74919	2439206	0.99
1072	Forty Days Instrumental	84	1	7	\N	292493	9584317	0.99
1073	�ia Eu Aqui De Novo	85	1	10	\N	219454	7469735	0.99
1074	Bai�o Da Penha	85	1	10	\N	247928	8393047	0.99
1075	Esperando Na Janela	85	1	10	Manuca/Raimundinho DoAcordion/Targino Godim	261041	8660617	0.99
1076	Juazeiro	85	1	10	Humberto Teixeira/Luiz Gonzaga	222275	7349779	0.99
1077	�ltimo Pau-De-Arara	85	1	10	Corumb�/Jos� Gumar�es/Venancio	200437	6638563	0.99
1078	Asa Branca	85	1	10	Humberto Teixeira/Luiz Gonzaga	217051	7387183	0.99
1079	Qui Nem Jil�	85	1	10	Humberto Teixeira/Luiz Gonzaga	204695	6937472	0.99
1080	Assum Preto	85	1	10	Humberto Teixeira/Luiz Gonzaga	199653	6625000	0.99
1081	Pau-De-Arara	85	1	10	Guio De Morais E Seus "Parentes"/Luiz Gonzaga	191660	6340649	0.99
1082	A Volta Da Asa Branca	85	1	10	Luiz Gonzaga/Z� Dantas	271020	9098093	0.99
1083	O Amor Daqui De Casa	85	1	10	Gilberto Gil	148636	4888292	0.99
1084	As Pegadas Do Amor	85	1	10	Gilberto Gil	209136	6899062	0.99
1085	Lamento Sertanejo	85	1	10	Dominguinhos/Gilberto Gil	260963	8518290	0.99
1086	Casinha Feliz	85	1	10	Gilberto Gil	32287	1039615	0.99
1087	Introdu��o (Live)	86	1	7	\N	154096	5227579	0.99
1088	Palco (Live)	86	1	7	\N	238315	8026622	0.99
1089	Is This Love (Live)	86	1	7	\N	295262	9819759	0.99
1090	Stir It Up (Live)	86	1	7	\N	282409	9594738	0.99
1091	Refavela (Live)	86	1	7	\N	236695	7985305	0.99
1092	Vendedor De Caranguejo (Live)	86	1	7	\N	248842	8358128	0.99
1093	Quanta (Live)	86	1	7	\N	357485	11774865	0.99
1094	Estrela (Live)	86	1	7	\N	285309	9436411	0.99
1095	Pela Internet (Live)	86	1	7	\N	263471	8804401	0.99
1096	C�rebro Eletr�nico (Live)	86	1	7	\N	231627	7805352	0.99
1097	Opachor� (Live)	86	1	7	\N	259526	8596384	0.99
1098	Copacabana (Live)	86	1	7	\N	289671	9673672	0.99
1099	A Novidade (Live)	86	1	7	\N	316969	10508000	0.99
1100	Ghandi (Live)	86	1	7	\N	222458	7481950	0.99
1101	De Ouro E Marfim (Live)	86	1	7	\N	234971	7838453	0.99
1102	Doce De Carnaval (Candy All)	87	1	2	\N	356101	11998470	0.99
1103	Lamento De Carnaval	87	1	2	\N	294530	9819276	0.99
1104	Pretinha	87	1	2	\N	265273	8914579	0.99
1105	A Novidade	73	1	7	Gilberto Gil	324780	10765600	0.99
1106	Tenho Sede	73	1	7	Gilberto Gil	261616	8708114	0.99
1107	Refazenda	73	1	7	Gilberto Gil	218305	7237784	0.99
1108	Realce	73	1	7	Gilberto Gil	264489	8847612	0.99
1109	Esot�rico	73	1	7	Gilberto Gil	317779	10530533	0.99
1110	Dr�o	73	1	7	Gilberto Gil	301453	9931950	0.99
1111	A Paz	73	1	7	Gilberto Gil	293093	9593064	0.99
1112	Beira Mar	73	1	7	Gilberto Gil	295444	9597994	0.99
1113	Sampa	73	1	7	Gilberto Gil	225697	7469905	0.99
1114	Parabolicamar�	73	1	7	Gilberto Gil	284943	9543435	0.99
1115	Tempo Rei	73	1	7	Gilberto Gil	302733	10019269	0.99
1116	Expresso 2222	73	1	7	Gilberto Gil	284760	9690577	0.99
1117	Aquele Abra�o	73	1	7	Gilberto Gil	263993	8805003	0.99
1118	Palco	73	1	7	Gilberto Gil	270550	9049901	0.99
1119	Toda Menina Baiana	73	1	7	Gilberto Gil	278177	9351000	0.99
1120	S�tio Do Pica-Pau Amarelo	73	1	7	Gilberto Gil	218070	7217955	0.99
1121	Straight Out Of Line	88	1	3	Sully Erna	259213	8511877	0.99
1122	Faceless	88	1	3	Sully Erna	216006	6992417	0.99
1123	Changes	88	1	3	Sully Erna; Tony Rombola	260022	8455835	0.99
1124	Make Me Believe	88	1	3	Sully Erna	248607	8075050	0.99
1125	I Stand Alone	88	1	3	Sully Erna	246125	8017041	0.99
1126	Re-Align	88	1	3	Sully Erna	260884	8513891	0.99
1127	I Fucking Hate You	88	1	3	Sully Erna	247170	8059642	0.99
1128	Releasing The Demons	88	1	3	Sully Erna	252760	8276372	0.99
1129	Dead And Broken	88	1	3	Sully Erna	251454	8206611	0.99
1130	I Am	88	1	3	Sully Erna	239516	7803270	0.99
1131	The Awakening	88	1	3	Sully Erna	89547	3035251	0.99
1132	Serenity	88	1	3	Sully Erna; Tony Rombola	274834	9172976	0.99
1133	American Idiot	89	1	4	Billie Joe Armstrong, Mike Dirnt, Tr� Cool	174419	5705793	0.99
1134	Jesus Of Suburbia / City Of The Damned / I Don't Care / Dearly Beloved / Tales Of Another Broken Home	89	1	4	Billie Joe Armstrong/Green Day	548336	17875209	0.99
1135	Holiday	89	1	4	Billie Joe Armstrong, Mike Dirnt, Tr� Cool	232724	7599602	0.99
1136	Boulevard Of Broken Dreams	89	1	4	Mike Dint, Billie Joe, Tr� Cool	260858	8485122	0.99
1137	Are We The Waiting	89	1	4	Green Day	163004	5328329	0.99
1138	St. Jimmy	89	1	4	Green Day	175307	5716589	0.99
1139	Give Me Novacaine	89	1	4	Green Day	205871	6752485	0.99
1140	She's A Rebel	89	1	4	Green Day	120528	3901226	0.99
1141	Extraordinary Girl	89	1	4	Green Day	214021	6975177	0.99
1142	Letterbomb	89	1	4	Green Day	246151	7980902	0.99
1143	Wake Me Up When September Ends	89	1	4	Mike Dint, Billie Joe, Tr� Cool	285753	9325597	0.99
1144	Homecoming / The Death Of St. Jimmy / East 12th St. / Nobody Likes You / Rock And Roll Girlfriend / We're Coming Home Again	89	1	4	Mike Dirnt/Tr� Cool	558602	18139840	0.99
1145	Whatsername	89	1	4	Green Day	252316	8244843	0.99
1146	Welcome to the Jungle	90	2	1	\N	273552	4538451	0.99
1147	It's So Easy	90	2	1	\N	202824	3394019	0.99
1148	Nightrain	90	2	1	\N	268537	4457283	0.99
1149	Out Ta Get Me	90	2	1	\N	263893	4382147	0.99
1150	Mr. Brownstone	90	2	1	\N	228924	3816323	0.99
1151	Paradise City	90	2	1	\N	406347	6687123	0.99
1152	My Michelle	90	2	1	\N	219961	3671299	0.99
1153	Think About You	90	2	1	\N	231640	3860275	0.99
1154	Sweet Child O' Mine	90	2	1	\N	356424	5879347	0.99
1155	You're Crazy	90	2	1	\N	197135	3301971	0.99
1156	Anything Goes	90	2	1	\N	206400	3451891	0.99
1157	Rocket Queen	90	2	1	\N	375349	6185539	0.99
1158	Right Next Door to Hell	91	2	1	\N	182321	3175950	0.99
1159	Dust N' Bones	91	2	1	\N	298374	5053742	0.99
1160	Live and Let Die	91	2	1	\N	184016	3203390	0.99
1161	Don't Cry (Original)	91	2	1	\N	284744	4833259	0.99
1162	Perfect Crime	91	2	1	\N	143637	2550030	0.99
1163	You Ain't the First	91	2	1	\N	156268	2754414	0.99
1164	Bad Obsession	91	2	1	\N	328282	5537678	0.99
1165	Back off Bitch	91	2	1	\N	303436	5135662	0.99
1166	Double Talkin' Jive	91	2	1	\N	203637	3520862	0.99
1167	November Rain	91	2	1	\N	537540	8923566	0.99
1168	The Garden	91	2	1	\N	322175	5438862	0.99
1169	Garden of Eden	91	2	1	\N	161539	2839694	0.99
1170	Don't Damn Me	91	2	1	\N	318901	5385886	0.99
1171	Bad Apples	91	2	1	\N	268351	4567966	0.99
1172	Dead Horse	91	2	1	\N	257600	4394014	0.99
1173	Coma	91	2	1	\N	616511	10201342	0.99
1174	Civil War	92	1	3	Duff McKagan/Slash/W. Axl Rose	461165	15046579	0.99
1175	14 Years	92	1	3	Izzy Stradlin'/W. Axl Rose	261355	8543664	0.99
1176	Yesterdays	92	1	3	Billy/Del James/W. Axl Rose/West Arkeen	196205	6398489	0.99
1177	Knockin' On Heaven's Door	92	1	3	Bob Dylan	336457	10986716	0.99
1178	Get In The Ring	92	1	3	Duff McKagan/Slash/W. Axl Rose	341054	11134105	0.99
1179	Shotgun Blues	92	1	3	W. Axl Rose	203206	6623916	0.99
1180	Breakdown	92	1	3	W. Axl Rose	424960	13978284	0.99
1181	Pretty Tied Up	92	1	3	Izzy Stradlin'	287477	9408754	0.99
1182	Locomotive	92	1	3	Slash/W. Axl Rose	522396	17236842	0.99
1183	So Fine	92	1	3	Duff McKagan	246491	8039484	0.99
1184	Estranged	92	1	3	W. Axl Rose	563800	18343787	0.99
1185	You Could Be Mine	92	1	3	Izzy Stradlin'/W. Axl Rose	343875	11207355	0.99
1186	Don't Cry	92	1	3	Izzy Stradlin'/W. Axl Rose	284238	9222458	0.99
1187	My World	92	1	3	W. Axl Rose	84532	2764045	0.99
1188	Colibri	93	1	2	Richard Bull	361012	12055329	0.99
1189	Love Is The Colour	93	1	2	R. Carless	251585	8419165	0.99
1190	Magnetic Ocean	93	1	2	Patrick Claher/Richard Bull	321123	10720741	0.99
1191	Deep Waters	93	1	2	Richard Bull	396460	13075359	0.99
1192	L'Arc En Ciel De Miles	93	1	2	Kevin Robinson/Richard Bull	242390	8053997	0.99
1193	Gypsy	93	1	2	Kevin Robinson	330997	11083374	0.99
1194	Journey Into Sunlight	93	1	2	Jean Paul Maunick	249756	8241177	0.99
1195	Sunchild	93	1	2	Graham Harvey	259970	8593143	0.99
1196	Millenium	93	1	2	Maxton Gig Beesley Jnr.	379167	12511939	0.99
1197	Thinking 'Bout Tomorrow	93	1	2	Fayyaz Virgi/Richard Bull	355395	11865384	0.99
1198	Jacob's Ladder	93	1	2	Julian Crampton	367647	12201595	0.99
1199	She Wears Black	93	1	2	G Harvey/R Hope-Taylor	528666	17617944	0.99
1200	Dark Side Of The Cog	93	1	2	Jean Paul Maunick	377155	12491122	0.99
1201	Different World	94	2	1	\N	258692	4383764	0.99
1202	These Colours Don't Run	94	2	1	\N	412152	6883500	0.99
1203	Brighter Than a Thousand Suns	94	2	1	\N	526255	8721490	0.99
1204	The Pilgrim	94	2	1	\N	307593	5172144	0.99
1205	The Longest Day	94	2	1	\N	467810	7785748	0.99
1206	Out of the Shadows	94	2	1	\N	336896	5647303	0.99
1207	The Reincarnation of Benjamin Breeg	94	2	1	\N	442106	7367736	0.99
1208	For the Greater Good of God	94	2	1	\N	564893	9367328	0.99
1209	Lord of Light	94	2	1	\N	444614	7393698	0.99
1210	The Legacy	94	2	1	\N	562966	9314287	0.99
1211	Hallowed Be Thy Name (Live) [Non Album Bonus Track]	94	2	1	\N	431262	7205816	0.99
1212	The Number Of The Beast	95	1	3	Steve Harris	294635	4718897	0.99
1213	The Trooper	95	1	3	Steve Harris	235311	3766272	0.99
1214	Prowler	95	1	3	Steve Harris	255634	4091904	0.99
1215	Transylvania	95	1	3	Steve Harris	265874	4255744	0.99
1216	Remember Tomorrow	95	1	3	Paul Di'Anno/Steve Harris	352731	5648438	0.99
1217	Where Eagles Dare	95	1	3	Steve Harris	289358	4630528	0.99
1218	Sanctuary	95	1	3	David Murray/Paul Di'Anno/Steve Harris	293250	4694016	0.99
1219	Running Free	95	1	3	Paul Di'Anno/Steve Harris	228937	3663872	0.99
1220	Run To The Hilss	95	1	3	Steve Harris	237557	3803136	0.99
1221	2 Minutes To Midnight	95	1	3	Adrian Smith/Bruce Dickinson	337423	5400576	0.99
1222	Iron Maiden	95	1	3	Steve Harris	324623	5195776	0.99
1223	Hallowed Be Thy Name	95	1	3	Steve Harris	471849	7550976	0.99
1224	Be Quick Or Be Dead	96	1	3	Bruce Dickinson/Janick Gers	196911	3151872	0.99
1225	From Here To Eternity	96	1	3	Steve Harris	259866	4159488	0.99
1226	Can I Play With Madness	96	1	3	Adrian Smith/Bruce Dickinson/Steve Harris	282488	4521984	0.99
1227	Wasting Love	96	1	3	Bruce Dickinson/Janick Gers	347846	5566464	0.99
1228	Tailgunner	96	1	3	Bruce Dickinson/Steve Harris	249469	3993600	0.99
1229	The Evil That Men Do	96	1	3	Adrian Smith/Bruce Dickinson/Steve Harris	325929	5216256	0.99
1230	Afraid To Shoot Strangers	96	1	3	Steve Harris	407980	6529024	0.99
1231	Bring Your Daughter... To The Slaughter	96	1	3	Bruce Dickinson	317727	5085184	0.99
1232	Heaven Can Wait	96	1	3	Steve Harris	448574	7178240	0.99
1233	The Clairvoyant	96	1	3	Steve Harris	269871	4319232	0.99
1234	Fear Of The Dark	96	1	3	Steve Harris	431333	6906078	0.99
1235	The Wicker Man	97	1	1	Adrian Smith/Bruce Dickinson/Steve Harris	275539	11022464	0.99
1236	Ghost Of The Navigator	97	1	1	Bruce Dickinson/Janick Gers/Steve Harris	410070	16404608	0.99
1237	Brave New World	97	1	1	Bruce Dickinson/David Murray/Steve Harris	378984	15161472	0.99
1238	Blood Brothers	97	1	1	Steve Harris	434442	17379456	0.99
1239	The Mercenary	97	1	1	Janick Gers/Steve Harris	282488	11300992	0.99
1240	Dream Of Mirrors	97	1	1	Janick Gers/Steve Harris	561162	22448256	0.99
1241	The Fallen Angel	97	1	1	Adrian Smith/Steve Harris	240718	9629824	0.99
1242	The Nomad	97	1	1	David Murray/Steve Harris	546115	21846144	0.99
1243	Out Of The Silent Planet	97	1	1	Bruce Dickinson/Janick Gers/Steve Harris	385541	15423616	0.99
1244	The Thin Line Between Love & Hate	97	1	1	David Murray/Steve Harris	506801	20273280	0.99
1245	Wildest Dreams	98	1	13	Adrian Smith/Steve Harris	232777	9312384	0.99
1246	Rainmaker	98	1	13	Bruce Dickinson/David Murray/Steve Harris	228623	9146496	0.99
1247	No More Lies	98	1	13	Steve Harris	441782	17672320	0.99
1248	Montsegur	98	1	13	Bruce Dickinson/Janick Gers/Steve Harris	350484	14020736	0.99
1249	Dance Of Death	98	1	13	Janick Gers/Steve Harris	516649	20670727	0.99
1250	Gates Of Tomorrow	98	1	13	Bruce Dickinson/Janick Gers/Steve Harris	312032	12482688	0.99
1251	New Frontier	98	1	13	Adrian Smith/Bruce Dickinson/Nicko McBrain	304509	12181632	0.99
1252	Paschendale	98	1	13	Adrian Smith/Steve Harris	508107	20326528	0.99
1253	Face In The Sand	98	1	13	Adrian Smith/Bruce Dickinson/Steve Harris	391105	15648948	0.99
1254	Age Of Innocence	98	1	13	David Murray/Steve Harris	370468	14823478	0.99
1255	Journeyman	98	1	13	Bruce Dickinson/David Murray/Steve Harris	427023	17082496	0.99
1256	Be Quick Or Be Dead	99	1	1	Bruce Dickinson/Janick Gers	204512	8181888	0.99
1257	From Here To Eternity	99	1	1	Steve Harris	218357	8739038	0.99
1258	Afraid To Shoot Strangers	99	1	1	Steve Harris	416496	16664589	0.99
1259	Fear Is The Key	99	1	1	Bruce Dickinson/Janick Gers	335307	13414528	0.99
1260	Childhood's End	99	1	1	Steve Harris	280607	11225216	0.99
1261	Wasting Love	99	1	1	Bruce Dickinson/Janick Gers	350981	14041216	0.99
1262	The Fugitive	99	1	1	Steve Harris	294112	11765888	0.99
1263	Chains Of Misery	99	1	1	Bruce Dickinson/David Murray	217443	8700032	0.99
1264	The Apparition	99	1	1	Janick Gers/Steve Harris	234605	9386112	0.99
1265	Judas Be My Guide	99	1	1	Bruce Dickinson/David Murray	188786	7553152	0.99
1266	Weekend Warrior	99	1	1	Janick Gers/Steve Harris	339748	13594678	0.99
1267	Fear Of The Dark	99	1	1	Steve Harris	436976	17483789	0.99
1268	01 - Prowler	100	1	6	Steve Harris	236173	5668992	0.99
1269	02 - Sanctuary	100	1	6	David Murray/Paul Di'Anno/Steve Harris	196284	4712576	0.99
1270	03 - Remember Tomorrow	100	1	6	Harris/Paul Di�Anno	328620	7889024	0.99
1271	04 - Running Free	100	1	6	Harris/Paul Di�Anno	197276	4739122	0.99
1272	05 - Phantom of the Opera	100	1	6	Steve Harris	428016	10276872	0.99
1273	06 - Transylvania	100	1	6	Steve Harris	259343	6226048	0.99
1274	07 - Strange World	100	1	6	Steve Harris	332460	7981184	0.99
1275	08 - Charlotte the Harlot	100	1	6	Murray  Dave	252708	6066304	0.99
1276	09 - Iron Maiden	100	1	6	Steve Harris	216058	5189891	0.99
1277	The Ides Of March	101	1	13	Steve Harris	105926	2543744	0.99
1278	Wrathchild	101	1	13	Steve Harris	174471	4188288	0.99
1279	Murders In The Rue Morgue	101	1	13	Steve Harris	258377	6205786	0.99
1280	Another Life	101	1	13	Steve Harris	203049	4874368	0.99
1281	Genghis Khan	101	1	13	Steve Harris	187141	4493440	0.99
1282	Innocent Exile	101	1	13	Di�Anno/Harris	232515	5584861	0.99
1283	Killers	101	1	13	Steve Harris	300956	7227440	0.99
1284	Prodigal Son	101	1	13	Steve Harris	372349	8937600	0.99
1285	Purgatory	101	1	13	Steve Harris	200150	4804736	0.99
1286	Drifter	101	1	13	Steve Harris	288757	6934660	0.99
1287	Intro- Churchill S Speech	102	1	13	\N	48013	1154488	0.99
1288	Aces High	102	1	13	\N	276375	6635187	0.99
1289	2 Minutes To Midnight	102	1	3	Smith/Dickinson	366550	8799380	0.99
1290	The Trooper	102	1	3	Harris	268878	6455255	0.99
1291	Revelations	102	1	3	Dickinson	371826	8926021	0.99
1292	Flight Of Icarus	102	1	3	Smith/Dickinson	229982	5521744	0.99
1293	Rime Of The Ancient Mariner	102	1	3	\N	789472	18949518	0.99
1294	Powerslave	102	1	3	\N	454974	10921567	0.99
1295	The Number Of The Beast	102	1	3	Harris	275121	6605094	0.99
1296	Hallowed Be Thy Name	102	1	3	Harris	451422	10836304	0.99
1297	Iron Maiden	102	1	3	Harris	261955	6289117	0.99
1298	Run To The Hills	102	1	3	Harris	231627	5561241	0.99
1299	Running Free	102	1	3	Harris/Di Anno	204617	4912986	0.99
1300	Wrathchild	102	1	13	Steve Harris	183666	4410181	0.99
1301	Acacia Avenue	102	1	13	\N	379872	9119118	0.99
1302	Children Of The Damned	102	1	13	Steve Harris	278177	6678446	0.99
1303	Die With Your Boots On	102	1	13	Adrian Smith/Bruce Dickinson/Steve Harris	314174	7542367	0.99
1304	Phantom Of The Opera	102	1	13	Steve Harris	441155	10589917	0.99
1305	Be Quick Or Be Dead	103	1	1	\N	233142	5599853	0.99
1306	The Number Of The Beast	103	1	1	\N	294008	7060625	0.99
1307	Wrathchild	103	1	1	\N	174106	4182963	0.99
1308	From Here To Eternity	103	1	1	\N	284447	6831163	0.99
1309	Can I Play With Madness	103	1	1	\N	213106	5118995	0.99
1310	Wasting Love	103	1	1	\N	336953	8091301	0.99
1311	Tailgunner	103	1	1	\N	247640	5947795	0.99
1312	The Evil That Men Do	103	1	1	\N	478145	11479913	0.99
1313	Afraid To Shoot Strangers	103	1	1	\N	412525	9905048	0.99
1314	Fear Of The Dark	103	1	1	\N	431542	10361452	0.99
1315	Bring Your Daughter... To The Slaughter...	104	1	1	\N	376711	9045532	0.99
1316	The Clairvoyant	104	1	1	\N	262426	6302648	0.99
1317	Heaven Can Wait	104	1	1	\N	440555	10577743	0.99
1318	Run To The Hills	104	1	1	\N	235859	5665052	0.99
1319	2 Minutes To Midnight	104	1	1	Adrian Smith/Bruce Dickinson	338233	8122030	0.99
1320	Iron Maiden	104	1	1	\N	494602	11874875	0.99
1321	Hallowed Be Thy Name	104	1	1	\N	447791	10751410	0.99
1322	The Trooper	104	1	1	\N	232672	5588560	0.99
1323	Sanctuary	104	1	1	\N	318511	7648679	0.99
1324	Running Free	104	1	1	\N	474017	11380851	0.99
1325	Tailgunner	105	1	3	Bruce Dickinson/Steve Harris	255582	4089856	0.99
1326	Holy Smoke	105	1	3	Bruce Dickinson/Steve Harris	229459	3672064	0.99
1327	No Prayer For The Dying	105	1	3	Steve Harris	263941	4225024	0.99
1328	Public Enema Number One	105	1	3	Bruce Dickinson/David Murray	254197	4071587	0.99
1329	Fates Warning	105	1	3	David Murray/Steve Harris	250853	4018088	0.99
1330	The Assassin	105	1	3	Steve Harris	258768	4141056	0.99
1331	Run Silent Run Deep	105	1	3	Bruce Dickinson/Steve Harris	275408	4407296	0.99
1332	Hooks In You	105	1	3	Adrian Smith/Bruce Dickinson	247510	3960832	0.99
1333	Bring Your Daughter... ...To The Slaughter	105	1	3	Bruce Dickinson	284238	4548608	0.99
1334	Mother Russia	105	1	3	Steve Harris	332617	5322752	0.99
1335	Where Eagles Dare	106	1	3	Steve Harris	369554	5914624	0.99
1336	Revelations	106	1	3	Bruce Dickinson	408607	6539264	0.99
1337	Flight Of The Icarus	106	1	3	Adrian Smith/Bruce Dickinson	230269	3686400	0.99
1338	Die With Your Boots On	106	1	3	Adrian Smith/Bruce Dickinson/Steve Harris	325694	5212160	0.99
1339	The Trooper	106	1	3	Steve Harris	251454	4024320	0.99
1340	Still Life	106	1	3	David Murray/Steve Harris	294347	4710400	0.99
1341	Quest For Fire	106	1	3	Steve Harris	221309	3543040	0.99
1342	Sun And Steel	106	1	3	Adrian Smith/Bruce Dickinson	206367	3306324	0.99
1343	To Tame A Land	106	1	3	Steve Harris	445283	7129264	0.99
1344	Aces High	107	1	3	Harris	269531	6472088	0.99
1345	2 Minutes To Midnight	107	1	3	Smith/Dickinson	359810	8638809	0.99
1346	Losfer Words	107	1	3	Steve Harris	252891	6074756	0.99
1347	Flash of The Blade	107	1	3	Dickinson	242729	5828861	0.99
1348	Duelists	107	1	3	Steve Harris	366471	8800686	0.99
1349	Back in the Village	107	1	3	Dickinson/Smith	320548	7696518	0.99
1350	Powerslave	107	1	3	Dickinson	407823	9791106	0.99
1351	Rime of the Ancient Mariner	107	1	3	Harris	816509	19599577	0.99
1352	Intro	108	1	3	\N	115931	4638848	0.99
1353	The Wicker Man	108	1	3	Adrian Smith/Bruce Dickinson/Steve Harris	281782	11272320	0.99
1354	Ghost Of The Navigator	108	1	3	Bruce Dickinson/Janick Gers/Steve Harris	408607	16345216	0.99
1355	Brave New World	108	1	3	Bruce Dickinson/David Murray/Steve Harris	366785	14676148	0.99
1356	Wrathchild	108	1	3	Steve Harris	185808	7434368	0.99
1357	2 Minutes To Midnight	108	1	3	Adrian Smith/Bruce Dickinson	386821	15474816	0.99
1358	Blood Brothers	108	1	3	Steve Harris	435513	17422464	0.99
1359	Sign Of The Cross	108	1	3	Steve Harris	649116	25966720	0.99
1360	The Mercenary	108	1	3	Janick Gers/Steve Harris	282697	11309184	0.99
1361	The Trooper	108	1	3	Steve Harris	273528	10942592	0.99
1362	Dream Of Mirrors	109	1	1	Janick Gers/Steve Harris	578324	23134336	0.99
1363	The Clansman	109	1	1	Steve Harris	559203	22370432	0.99
1364	The Evil That Men Do	109	1	3	Adrian Smith/Bruce Dickinson/Steve Harris	280737	11231360	0.99
1365	Fear Of The Dark	109	1	1	Steve Harris	460695	18430080	0.99
1366	Iron Maiden	109	1	1	Steve Harris	351869	14076032	0.99
1367	The Number Of The Beast	109	1	1	Steve Harris	300434	12022107	0.99
1368	Hallowed Be Thy Name	109	1	1	Steve Harris	443977	17760384	0.99
1369	Sanctuary	109	1	1	David Murray/Paul Di'Anno/Steve Harris	317335	12695680	0.99
1370	Run To The Hills	109	1	1	Steve Harris	292179	11688064	0.99
1371	Moonchild	110	1	3	Adrian Smith; Bruce Dickinson	340767	8179151	0.99
1372	Infinite Dreams	110	1	3	Steve Harris	369005	8858669	0.99
1373	Can I Play With Madness	110	1	3	Adrian Smith; Bruce Dickinson; Steve Harris	211043	5067867	0.99
1374	The Evil That Men Do	110	1	3	Adrian Smith; Bruce Dickinson; Steve Harris	273998	6578930	0.99
1375	Seventh Son of a Seventh Son	110	1	3	Steve Harris	593580	14249000	0.99
1376	The Prophecy	110	1	3	Dave Murray; Steve Harris	305475	7334450	0.99
1377	The Clairvoyant	110	1	3	Adrian Smith; Bruce Dickinson; Steve Harris	267023	6411510	0.99
1378	Only the Good Die Young	110	1	3	Bruce Dickinson; Harris	280894	6744431	0.99
1379	Caught Somewhere in Time	111	1	3	Steve Harris	445779	10701149	0.99
1380	Wasted Years	111	1	3	Adrian Smith	307565	7384358	0.99
1381	Sea of Madness	111	1	3	Adrian Smith	341995	8210695	0.99
1382	Heaven Can Wait	111	1	3	Steve Harris	441417	10596431	0.99
1383	Stranger in a Strange Land	111	1	3	Adrian Smith	344502	8270899	0.99
1384	Alexander the Great	111	1	3	Steve Harris	515631	12377742	0.99
1385	De Ja Vu	111	1	3	David Murray/Steve Harris	296176	7113035	0.99
1386	The Loneliness of the Long Dis	111	1	3	Steve Harris	391314	9393598	0.99
1387	22 Acacia Avenue	112	1	3	Adrian Smith/Steve Harris	395572	5542516	0.99
1388	Children of the Damned	112	1	3	Steve Harris	274364	3845631	0.99
1389	Gangland	112	1	3	Adrian Smith/Clive Burr/Steve Harris	228440	3202866	0.99
1390	Hallowed Be Thy Name	112	1	3	Steve Harris	428669	6006107	0.99
1391	Invaders	112	1	3	Steve Harris	203180	2849181	0.99
1392	Run to the Hills	112	1	3	Steve Harris	228884	3209124	0.99
1393	The Number Of The Beast	112	1	1	Steve Harris	293407	11737216	0.99
1394	The Prisoner	112	1	3	Adrian Smith/Steve Harris	361299	5062906	0.99
1395	Sign Of The Cross	113	1	1	Steve Harris	678008	27121792	0.99
1396	Lord Of The Flies	113	1	1	Janick Gers/Steve Harris	303699	12148864	0.99
1397	Man On The Edge	113	1	1	Blaze Bayley/Janick Gers	253413	10137728	0.99
1398	Fortunes Of War	113	1	1	Steve Harris	443977	17760384	0.99
1399	Look For The Truth	113	1	1	Blaze Bayley/Janick Gers/Steve Harris	310230	12411008	0.99
1400	The Aftermath	113	1	1	Blaze Bayley/Janick Gers/Steve Harris	380786	15233152	0.99
1401	Judgement Of Heaven	113	1	1	Steve Harris	312476	12501120	0.99
1402	Blood On The World's Hands	113	1	1	Steve Harris	357799	14313600	0.99
1403	The Edge Of Darkness	113	1	1	Blaze Bayley/Janick Gers/Steve Harris	399333	15974528	0.99
1404	2 A.M.	113	1	1	Blaze Bayley/Janick Gers/Steve Harris	337658	13511087	0.99
1405	The Unbeliever	113	1	1	Janick Gers/Steve Harris	490422	19617920	0.99
1406	Futureal	114	1	1	Blaze Bayley/Steve Harris	175777	7032960	0.99
1407	The Angel And The Gambler	114	1	1	Steve Harris	592744	23711872	0.99
1408	Lightning Strikes Twice	114	1	1	David Murray/Steve Harris	290377	11616384	0.99
1409	The Clansman	114	1	1	Steve Harris	539689	21592327	0.99
1410	When Two Worlds Collide	114	1	1	Blaze Bayley/David Murray/Steve Harris	377312	15093888	0.99
1411	The Educated Fool	114	1	1	Steve Harris	404767	16191616	0.99
1412	Don't Look To The Eyes Of A Stranger	114	1	1	Steve Harris	483657	19347584	0.99
1413	Como Estais Amigos	114	1	1	Blaze Bayley/Janick Gers	330292	13213824	0.99
1414	Please Please Please	115	1	14	James Brown/Johnny Terry	165067	5394585	0.99
1415	Think	115	1	14	Lowman Pauling	166739	5513208	0.99
1416	Night Train	115	1	14	Jimmy Forrest/Lewis C. Simpkins/Oscar Washington	212401	7027377	0.99
1417	Out Of Sight	115	1	14	Ted Wright	143725	4711323	0.99
1418	Papa's Got A Brand New Bag Pt.1	115	1	14	James Brown	127399	4174420	0.99
1419	I Got You (I Feel Good)	115	1	14	James Brown	167392	5468472	0.99
1420	It's A Man's Man's Man's World	115	1	14	Betty Newsome/James Brown	168228	5541611	0.99
1421	Cold Sweat	115	1	14	Alfred Ellis/James Brown	172408	5643213	0.99
1422	Say It Loud, I'm Black And I'm Proud Pt.1	115	1	14	Alfred Ellis/James Brown	167392	5478117	0.99
1423	Get Up (I Feel Like Being A) Sex Machine	115	1	14	Bobby Byrd/James Brown/Ron Lenhoff	316551	10498031	0.99
1424	Hey America	115	1	14	Addie William Jones/Nat Jones	218226	7187857	0.99
1425	Make It Funky Pt.1	115	1	14	Charles Bobbitt/James Brown	196231	6507782	0.99
1426	I'm A Greedy Man Pt.1	115	1	14	Charles Bobbitt/James Brown	217730	7251211	0.99
1427	Get On The Good Foot	115	1	14	Fred Wesley/James Brown/Joseph Mims	215902	7182736	0.99
1428	Get Up Offa That Thing	115	1	14	Deanna Brown/Deidra Jenkins/Yamma Brown	250723	8355989	0.99
1429	It's Too Funky In Here	115	1	14	Brad Shapiro/George Jackson/Robert Miller/Walter Shaw	239072	7973979	0.99
1430	Living In America	115	1	14	Charlie Midnight/Dan Hartman	282880	9432346	0.99
1431	I'm Real	115	1	14	Full Force/James Brown	334236	11183457	0.99
1432	Hot Pants Pt.1	115	1	14	Fred Wesley/James Brown	188212	6295110	0.99
1433	Soul Power (Live)	115	1	14	James Brown	260728	8593206	0.99
1434	When You Gonna Learn (Digeridoo)	116	1	1	Jay Kay/Kay, Jay	230635	7655482	0.99
1435	Too Young To Die	116	1	1	Smith, Toby	365818	12391660	0.99
1436	Hooked Up	116	1	1	Smith, Toby	275879	9301687	0.99
1437	If I Like It, I Do It	116	1	1	Gelder, Nick van	293093	9848207	0.99
1438	Music Of The Wind	116	1	1	Smith, Toby	383033	12870239	0.99
1439	Emergency On Planet Earth	116	1	1	Smith, Toby	245263	8117218	0.99
1440	Whatever It Is, I Just Can't Stop	116	1	1	Jay Kay/Kay, Jay	247222	8249453	0.99
1441	Blow Your Mind	116	1	1	Smith, Toby	512339	17089176	0.99
1442	Revolution 1993	116	1	1	Smith, Toby	616829	20816872	0.99
1443	Didgin' Out	116	1	1	Buchanan, Wallis	157100	5263555	0.99
1444	Canned Heat	117	1	14	Jay Kay	331964	11042037	0.99
1445	Planet Home	117	1	14	Jay Kay/Toby Smith	284447	9566237	0.99
1446	Black Capricorn Day	117	1	14	Jay Kay	341629	11477231	0.99
1447	Soul Education	117	1	14	Jay Kay/Toby Smith	255477	8575435	0.99
1448	Failling	117	1	14	Jay Kay/Toby Smith	225227	7503999	0.99
1449	Destitute Illusions	117	1	14	Derrick McKenzie/Jay Kay/Toby Smith	340218	11452651	0.99
1450	Supersonic	117	1	14	Jay Kay	315872	10699265	0.99
1451	Butterfly	117	1	14	Jay Kay/Toby Smith	268852	8947356	0.99
1452	Were Do We Go From Here	117	1	14	Jay Kay	313626	10504158	0.99
1453	King For A Day	117	1	14	Jay Kay/Toby Smith	221544	7335693	0.99
1454	Deeper Underground	117	1	14	Toby Smith	281808	9351277	0.99
1455	Just Another Story	118	1	15	Toby Smith	529684	17582818	0.99
1456	Stillness In Time	118	1	15	Toby Smith	257097	8644290	0.99
1457	Half The Man	118	1	15	Toby Smith	289854	9577679	0.99
1458	Light Years	118	1	15	Toby Smith	354560	11796244	0.99
1459	Manifest Destiny	118	1	15	Toby Smith	382197	12676962	0.99
1460	The Kids	118	1	15	Toby Smith	309995	10334529	0.99
1461	Mr. Moon	118	1	15	Stuard Zender/Toby Smith	329534	11043559	0.99
1462	Scam	118	1	15	Stuart Zender	422321	14019705	0.99
1463	Journey To Arnhemland	118	1	15	Toby Smith/Wallis Buchanan	322455	10843832	0.99
1464	Morning Glory	118	1	15	J. Kay/Jay Kay	384130	12777210	0.99
1465	Space Cowboy	118	1	15	J. Kay/Jay Kay	385697	12906520	0.99
1466	Last Chance	119	1	4	C. Cester/C. Muncey	112352	3683130	0.99
1467	Are You Gonna Be My Girl	119	1	4	C. Muncey/N. Cester	213890	6992324	0.99
1468	Rollover D.J.	119	1	4	C. Cester/N. Cester	196702	6406517	0.99
1469	Look What You've Done	119	1	4	N. Cester	230974	7517083	0.99
1470	Get What You Need	119	1	4	C. Cester/C. Muncey/N. Cester	247719	8043765	0.99
1471	Move On	119	1	4	C. Cester/N. Cester	260623	8519353	0.99
1472	Radio Song	119	1	4	C. Cester/C. Muncey/N. Cester	272117	8871509	0.99
1473	Get Me Outta Here	119	1	4	C. Cester/N. Cester	176274	5729098	0.99
1474	Cold Hard Bitch	119	1	4	C. Cester/C. Muncey/N. Cester	243278	7929610	0.99
1475	Come Around Again	119	1	4	C. Muncey/N. Cester	270497	8872405	0.99
1476	Take It Or Leave It	119	1	4	C. Muncey/N. Cester	142889	4643370	0.99
1477	Lazy Gun	119	1	4	C. Cester/N. Cester	282174	9186285	0.99
1478	Timothy	119	1	4	C. Cester	270341	8856507	0.99
1479	Foxy Lady	120	1	1	Jimi Hendrix	199340	6480896	0.99
1480	Manic Depression	120	1	1	Jimi Hendrix	222302	7289272	0.99
1481	Red House	120	1	1	Jimi Hendrix	224130	7285851	0.99
1482	Can You See Me	120	1	1	Jimi Hendrix	153077	4987068	0.99
1483	Love Or Confusion	120	1	1	Jimi Hendrix	193123	6329408	0.99
1484	I Don't Live Today	120	1	1	Jimi Hendrix	235311	7661214	0.99
1485	May This Be Love	120	1	1	Jimi Hendrix	191216	6240028	0.99
1486	Fire	120	1	1	Jimi Hendrix	164989	5383075	0.99
1487	Third Stone From The Sun	120	1	1	Jimi Hendrix	404453	13186975	0.99
1488	Remember	120	1	1	Jimi Hendrix	168150	5509613	0.99
1489	Are You Experienced?	120	1	1	Jimi Hendrix	254537	8292497	0.99
1490	Hey Joe	120	1	1	Billy Roberts	210259	6870054	0.99
1491	Stone Free	120	1	1	Jimi Hendrix	216293	7002331	0.99
1492	Purple Haze	120	1	1	Jimi Hendrix	171572	5597056	0.99
1493	51st Anniversary	120	1	1	Jimi Hendrix	196388	6398044	0.99
1494	The Wind Cries Mary	120	1	1	Jimi Hendrix	200463	6540638	0.99
1495	Highway Chile	120	1	1	Jimi Hendrix	212453	6887949	0.99
1496	Surfing with the Alien	121	2	1	\N	263707	4418504	0.99
1497	Ice 9	121	2	1	\N	239721	4036215	0.99
1498	Crushing Day	121	2	1	\N	314768	5232158	0.99
1499	Always With Me, Always With You	121	2	1	\N	202035	3435777	0.99
1500	Satch Boogie	121	2	1	\N	193560	3300654	0.99
1501	Hill of the Skull	121	2	1	J. Satriani	108435	1944738	0.99
1502	Circles	121	2	1	\N	209071	3548553	0.99
1503	Lords of Karma	121	2	1	J. Satriani	288227	4809279	0.99
1504	Midnight	121	2	1	J. Satriani	102630	1851753	0.99
1505	Echo	121	2	1	J. Satriani	337570	5595557	0.99
1506	Engenho De Dentro	122	1	7	\N	310073	10211473	0.99
1507	Alcohol	122	1	7	\N	355239	12010478	0.99
1508	Mama Africa	122	1	7	\N	283062	9488316	0.99
1509	Salve Simpatia	122	1	7	\N	343484	11314756	0.99
1510	W/Brasil (Chama O S�ndico)	122	1	7	\N	317100	10599953	0.99
1511	Pa�s Tropical	122	1	7	\N	452519	14946972	0.99
1512	Os Alquimistas Est�o Chegando	122	1	7	\N	367281	12304520	0.99
1513	Charles Anjo 45	122	1	7	\N	389276	13022833	0.99
1514	Selassi�	122	1	7	\N	326321	10724982	0.99
1515	Menina Sarar�	122	1	7	\N	191477	6393818	0.99
1516	Que Maravilha	122	1	7	\N	338076	10996656	0.99
1517	Santa Clara Clareou	122	1	7	\N	380081	12524725	0.99
1518	Filho Maravilha	122	1	7	\N	227526	7498259	0.99
1519	Taj Mahal	122	1	7	\N	289750	9502898	0.99
1520	Rapidamente	123	1	7	\N	252238	8470107	0.99
1521	As Dores do Mundo	123	1	7	Hyldon	255477	8537092	0.99
1522	Vou Pra Ai	123	1	7	\N	300878	10053718	0.99
1523	My Brother	123	1	7	\N	253231	8431821	0.99
1524	H� Quanto Tempo	123	1	7	\N	270027	9004470	0.99
1525	V�cio	123	1	7	\N	269897	8887216	0.99
1526	Encontrar Algu�m	123	1	7	Marco Tulio Lara/Rogerio Flausino	224078	7437935	0.99
1527	Dance Enquanto � Tempo	123	1	7	\N	229093	7583799	0.99
1528	A Tarde	123	1	7	\N	266919	8836127	0.99
1529	Always Be All Right	123	1	7	\N	128078	4299676	0.99
1530	Sem Sentido	123	1	7	\N	250462	8292108	0.99
1531	Onibusfobia	123	1	7	\N	315977	10474904	0.99
1532	Pura Elegancia	124	1	16	Jo�o Suplicy	284107	9632269	0.99
1533	Choramingando	124	1	16	Jo�o Suplicy	190484	6400532	0.99
1534	Por Merecer	124	1	16	Jo�o Suplicy	230582	7764601	0.99
1535	No Futuro	124	1	16	Jo�o Suplicy	182308	6056200	0.99
1536	Voce Inteira	124	1	16	Jo�o Suplicy	241084	8077282	0.99
1537	Cuando A Noite Vai Chegando	124	1	16	Jo�o Suplicy	270628	9081874	0.99
1538	Naquele Dia	124	1	16	Jo�o Suplicy	251768	8452654	0.99
1539	Equinocio	124	1	16	Jo�o Suplicy	269008	8871455	0.99
1540	Papel�o	124	1	16	Jo�o Suplicy	213263	7257390	0.99
1541	Cuando Eu For Pro Ceu	124	1	16	Jo�o Suplicy	118804	3948371	0.99
1542	Do Nosso Amor	124	1	16	Jo�o Suplicy	203415	6774566	0.99
1543	Borogodo	124	1	16	Jo�o Suplicy	208457	7104588	0.99
1544	Cafezinho	124	1	16	Jo�o Suplicy	180924	6031174	0.99
1545	Enquanto O Dia N�o Vem	124	1	16	Jo�o Suplicy	220891	7248336	0.99
1546	The Green Manalishi	125	1	3	\N	205792	6720789	0.99
1547	Living After Midnight	125	1	3	\N	213289	7056785	0.99
1548	Breaking The Law (Live)	125	1	3	\N	144195	4728246	0.99
1549	Hot Rockin'	125	1	3	\N	197328	6509179	0.99
1550	Heading Out To The Highway (Live)	125	1	3	\N	276427	9006022	0.99
1551	The Hellion	125	1	3	\N	41900	1351993	0.99
1552	Electric Eye	125	1	3	\N	222197	7231368	0.99
1553	You've Got Another Thing Comin'	125	1	3	\N	305162	9962558	0.99
1554	Turbo Lover	125	1	3	\N	335542	11068866	0.99
1555	Freewheel Burning	125	1	3	\N	265952	8713599	0.99
1556	Some Heads Are Gonna Roll	125	1	3	\N	249939	8198617	0.99
1557	Metal Meltdown	125	1	3	\N	290664	9390646	0.99
1558	Ram It Down	125	1	3	\N	292179	9554023	0.99
1559	Diamonds And Rust (Live)	125	1	3	\N	219350	7163147	0.99
1560	Victim Of Change (Live)	125	1	3	\N	430942	14067512	0.99
1561	Tyrant (Live)	125	1	3	\N	282253	9190536	0.99
1562	Comin' Home	126	1	1	Paul Stanley, Ace Frehley	172068	5661120	0.99
1563	Plaster Caster	126	1	1	Gene Simmons	198060	6528719	0.99
1564	Goin' Blind	126	1	1	Gene Simmons, Stephen Coronel	217652	7167523	0.99
1565	Do You Love Me	126	1	1	Paul Stanley, Bob Ezrin, Kim Fowley	193619	6343111	0.99
1566	Domino	126	1	1	Gene Simmons	226377	7488191	0.99
1567	Sure Know Something	126	1	1	Paul Stanley, Vincent Poncia	254354	8375190	0.99
1568	A World Without Heroes	126	1	1	Paul Stanley, Gene Simmons, Bob Ezrin, Lewis Reed	177815	5832524	0.99
1569	Rock Bottom	126	1	1	Paul Stanley, Ace Frehley	200594	6560818	0.99
1570	See You Tonight	126	1	1	Gene Simmons	146494	4817521	0.99
1571	I Still Love You	126	1	1	Paul Stanley	369815	12086145	0.99
1572	Every Time I Look At You	126	1	1	Paul Stanley, Vincent Cusano	283898	9290948	0.99
1573	2,000 Man	126	1	1	Mick Jagger, Keith Richard	312450	10292829	0.99
1574	Beth	126	1	1	Peter Criss, Stan Penridge, Bob Ezrin	170187	5577807	0.99
1575	Nothin' To Lose	126	1	1	Gene Simmons	222354	7351460	0.99
1576	Rock And Roll All Nite	126	1	1	Paul Stanley, Gene Simmons	259631	8549296	0.99
1577	Immigrant Song	127	1	1	Robert Plant	201247	6457766	0.99
1578	Heartbreaker	127	1	1	John Bonham/John Paul Jones/Robert Plant	316081	10179657	0.99
1579	Since I've Been Loving You	127	1	1	John Paul Jones/Robert Plant	416365	13471959	0.99
1580	Black Dog	127	1	1	John Paul Jones/Robert Plant	317622	10267572	0.99
1581	Dazed And Confused	127	1	1	Jimmy Page/Led Zeppelin	1116734	36052247	0.99
1582	Stairway To Heaven	127	1	1	Robert Plant	529658	17050485	0.99
1583	Going To California	127	1	1	Robert Plant	234605	7646749	0.99
1584	That's The Way	127	1	1	Robert Plant	343431	11248455	0.99
1585	Whole Lotta Love (Medley)	127	1	1	Arthur Crudup/Bernard Besman/Bukka White/Doc Pomus/John Bonham/John Lee Hooker/John Paul Jones/Mort Shuman/Robert Plant/Willie Dixon	825103	26742545	0.99
1586	Thank You	127	1	1	Robert Plant	398262	12831826	0.99
1587	We're Gonna Groove	128	1	1	Ben E.King/James Bethea	157570	5180975	0.99
1588	Poor Tom	128	1	1	Jimmy Page/Robert Plant	182491	6016220	0.99
1589	I Can't Quit You Baby	128	1	1	Willie Dixon	258168	8437098	0.99
1590	Walter's Walk	128	1	1	Jimmy Page, Robert Plant	270785	8712499	0.99
1591	Ozone Baby	128	1	1	Jimmy Page, Robert Plant	215954	7079588	0.99
1592	Darlene	128	1	1	Jimmy Page, Robert Plant, John Bonham, John Paul Jones	307226	10078197	0.99
1593	Bonzo's Montreux	128	1	1	John Bonham	258925	8557447	0.99
1594	Wearing And Tearing	128	1	1	Jimmy Page, Robert Plant	330004	10701590	0.99
1595	The Song Remains The Same	129	1	1	Jimmy Page/Jimmy Page & Robert Plant/Robert Plant	330004	10708950	0.99
1596	The Rain Song	129	1	1	Jimmy Page/Jimmy Page & Robert Plant/Robert Plant	459180	15029875	0.99
1597	Over The Hills And Far Away	129	1	1	Jimmy Page/Jimmy Page & Robert Plant/Robert Plant	290089	9552829	0.99
1598	The Crunge	129	1	1	John Bonham/John Paul Jones	197407	6460212	0.99
1599	Dancing Days	129	1	1	Jimmy Page/Jimmy Page & Robert Plant/Robert Plant	223216	7250104	0.99
1600	D'Yer Mak'er	129	1	1	John Bonham/John Paul Jones	262948	8645935	0.99
1601	No Quarter	129	1	1	John Paul Jones	420493	13656517	0.99
1602	The Ocean	129	1	1	John Bonham/John Paul Jones	271098	8846469	0.99
1603	In The Evening	130	1	1	Jimmy Page, Robert Plant & John Paul Jones	410566	13399734	0.99
1604	South Bound Saurez	130	1	1	John Paul Jones & Robert Plant	254406	8420427	0.99
1605	Fool In The Rain	130	1	1	Jimmy Page, Robert Plant & John Paul Jones	372950	12371433	0.99
1606	Hot Dog	130	1	1	Jimmy Page & Robert Plant	197198	6536167	0.99
1607	Carouselambra	130	1	1	John Paul Jones, Jimmy Page & Robert Plant	634435	20858315	0.99
1608	All My Love	130	1	1	Robert Plant & John Paul Jones	356284	11684862	0.99
1609	I'm Gonna Crawl	130	1	1	Jimmy Page, Robert Plant & John Paul Jones	329639	10737665	0.99
1610	Black Dog	131	1	1	Jimmy Page, Robert Plant, John Paul Jones	296672	9660588	0.99
1611	Rock & Roll	131	1	1	Jimmy Page, Robert Plant, John Paul Jones, John Bonham	220917	7142127	0.99
1612	The Battle Of Evermore	131	1	1	Jimmy Page, Robert Plant	351555	11525689	0.99
1613	Stairway To Heaven	131	1	1	Jimmy Page, Robert Plant	481619	15706767	0.99
1614	Misty Mountain Hop	131	1	1	Jimmy Page, Robert Plant, John Paul Jones	278857	9092799	0.99
1615	Four Sticks	131	1	1	Jimmy Page, Robert Plant	284447	9481301	0.99
1616	Going To California	131	1	1	Jimmy Page, Robert Plant	215693	7068737	0.99
1617	When The Levee Breaks	131	1	1	Jimmy Page, Robert Plant, John Paul Jones, John Bonham, Memphis Minnie	427702	13912107	0.99
1618	Good Times Bad Times	132	1	1	Jimmy Page/John Bonham/John Paul Jones	166164	5464077	0.99
1619	Babe I'm Gonna Leave You	132	1	1	Jimmy Page/Robert Plant	401475	13189312	0.99
1620	You Shook Me	132	1	1	J. B. Lenoir/Willie Dixon	388179	12643067	0.99
1621	Dazed and Confused	132	1	1	Jimmy Page	386063	12610326	0.99
1622	Your Time Is Gonna Come	132	1	1	Jimmy Page/John Paul Jones	274860	9011653	0.99
1623	Black Mountain Side	132	1	1	Jimmy Page	132702	4440602	0.99
1624	Communication Breakdown	132	1	1	Jimmy Page/John Bonham/John Paul Jones	150230	4899554	0.99
1625	I Can't Quit You Baby	132	1	1	Willie Dixon	282671	9252733	0.99
1626	How Many More Times	132	1	1	Jimmy Page/John Bonham/John Paul Jones	508055	16541364	0.99
1627	Whole Lotta Love	133	1	1	Jimmy Page, Robert Plant, John Paul Jones, John Bonham	334471	11026243	0.99
1628	What Is And What Should Never Be	133	1	1	Jimmy Page, Robert Plant	287973	9369385	0.99
1629	The Lemon Song	133	1	1	Jimmy Page, Robert Plant, John Paul Jones, John Bonham	379141	12463496	0.99
1630	Thank You	133	1	1	Jimmy Page, Robert Plant	287791	9337392	0.99
1631	Heartbreaker	133	1	1	Jimmy Page, Robert Plant, John Paul Jones, John Bonham	253988	8387560	0.99
1632	Living Loving Maid (She's Just A Woman)	133	1	1	Jimmy Page, Robert Plant	159216	5219819	0.99
1633	Ramble On	133	1	1	Jimmy Page, Robert Plant	275591	9199710	0.99
1634	Moby Dick	133	1	1	John Bonham, John Paul Jones, Jimmy Page	260728	8664210	0.99
1635	Bring It On Home	133	1	1	Jimmy Page, Robert Plant	259970	8494731	0.99
1636	Immigrant Song	134	1	1	Jimmy Page, Robert Plant	144875	4786461	0.99
1637	Friends	134	1	1	Jimmy Page, Robert Plant	233560	7694220	0.99
1638	Celebration Day	134	1	1	Jimmy Page, Robert Plant, John Paul Jones	209528	6871078	0.99
1639	Since I've Been Loving You	134	1	1	Jimmy Page, Robert Plant, John Paul Jones	444055	14482460	0.99
1640	Out On The Tiles	134	1	1	Jimmy Page, Robert Plant, John Bonham	246047	8060350	0.99
1641	Gallows Pole	134	1	1	Traditional	296228	9757151	0.99
1642	Tangerine	134	1	1	Jimmy Page	189675	6200893	0.99
1643	That's The Way	134	1	1	Jimmy Page, Robert Plant	337345	11202499	0.99
1644	Bron-Y-Aur Stomp	134	1	1	Jimmy Page, Robert Plant, John Paul Jones	259500	8674508	0.99
1645	Hats Off To (Roy) Harper	134	1	1	Traditional	219376	7236640	0.99
1646	In The Light	135	1	1	John Paul Jones/Robert Plant	526785	17033046	0.99
1647	Bron-Yr-Aur	135	1	1	Jimmy Page	126641	4150746	0.99
1648	Down By The Seaside	135	1	1	Robert Plant	316186	10371282	0.99
1649	Ten Years Gone	135	1	1	Robert Plant	393116	12756366	0.99
1650	Night Flight	135	1	1	John Paul Jones/Robert Plant	217547	7160647	0.99
1651	The Wanton Song	135	1	1	Robert Plant	249887	8180988	0.99
1652	Boogie With Stu	135	1	1	Ian Stewart/John Bonham/John Paul Jones/Mrs. Valens/Robert Plant	233273	7657086	0.99
1653	Black Country Woman	135	1	1	Robert Plant	273084	8951732	0.99
1654	Sick Again	135	1	1	Robert Plant	283036	9279263	0.99
1655	Achilles Last Stand	136	1	1	Jimmy Page/Robert Plant	625502	20593955	0.99
1656	For Your Life	136	1	1	Jimmy Page/Robert Plant	384391	12633382	0.99
1657	Royal Orleans	136	1	1	John Bonham/John Paul Jones	179591	5930027	0.99
1658	Nobody's Fault But Mine	136	1	1	Jimmy Page/Robert Plant	376215	12237859	0.99
1659	Candy Store Rock	136	1	1	Jimmy Page/Robert Plant	252055	8397423	0.99
1660	Hots On For Nowhere	136	1	1	Jimmy Page/Robert Plant	284107	9342342	0.99
1661	Tea For One	136	1	1	Jimmy Page/Robert Plant	566752	18475264	0.99
1662	Rock & Roll	137	1	1	John Bonham/John Paul Jones/Robert Plant	242442	7897065	0.99
1663	Celebration Day	137	1	1	John Paul Jones/Robert Plant	230034	7478487	0.99
1664	The Song Remains The Same	137	1	1	Robert Plant	353358	11465033	0.99
1665	Rain Song	137	1	1	Robert Plant	505808	16273705	0.99
1666	Dazed And Confused	137	1	1	Jimmy Page	1612329	52490554	0.99
1667	No Quarter	138	1	1	John Paul Jones/Robert Plant	749897	24399285	0.99
1668	Stairway To Heaven	138	1	1	Robert Plant	657293	21354766	0.99
1669	Moby Dick	138	1	1	John Bonham/John Paul Jones	766354	25345841	0.99
1670	Whole Lotta Love	138	1	1	John Bonham/John Paul Jones/Robert Plant/Willie Dixon	863895	28191437	0.99
1671	Nat�lia	139	1	7	Renato Russo	235728	7640230	0.99
1672	L'Avventura	139	1	7	Renato Russo	278256	9165769	0.99
1673	M�sica De Trabalho	139	1	7	Renato Russo	260231	8590671	0.99
1674	Longe Do Meu Lado	139	1	7	Renato Russo - Marcelo Bonf�	266161	8655249	0.99
1675	A Via L�ctea	139	1	7	Renato Russo	280084	9234879	0.99
1676	M�sica Ambiente	139	1	7	Renato Russo	247614	8234388	0.99
1677	Aloha	139	1	7	Renato Russo	325955	10793301	0.99
1678	Soul Parsifal	139	1	7	Renato Russo - Marisa Monte	295053	9853589	0.99
1679	Dezesseis	139	1	7	Renato Russo	323918	10573515	0.99
1680	Mil Peda�os	139	1	7	Renato Russo	203337	6643291	0.99
1681	Leila	139	1	7	Renato Russo	323056	10608239	0.99
1682	1� De Julho	139	1	7	Renato Russo	290298	9619257	0.99
1683	Esperando Por Mim	139	1	7	Renato Russo	261668	8844133	0.99
1684	Quando Voc� Voltar	139	1	7	Renato Russo	173897	5781046	0.99
1685	O Livro Dos Dias	139	1	7	Renato Russo	257253	8570929	0.99
1686	Ser�	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	148401	4826528	0.99
1687	Ainda � Cedo	140	1	7	Dado Villa-Lobos/Ico Ouro-Preto/Marcelo Bonf�	236826	7796400	0.99
1688	Gera��o Coca-Cola	140	1	7	Renato Russo	141453	4625731	0.99
1689	Eduardo E M�nica	140	1	7	Renato Russo	271229	9026691	0.99
1690	Tempo Perdido	140	1	7	Renato Russo	302158	9963914	0.99
1691	Indios	140	1	7	Renato Russo	258168	8610226	0.99
1692	Que Pa�s � Este	140	1	7	Renato Russo	177606	5822124	0.99
1693	Faroeste Caboclo	140	1	7	Renato Russo	543007	18092739	0.99
1694	H� Tempos	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	197146	6432922	0.99
1695	Pais E Filhos	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	308401	10130685	0.99
1696	Meninos E Meninas	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	203781	6667802	0.99
1697	Vento No Litoral	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	366445	12063806	0.99
1698	Perfei��o	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	276558	9258489	0.99
1699	Giz	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	202213	6677671	0.99
1700	Dezesseis	140	1	7	Dado Villa-Lobos/Marcelo Bonf�	321724	10501773	0.99
1701	Antes Das Seis	140	1	7	Dado Villa-Lobos	189231	6296531	0.99
1702	Are You Gonna Go My Way	141	1	1	Craig Ross/Lenny Kravitz	211591	6905135	0.99
1703	Fly Away	141	1	1	Lenny Kravitz	221962	7322085	0.99
1704	Rock And Roll Is Dead	141	1	1	Lenny Kravitz	204199	6680312	0.99
1705	Again	141	1	1	Lenny Kravitz	228989	7490476	0.99
1706	It Ain't Over 'Til It's Over	141	1	1	Lenny Kravitz	242703	8078936	0.99
1707	Can't Get You Off My Mind	141	1	1	Lenny Kravitz	273815	8937150	0.99
1708	Mr. Cab Driver	141	1	1	Lenny Kravitz	230321	7668084	0.99
1709	American Woman	141	1	1	B. Cummings/G. Peterson/M.J. Kale/R. Bachman	261773	8538023	0.99
1710	Stand By My Woman	141	1	1	Henry Kirssch/Lenny Kravitz/S. Pasch A. Krizan	259683	8447611	0.99
1711	Always On The Run	141	1	1	Lenny Kravitz/Slash	232515	7593397	0.99
1712	Heaven Help	141	1	1	Gerry DeVeaux/Terry Britten	190354	6222092	0.99
1713	I Belong To You	141	1	1	Lenny Kravitz	257123	8477980	0.99
1714	Believe	141	1	1	Henry Hirsch/Lenny Kravitz	295131	9661978	0.99
1715	Let Love Rule	141	1	1	Lenny Kravitz	342648	11298085	0.99
1716	Black Velveteen	141	1	1	Lenny Kravitz	290899	9531301	0.99
1717	Assim Caminha A Humanidade	142	1	7	\N	210755	6993763	0.99
1718	Honolulu	143	1	7	\N	261433	8558481	0.99
1719	Dancin�Days	143	1	7	\N	237400	7875347	0.99
1720	Um Pro Outro	142	1	7	\N	236382	7825215	0.99
1721	Aviso Aos Navegantes	143	1	7	\N	242808	8058651	0.99
1722	Casa	142	1	7	\N	307591	10107269	0.99
1723	Condi��o	142	1	7	\N	263549	8778465	0.99
1724	Hyperconectividade	143	1	7	\N	180636	5948039	0.99
1725	O Descobridor Dos Sete Mares	143	1	7	\N	225854	7475780	0.99
1726	Satisfa��o	142	1	7	\N	208065	6901681	0.99
1727	Brum�rio	142	1	7	\N	216241	7243499	0.99
1728	Um Certo Algu�m	143	1	7	\N	194063	6430939	0.99
1729	Fullg�s	143	1	7	\N	346070	11505484	0.99
1730	S�bado � Noite	142	1	7	\N	193854	6435114	0.99
1731	A Cura	142	1	7	\N	280920	9260588	0.99
1732	Aquilo	143	1	7	\N	246073	8167819	0.99
1733	Atr�s Do Trio El�trico	142	1	7	\N	149080	4917615	0.99
1734	Senta A Pua	143	1	7	\N	217547	7205844	0.99
1735	Ro-Que-Se-Da-Ne	143	1	7	\N	146703	4805897	0.99
1736	Tudo Bem	142	1	7	\N	196101	6419139	0.99
1737	Toda Forma De Amor	142	1	7	\N	227813	7496584	0.99
1738	Tudo Igual	143	1	7	\N	276035	9201645	0.99
1739	Fogo De Palha	143	1	7	\N	246804	8133732	0.99
1740	Sereia	142	1	7	\N	278047	9121087	0.99
1741	Assaltaram A Gram�tica	143	1	7	\N	261041	8698959	0.99
1742	Se Voc� Pensa	142	1	7	\N	195996	6552490	0.99
1743	L� Vem O Sol (Here Comes The Sun)	142	1	7	\N	189492	6229645	0.99
1744	O �ltimo Rom�ntico (Ao Vivo)	143	1	7	\N	231993	7692697	0.99
1745	Pseudo Silk Kimono	144	1	1	Kelly, Mosley, Rothery, Trewaves	134739	4334038	0.99
1746	Kayleigh	144	1	1	Kelly, Mosley, Rothery, Trewaves	234605	7716005	0.99
1747	Lavender	144	1	1	Kelly, Mosley, Rothery, Trewaves	153417	4999814	0.99
1748	Bitter Suite: Brief Encounter / Lost Weekend / Blue Angel	144	1	1	Kelly, Mosley, Rothery, Trewaves	356493	11791068	0.99
1749	Heart Of Lothian: Wide Boy / Curtain Call	144	1	1	Kelly, Mosley, Rothery, Trewaves	366053	11893723	0.99
1750	Waterhole (Expresso Bongo)	144	1	1	Kelly, Mosley, Rothery, Trewaves	133093	4378835	0.99
1751	Lords Of The Backstage	144	1	1	Kelly, Mosley, Rothery, Trewaves	112875	3741319	0.99
1752	Blind Curve: Vocal Under A Bloodlight / Passing Strangers / Mylo / Perimeter Walk / Threshold	144	1	1	Kelly, Mosley, Rothery, Trewaves	569704	18578995	0.99
1753	Childhoods End?	144	1	1	Kelly, Mosley, Rothery, Trewaves	272796	9015366	0.99
1754	White Feather	144	1	1	Kelly, Mosley, Rothery, Trewaves	143595	4711776	0.99
1755	Arrepio	145	1	7	Carlinhos Brown	136254	4511390	0.99
1756	Magamalabares	145	1	7	Carlinhos Brown	215875	7183757	0.99
1757	Chuva No Brejo	145	1	7	Morais	145606	4857761	0.99
1758	C�rebro Eletr�nico	145	1	7	Gilberto Gil	172800	5760864	0.99
1759	Tempos Modernos	145	1	7	Lulu Santos	183066	6066234	0.99
1760	Mara��	145	1	7	Carlinhos Brown	230008	7621482	0.99
1761	Blanco	145	1	7	Marisa Monte/poema de Octavio Paz/vers�o: Haroldo de Campos	45191	1454532	0.99
1762	Panis Et Circenses	145	1	7	Caetano Veloso e Gilberto Gil	192339	6318373	0.99
1763	De Noite Na Cama	145	1	7	Caetano Veloso e Gilberto Gil	209005	7012658	0.99
1764	Beija Eu	145	1	7	Caetano Veloso e Gilberto Gil	197276	6512544	0.99
1765	Give Me Love	145	1	7	Caetano Veloso e Gilberto Gil	249808	8196331	0.99
1766	Ainda Lembro	145	1	7	Caetano Veloso e Gilberto Gil	218801	7211247	0.99
1767	A Menina Dan�a	145	1	7	Caetano Veloso e Gilberto Gil	129410	4326918	0.99
1768	Dan�a Da Solid�o	145	1	7	Caetano Veloso e Gilberto Gil	203520	6699368	0.99
1769	Ao Meu Redor	145	1	7	Caetano Veloso e Gilberto Gil	275591	9158834	0.99
1770	Bem Leve	145	1	7	Caetano Veloso e Gilberto Gil	159190	5246835	0.99
1771	Segue O Seco	145	1	7	Caetano Veloso e Gilberto Gil	178207	5922018	0.99
1772	O Xote Das Meninas	145	1	7	Caetano Veloso e Gilberto Gil	291866	9553228	0.99
1773	Wherever I Lay My Hat	146	1	14	\N	136986	4477321	0.99
1774	Get My Hands On Some Lovin'	146	1	14	\N	149054	4860380	0.99
1775	No Good Without You	146	1	14	William "Mickey" Stevenson	161410	5259218	0.99
1776	You've Been A Long Time Coming	146	1	14	Brian Holland/Eddie Holland/Lamont Dozier	137221	4437949	0.99
1777	When I Had Your Love	146	1	14	Robert Rogers/Warren "Pete" Moore/William "Mickey" Stevenson	152424	4972815	0.99
1778	You're What's Happening (In The World Today)	146	1	14	Allen Story/George Gordy/Robert Gordy	142027	4631104	0.99
1779	Loving You Is Sweeter Than Ever	146	1	14	Ivy Hunter/Stevie Wonder	166295	5377546	0.99
1780	It's A Bitter Pill To Swallow	146	1	14	Smokey Robinson/Warren "Pete" Moore	194821	6477882	0.99
1781	Seek And You Shall Find	146	1	14	Ivy Hunter/William "Mickey" Stevenson	223451	7306719	0.99
1782	Gonna Keep On Tryin' Till I Win Your Love	146	1	14	Barrett Strong/Norman Whitfield	176404	5789945	0.99
1783	Gonna Give Her All The Love I've Got	146	1	14	Barrett Strong/Norman Whitfield	210886	6893603	0.99
1784	I Wish It Would Rain	146	1	14	Barrett Strong/Norman Whitfield/Roger Penzabene	172486	5647327	0.99
1785	Abraham, Martin And John	146	1	14	Dick Holler	273057	8888206	0.99
1786	Save The Children	146	1	14	Al Cleveland/Marvin Gaye/Renaldo Benson	194821	6342021	0.99
1787	You Sure Love To Ball	146	1	14	Marvin Gaye	218540	7217872	0.99
1788	Ego Tripping Out	146	1	14	Marvin Gaye	314514	10383887	0.99
1789	Praise	146	1	14	Marvin Gaye	235833	7839179	0.99
1790	Heavy Love Affair	146	1	14	Marvin Gaye	227892	7522232	0.99
1791	Down Under	147	1	1	\N	222171	7366142	0.99
1792	Overkill	147	1	1	\N	225410	7408652	0.99
1793	Be Good Johnny	147	1	1	\N	216320	7139814	0.99
1794	Everything I Need	147	1	1	\N	216476	7107625	0.99
1795	Down by the Sea	147	1	1	\N	408163	13314900	0.99
1796	Who Can It Be Now?	147	1	1	\N	202396	6682850	0.99
1797	It's a Mistake	147	1	1	\N	273371	8979965	0.99
1798	Dr. Heckyll & Mr. Jive	147	1	1	\N	278465	9110403	0.99
1799	Shakes and Ladders	147	1	1	\N	198008	6560753	0.99
1800	No Sign of Yesterday	147	1	1	\N	362004	11829011	0.99
1801	Enter Sandman	148	1	3	James Hetfield, Lars Ulrich and Kirk Hammett	332251	10852002	0.99
1802	Sad But True	148	1	3	Ulrich	324754	10541258	0.99
1803	Holier Than Thou	148	1	3	Ulrich	227892	7462011	0.99
1804	The Unforgiven	148	1	3	James Hetfield, Lars Ulrich and Kirk Hammett	387082	12646886	0.99
1805	Wherever I May Roam	148	1	3	Ulrich	404323	13161169	0.99
1806	Don't Tread On Me	148	1	3	Ulrich	240483	7827907	0.99
1807	Through The Never	148	1	3	James Hetfield, Lars Ulrich and Kirk Hammett	244375	8024047	0.99
1808	Nothing Else Matters	148	1	3	Ulrich	388832	12606241	0.99
1809	Of Wolf And Man	148	1	3	James Hetfield, Lars Ulrich and Kirk Hammett	256835	8339785	0.99
1810	The God That Failed	148	1	3	Ulrich	308610	10055959	0.99
1811	My Friend Of Misery	148	1	3	James Hetfield, Lars Ulrich and Jason Newsted	409547	13293515	0.99
1812	The Struggle Within	148	1	3	Ulrich	234240	7654052	0.99
1813	Helpless	149	1	3	Harris/Tatler	398315	12977902	0.99
1814	The Small Hours	149	1	3	Holocaust	403435	13215133	0.99
1815	The Wait	149	1	3	Killing Joke	295418	9688418	0.99
1816	Crash Course In Brain Surgery	149	1	3	Bourge/Phillips/Shelley	190406	6233729	0.99
1817	Last Caress/Green Hell	149	1	3	Danzig	209972	6854313	0.99
1818	Am I Evil?	149	1	3	Harris/Tatler	470256	15387219	0.99
1819	Blitzkrieg	149	1	3	Jones/Sirotto/Smith	216685	7090018	0.99
1820	Breadfan	149	1	3	Bourge/Phillips/Shelley	341551	11100130	0.99
1821	The Prince	149	1	3	Harris/Tatler	265769	8624492	0.99
1822	Stone Cold Crazy	149	1	3	Deacon/May/Mercury/Taylor	137717	4514830	0.99
1823	So What	149	1	3	Culmer/Exalt	189152	6162894	0.99
1824	Killing Time	149	1	3	Sweet Savage	183693	6021197	0.99
1825	Overkill	149	1	3	Clarke/Kilmister/Tayler	245133	7971330	0.99
1826	Damage Case	149	1	3	Clarke/Farren/Kilmister/Tayler	220212	7212997	0.99
1827	Stone Dead Forever	149	1	3	Clarke/Kilmister/Tayler	292127	9556060	0.99
1828	Too Late Too Late	149	1	3	Clarke/Kilmister/Tayler	192052	6276291	0.99
1829	Hit The Lights	150	1	3	James Hetfield, Lars Ulrich	257541	8357088	0.99
1830	The Four Horsemen	150	1	3	James Hetfield, Lars Ulrich, Dave Mustaine	433188	14178138	0.99
1831	Motorbreath	150	1	3	James Hetfield	188395	6153933	0.99
1832	Jump In The Fire	150	1	3	James Hetfield, Lars Ulrich, Dave Mustaine	281573	9135755	0.99
1833	(Anesthesia) Pulling Teeth	150	1	3	Cliff Burton	254955	8234710	0.99
1834	Whiplash	150	1	3	James Hetfield, Lars Ulrich	249208	8102839	0.99
1835	Phantom Lord	150	1	3	James Hetfield, Lars Ulrich, Dave Mustaine	302053	9817143	0.99
1836	No Remorse	150	1	3	James Hetfield, Lars Ulrich	386795	12672166	0.99
1837	Seek & Destroy	150	1	3	James Hetfield, Lars Ulrich	415817	13452301	0.99
1838	Metal Militia	150	1	3	James Hetfield, Lars Ulrich, Dave Mustaine	311327	10141785	0.99
1839	Ain't My Bitch	151	1	3	James Hetfield, Lars Ulrich	304457	9931015	0.99
1840	2 X 4	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	328254	10732251	0.99
1841	The House Jack Built	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	398942	13005152	0.99
1842	Until It Sleeps	151	1	3	James Hetfield, Lars Ulrich	269740	8837394	0.99
1843	King Nothing	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	328097	10681477	0.99
1844	Hero Of The Day	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	261982	8540298	0.99
1845	Bleeding Me	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	497998	16249420	0.99
1846	Cure	151	1	3	James Hetfield, Lars Ulrich	294347	9648615	0.99
1847	Poor Twisted Me	151	1	3	James Hetfield, Lars Ulrich	240065	7854349	0.99
1848	Wasted My Hate	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	237296	7762300	0.99
1849	Mama Said	151	1	3	James Hetfield, Lars Ulrich	319764	10508310	0.99
1850	Thorn Within	151	1	3	James Hetfield, Lars Ulrich, Kirk Hammett	351738	11486686	0.99
1851	Ronnie	151	1	3	James Hetfield, Lars Ulrich	317204	10390947	0.99
1852	The Outlaw Torn	151	1	3	James Hetfield, Lars Ulrich	588721	19286261	0.99
1853	Battery	152	1	3	J.Hetfield/L.Ulrich	312424	10229577	0.99
1854	Master Of Puppets	152	1	3	K.Hammett	515239	16893720	0.99
1855	The Thing That Should Not Be	152	1	3	K.Hammett	396199	12952368	0.99
1856	Welcome Home (Sanitarium)	152	1	3	K.Hammett	387186	12679965	0.99
1857	Disposable Heroes	152	1	3	J.Hetfield/L.Ulrich	496718	16135560	0.99
1858	Leper Messiah	152	1	3	C.Burton	347428	11310434	0.99
1859	Orion	152	1	3	K.Hammett	500062	16378477	0.99
1860	Damage Inc.	152	1	3	K.Hammett	330919	10725029	0.99
1861	Fuel	153	1	3	Hetfield, Ulrich, Hammett	269557	8876811	0.99
1862	The Memory Remains	153	1	3	Hetfield, Ulrich	279353	9110730	0.99
1863	Devil's Dance	153	1	3	Hetfield, Ulrich	318955	10414832	0.99
1864	The Unforgiven II	153	1	3	Hetfield, Ulrich, Hammett	395520	12886474	0.99
1865	Better Than You	153	1	3	Hetfield, Ulrich	322899	10549070	0.99
1866	Slither	153	1	3	Hetfield, Ulrich, Hammett	313103	10199789	0.99
1867	Carpe Diem Baby	153	1	3	Hetfield, Ulrich, Hammett	372480	12170693	0.99
1868	Bad Seed	153	1	3	Hetfield, Ulrich, Hammett	245394	8019586	0.99
1869	Where The Wild Things Are	153	1	3	Hetfield, Ulrich, Newsted	414380	13571280	0.99
1870	Prince Charming	153	1	3	Hetfield, Ulrich	365061	12009412	0.99
1871	Low Man's Lyric	153	1	3	Hetfield, Ulrich	457639	14855583	0.99
1872	Attitude	153	1	3	Hetfield, Ulrich	315898	10335734	0.99
1873	Fixxxer	153	1	3	Hetfield, Ulrich, Hammett	496065	16190041	0.99
1874	Fight Fire With Fire	154	1	3	Metallica	285753	9420856	0.99
1875	Ride The Lightning	154	1	3	Metallica	397740	13055884	0.99
1876	For Whom The Bell Tolls	154	1	3	Metallica	311719	10159725	0.99
1877	Fade To Black	154	1	3	Metallica	414824	13531954	0.99
1878	Trapped Under Ice	154	1	3	Metallica	244532	7975942	0.99
1879	Escape	154	1	3	Metallica	264359	8652332	0.99
1880	Creeping Death	154	1	3	Metallica	396878	12955593	0.99
1881	The Call Of Ktulu	154	1	3	Metallica	534883	17486240	0.99
1882	Frantic	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	350458	11510849	0.99
1883	St. Anger	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	441234	14363779	0.99
1884	Some Kind Of Monster	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	505626	16557497	0.99
1885	Dirty Window	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	324989	10670604	0.99
1886	Invisible Kid	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	510197	16591800	0.99
1887	My World	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	345626	11253756	0.99
1888	Shoot Me Again	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	430210	14093551	0.99
1889	Sweet Amber	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	327235	10616595	0.99
1890	The Unnamed Feeling	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	429479	14014582	0.99
1891	Purify	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	314017	10232537	0.99
1892	All Within My Hands	155	1	3	Bob Rock/James Hetfield/Kirk Hammett/Lars Ulrich	527986	17162741	0.99
1893	Blackened	156	1	3	James Hetfield, Lars Ulrich & Jason Newsted	403382	13254874	0.99
1894	...And Justice For All	156	1	3	James Hetfield, Lars Ulrich & Kirk Hammett	585769	19262088	0.99
1895	Eye Of The Beholder	156	1	3	James Hetfield, Lars Ulrich & Kirk Hammett	385828	12747894	0.99
1896	One	156	1	3	James Hetfield & Lars Ulrich	446484	14695721	0.99
1897	The Shortest Straw	156	1	3	James Hetfield and Lars Ulrich	395389	13013990	0.99
1898	Harvester Of Sorrow	156	1	3	James Hetfield and Lars Ulrich	345547	11377339	0.99
1899	The Frayed Ends Of Sanity	156	1	3	James Hetfield, Lars Ulrich and Kirk Hammett	464039	15198986	0.99
1900	To Live Is To Die	156	1	3	James Hetfield, Lars Ulrich and Cliff Burton	588564	19243795	0.99
1901	Dyers Eve	156	1	3	James Hetfield, Lars Ulrich and Kirk Hammett	313991	10302828	0.99
1902	Springsville	157	1	2	J. Carisi	207725	6776219	0.99
1903	The Maids Of Cadiz	157	1	2	L. Delibes	233534	7505275	0.99
1904	The Duke	157	1	2	Dave Brubeck	214961	6977626	0.99
1905	My Ship	157	1	2	Ira Gershwin, Kurt Weill	268016	8581144	0.99
1906	Miles Ahead	157	1	2	Miles Davis, Gil Evans	209893	6807707	0.99
1907	Blues For Pablo	157	1	2	Gil Evans	318328	10218398	0.99
1908	New Rhumba	157	1	2	A. Jamal	276871	8980400	0.99
1909	The Meaning Of The Blues	157	1	2	R. Troup, L. Worth	168594	5395412	0.99
1910	Lament	157	1	2	J.J. Johnson	134191	4293394	0.99
1911	I Don't Wanna Be Kissed (By Anyone But You)	157	1	2	H. Spina, J. Elliott	191320	6219487	0.99
1912	Springsville (Alternate Take)	157	1	2	J. Carisi	196388	6382079	0.99
1913	Blues For Pablo (Alternate Take)	157	1	2	Gil Evans	212558	6900619	0.99
1914	The Meaning Of The Blues/Lament (Alternate Take)	157	1	2	J.J. Johnson/R. Troup, L. Worth	309786	9912387	0.99
1915	I Don't Wanna Be Kissed (By Anyone But You) (Alternate Take)	157	1	2	H. Spina, J. Elliott	192078	6254796	0.99
1916	Cora��o De Estudante	158	1	7	Wagner Tiso, Milton Nascimento	238550	7797308	0.99
1917	A Noite Do Meu Bem	158	1	7	Dolores Duran	220081	7125225	0.99
1918	Paisagem Na Janela	158	1	7	L� Borges, Fernando Brant	197694	6523547	0.99
1919	Cuitelinho	158	1	7	Folclore	209397	6803970	0.99
1920	Caxang�	158	1	7	Milton Nascimento, Fernando Brant	245551	8144179	0.99
1921	Nos Bailes Da Vida	158	1	7	Milton Nascimento, Fernando Brant	275748	9126170	0.99
1922	Menestrel Das Alagoas	158	1	7	Milton Nascimento, Fernando Brant	199758	6542289	0.99
1923	Brasil	158	1	7	Milton Nascimento, Fernando Brant	155428	5252560	0.99
1924	Can��o Do Novo Mundo	158	1	7	Beto Guedes, Ronaldo Bastos	215353	7032626	0.99
1925	Um Gosto De Sol	158	1	7	Milton Nascimento, Ronaldo Bastos	307200	9893875	0.99
1926	Solar	158	1	7	Milton Nascimento, Fernando Brant	156212	5098288	0.99
1927	Para Lennon E McCartney	158	1	7	L� Borges, M�rcio Borges, Fernando Brant	321828	10626920	0.99
1928	Maria, Maria	158	1	7	Milton Nascimento, Fernando Brant	72463	2371543	0.99
1929	Minas	159	1	7	Milton Nascimento, Caetano Veloso	152293	4921056	0.99
1930	F� Cega, Faca Amolada	159	1	7	Milton Nascimento, Ronaldo Bastos	278099	9258649	0.99
1931	Beijo Partido	159	1	7	Toninho Horta	229564	7506969	0.99
1932	Saudade Dos Avi�es Da Panair (Conversando No Bar)	159	1	7	Milton Nascimento, Fernando Brant	268721	8805088	0.99
1933	Gran Circo	159	1	7	Milton Nascimento, M�rcio Borges	251297	8237026	0.99
1934	Ponta de Areia	159	1	7	Milton Nascimento, Fernando Brant	272796	8874285	0.99
1935	Trastevere	159	1	7	Milton Nascimento, Ronaldo Bastos	265665	8708399	0.99
1936	Idolatrada	159	1	7	Milton Nascimento, Fernando Brant	286249	9426153	0.99
1937	Leila (Venha Ser Feliz)	159	1	7	Milton Nascimento	209737	6898507	0.99
1938	Paula E Bebeto	159	1	7	Milton Nascimento, Caetano Veloso	135732	4583956	0.99
1939	Simples	159	1	7	Nelson Angelo	133093	4326333	0.99
1940	Norwegian Wood	159	1	7	John Lennon, Paul McCartney	413910	13520382	0.99
1941	Caso Voc� Queira Saber	159	1	7	Beto Guedes, M�rcio Borges	205688	6787901	0.99
1942	Ace Of Spades	160	1	3	Clarke/Kilmister/Taylor	169926	5523552	0.99
1943	Love Me Like A Reptile	160	1	3	Clarke/Kilmister/Taylor	203546	6616389	0.99
1944	Shoot You In The Back	160	1	3	Clarke/Kilmister/Taylor	160026	5175327	0.99
1945	Live To Win	160	1	3	Clarke/Kilmister/Taylor	217626	7102182	0.99
1946	Fast And Loose	160	1	3	Clarke/Kilmister/Taylor	203337	6643350	0.99
1947	(We Are) The Road Crew	160	1	3	Clarke/Kilmister/Taylor	192600	6283035	0.99
1948	Fire Fire	160	1	3	Clarke/Kilmister/Taylor	164675	5416114	0.99
1949	Jailbait	160	1	3	Clarke/Kilmister/Taylor	213916	6983609	0.99
1950	Dance	160	1	3	Clarke/Kilmister/Taylor	158432	5155099	0.99
1951	Bite The Bullet	160	1	3	Clarke/Kilmister/Taylor	98115	3195536	0.99
1952	The Chase Is Better Than The Catch	160	1	3	Clarke/Kilmister/Taylor	258403	8393310	0.99
1953	The Hammer	160	1	3	Clarke/Kilmister/Taylor	168071	5543267	0.99
1954	Dirty Love	160	1	3	Clarke/Kilmister/Taylor	176457	5805241	0.99
1955	Please Don't Touch	160	1	3	Heath/Robinson	169926	5557002	0.99
1956	Emergency	160	1	3	Dufort/Johnson/McAuliffe/Williams	180427	5828728	0.99
1957	Kir Royal	161	1	16	M�nica Marianno	234788	7706552	0.99
1958	O Que Vai Em Meu Cora��o	161	1	16	M�nica Marianno	255373	8366846	0.99
1959	Aos Le�es	161	1	16	M�nica Marianno	234684	7790574	0.99
1960	Dois �ndios	161	1	16	M�nica Marianno	219271	7213072	0.99
1961	Noite Negra	161	1	16	M�nica Marianno	206811	6819584	0.99
1962	Beijo do Olhar	161	1	16	M�nica Marianno	252682	8369029	0.99
1963	� Fogo	161	1	16	M�nica Marianno	194873	6501520	0.99
1964	J� Foi	161	1	16	M�nica Marianno	245681	8094872	0.99
1965	S� Se For Pelo Cabelo	161	1	16	M�nica Marianno	238288	8006345	0.99
1966	No Clima	161	1	16	M�nica Marianno	249495	8362040	0.99
1967	A Mo�a e a Chuva	161	1	16	M�nica Marianno	274625	8929357	0.99
1968	Demorou!	161	1	16	M�nica Marianno	39131	1287083	0.99
1969	Bitter Pill	162	1	3	Mick Mars/Nikki Sixx/Tommy Lee/Vince Neil	266814	8666786	0.99
1970	Enslaved	162	1	3	Mick Mars/Nikki Sixx/Tommy Lee	269844	8789966	0.99
1971	Girls, Girls, Girls	162	1	3	Mick Mars/Nikki Sixx/Tommy Lee	270288	8874814	0.99
1972	Kickstart My Heart	162	1	3	Nikki Sixx	283559	9237736	0.99
1973	Wild Side	162	1	3	Nikki Sixx/Tommy Lee/Vince Neil	276767	9116997	0.99
1974	Glitter	162	1	3	Bryan Adams/Nikki Sixx/Scott Humphrey	340114	11184094	0.99
1975	Dr. Feelgood	162	1	3	Mick Mars/Nikki Sixx	282618	9281875	0.99
1976	Same Ol' Situation	162	1	3	Mick Mars/Nikki Sixx/Tommy Lee/Vince Neil	254511	8283958	0.99
1977	Home Sweet Home	162	1	3	Nikki Sixx/Tommy Lee/Vince Neil	236904	7697538	0.99
1978	Afraid	162	1	3	Nikki Sixx	248006	8077464	0.99
1979	Don't Go Away Mad (Just Go Away)	162	1	3	Mick Mars/Nikki Sixx	279980	9188156	0.99
1980	Without You	162	1	3	Mick Mars/Nikki Sixx	268956	8738371	0.99
1981	Smokin' in The Boys Room	162	1	3	Cub Coda/Michael Lutz	206837	6735408	0.99
1982	Primal Scream	162	1	3	Mick Mars/Nikki Sixx/Tommy Lee/Vince Neil	286197	9421164	0.99
1983	Too Fast For Love	162	1	3	Nikki Sixx	200829	6580542	0.99
1984	Looks That Kill	162	1	3	Nikki Sixx	240979	7831122	0.99
1985	Shout At The Devil	162	1	3	Nikki Sixx	221962	7281974	0.99
1986	Intro	163	1	1	Kurt Cobain	52218	1688527	0.99
1987	School	163	1	1	Kurt Cobain	160235	5234885	0.99
1988	Drain You	163	1	1	Kurt Cobain	215196	7013175	0.99
1989	Aneurysm	163	1	1	Nirvana	271516	8862545	0.99
1990	Smells Like Teen Spirit	163	1	1	Nirvana	287190	9425215	0.99
1991	Been A Son	163	1	1	Kurt Cobain	127555	4170369	0.99
1992	Lithium	163	1	1	Kurt Cobain	250017	8148800	0.99
1993	Sliver	163	1	1	Kurt Cobain	116218	3784567	0.99
1994	Spank Thru	163	1	1	Kurt Cobain	190354	6186487	0.99
1995	Scentless Apprentice	163	1	1	Nirvana	211200	6898177	0.99
1996	Heart-Shaped Box	163	1	1	Kurt Cobain	281887	9210982	0.99
1997	Milk It	163	1	1	Kurt Cobain	225724	7406945	0.99
1998	Negative Creep	163	1	1	Kurt Cobain	163761	5354854	0.99
1999	Polly	163	1	1	Kurt Cobain	149995	4885331	0.99
2000	Breed	163	1	1	Kurt Cobain	208378	6759080	0.99
2001	Tourette's	163	1	1	Kurt Cobain	115591	3753246	0.99
2002	Blew	163	1	1	Kurt Cobain	216346	7096936	0.99
2003	Smells Like Teen Spirit	164	1	1	Kurt Cobain	301296	9823847	0.99
2004	In Bloom	164	1	1	Kurt Cobain	254928	8327077	0.99
2005	Come As You Are	164	1	1	Kurt Cobain	219219	7123357	0.99
2006	Breed	164	1	1	Kurt Cobain	183928	5984812	0.99
2007	Lithium	164	1	1	Kurt Cobain	256992	8404745	0.99
2008	Polly	164	1	1	Kurt Cobain	177031	5788407	0.99
2009	Territorial Pissings	164	1	1	Kurt Cobain	143281	4613880	0.99
2010	Drain You	164	1	1	Kurt Cobain	223973	7273440	0.99
2011	Lounge Act	164	1	1	Kurt Cobain	156786	5093635	0.99
2012	Stay Away	164	1	1	Kurt Cobain	212636	6956404	0.99
2013	On A Plain	164	1	1	Kurt Cobain	196440	6390635	0.99
2014	Something In The Way	164	1	1	Kurt Cobain	230556	7472168	0.99
2015	Time	165	1	1	\N	96888	3124455	0.99
2016	P.S.Apare�a	165	1	1	\N	209188	6842244	0.99
2017	Sangue Latino	165	1	1	\N	223033	7354184	0.99
2018	Folhas Secas	165	1	1	\N	161253	5284522	0.99
2019	Poeira	165	1	1	\N	267075	8784141	0.99
2020	M�gica	165	1	1	\N	233743	7627348	0.99
2021	Quem Mata A Mulher Mata O Melhor	165	1	1	\N	262791	8640121	0.99
2022	Mundar�u	165	1	1	\N	217521	7158975	0.99
2023	O Bra�o Da Minha Guitarra	165	1	1	\N	258351	8469531	0.99
2024	Deus	165	1	1	\N	284160	9188110	0.99
2025	M�e Terra	165	1	1	\N	306625	9949269	0.99
2026	�s Vezes	165	1	1	\N	330292	10706614	0.99
2027	Menino De Rua	165	1	1	\N	329795	10784595	0.99
2028	Prazer E F�	165	1	1	\N	214831	7031383	0.99
2029	Elza	165	1	1	\N	199105	6517629	0.99
2030	Requebra	166	1	7	\N	240744	8010811	0.99
2031	Nossa Gente (Avisa L�)	166	1	7	\N	188212	6233201	0.99
2032	Olodum - Alegria Geral	166	1	7	\N	233404	7754245	0.99
2033	Madag�scar Olodum	166	1	7	\N	252264	8270584	0.99
2034	Fara� Divindade Do Egito	166	1	7	\N	228571	7523278	0.99
2035	Todo Amor (Asas Da Liberdade)	166	1	7	\N	245133	8121434	0.99
2036	Den�ncia	166	1	7	\N	159555	5327433	0.99
2037	Olodum, A Banda Do Pel�	166	1	7	\N	146599	4900121	0.99
2038	Cartao Postal	166	1	7	\N	211565	7082301	0.99
2039	Jeito Faceiro	166	1	7	\N	217286	7233608	0.99
2040	Revolta Olodum	166	1	7	\N	230191	7557065	0.99
2041	Reggae Odoy�	166	1	7	\N	224470	7499807	0.99
2042	Protesto Do Olodum (Ao Vivo)	166	1	7	\N	206001	6766104	0.99
2043	Olodum - Smile (Instrumental)	166	1	7	\N	235833	7871409	0.99
2044	Vulc�o Dub - Fui Eu	167	1	7	Bi Ribeira/Herbert Vianna/Jo�o Barone	287059	9495202	0.99
2045	O Trem Da Juventude	167	1	7	Herbert Vianna	225880	7507655	0.99
2046	Manguetown	167	1	7	Chico Science/Dengue/L�cio Maia	162925	5382018	0.99
2047	Um Amor, Um Lugar	167	1	7	Herbert Vianna	184555	6090334	0.99
2048	Bora-Bora	167	1	7	Herbert Vianna	182987	6036046	0.99
2049	Vai Valer	167	1	7	Herbert Vianna	206524	6899778	0.99
2050	I Feel Good (I Got You) - Sossego	167	1	7	James Brown/Tim Maia	244976	8091302	0.99
2051	Uns Dias	167	1	7	Herbert Vianna	240796	7931552	0.99
2052	Sincero Breu	167	1	7	C. A./C.A./Celso Alvim/Herbert Vianna/M�rio Moura/Pedro Lu�s/Sidon Silva	208013	6921669	0.99
2053	Meu Erro	167	1	7	Herbert Vianna	188577	6192791	0.99
2054	Selvagem	167	1	7	Bi Ribeiro/Herbert Vianna/Jo�o Barone	148558	4942831	0.99
2055	Bras�lia 5:31	167	1	7	Herbert Vianna	178337	5857116	0.99
2056	Tendo A Lua	167	1	7	Herbert Vianna/Tet Tillett	198922	6568180	0.99
2057	Que Pa�s � Este	167	1	7	Renato Russo	216685	7137865	0.99
2058	Navegar Impreciso	167	1	7	Herbert Vianna	262870	8761283	0.99
2059	Feira Moderna	167	1	7	Beto Guedes/Fernando Brant/L Borges	182517	6001793	0.99
2060	Tequila - Lourinha Bombril (Parate Y Mira)	167	1	7	Bahiano/Chuck Rio/Diego Blanco/Herbert Vianna	255738	8514961	0.99
2061	Vamo Bat� Lata	167	1	7	Herbert Vianna	228754	7585707	0.99
2062	Life During Wartime	167	1	7	Chris Frantz/David Byrne/Jerry Harrison/Tina Weymouth	259186	8543439	0.99
2063	Nebulosa Do Amor	167	1	7	Herbert Vianna	203415	6732496	0.99
2064	Caleidosc�pio	167	1	7	Herbert Vianna	256522	8484597	0.99
2065	Trac Trac	168	1	7	Fito Paez/Herbert Vianna	231653	7638256	0.99
2066	Tendo A Lua	168	1	7	Herbert Vianna/Tet� Tillet	219585	7342776	0.99
2067	Mensagen De Amor (2000)	168	1	7	Herbert Vianna	183588	6061324	0.99
2068	Lourinha Bombril	168	1	7	Bahiano/Diego Blanco/Herbert Vianna	159895	5301882	0.99
2069	La Bella Luna	168	1	7	Herbert Vianna	192653	6428598	0.99
2070	Busca Vida	168	1	7	Herbert Vianna	176431	5798663	0.99
2071	Uma Brasileira	168	1	7	Carlinhos Brown/Herbert Vianna	217573	7280574	0.99
2072	Luis Inacio (300 Picaretas)	168	1	7	Herbert Vianna	198191	6576790	0.99
2073	Saber Amar	168	1	7	Herbert Vianna	202788	6723733	0.99
2074	Ela Disse Adeus	168	1	7	Herbert Vianna	226298	7608999	0.99
2075	O Amor Nao Sabe Esperar	168	1	7	Herbert Vianna	241084	8042534	0.99
2076	Aonde Quer Que Eu Va	168	1	7	Herbert Vianna/Paulo S�rgio Valle	258089	8470121	0.99
2077	Caleidosc�pio	169	1	7	\N	211330	7000017	0.99
2078	�culos	169	1	7	\N	219271	7262419	0.99
2079	Cinema Mudo	169	1	7	\N	227918	7612168	0.99
2080	Alagados	169	1	7	\N	302393	10255463	0.99
2081	Lanterna Dos Afogados	169	1	7	\N	190197	6264318	0.99
2082	Mel� Do Marinheiro	169	1	7	\N	208352	6905668	0.99
2083	Vital E Sua Moto	169	1	7	\N	210207	6902878	0.99
2084	O Beco	169	1	7	\N	189178	6293184	0.99
2085	Meu Erro	169	1	7	\N	208431	6893533	0.99
2086	Perplexo	169	1	7	\N	161175	5355013	0.99
2087	Me Liga	169	1	7	\N	229590	7565912	0.99
2088	Quase Um Segundo	169	1	7	\N	275644	8971355	0.99
2089	Selvagem	169	1	7	\N	245890	8141084	0.99
2090	Romance Ideal	169	1	7	\N	250070	8260477	0.99
2091	Ser� Que Vai Chover?	169	1	7	\N	337057	11133830	0.99
2092	SKA	169	1	7	\N	148871	4943540	0.99
2093	Bark at the Moon	170	2	1	O. Osbourne	257252	4601224	0.99
2094	I Don't Know	171	2	1	B. Daisley, O. Osbourne & R. Rhoads	312980	5525339	0.99
2095	Crazy Train	171	2	1	B. Daisley, O. Osbourne & R. Rhoads	295960	5255083	0.99
2096	Flying High Again	172	2	1	L. Kerslake, O. Osbourne, R. Daisley & R. Rhoads	290851	5179599	0.99
2097	Mama, I'm Coming Home	173	2	1	L. Kilmister, O. Osbourne & Z. Wylde	251586	4302390	0.99
2098	No More Tears	173	2	1	J. Purdell, M. Inez, O. Osbourne, R. Castillo & Z. Wylde	444358	7362964	0.99
2099	I Don't Know	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	283088	9207869	0.99
2100	Crazy Train	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	322716	10517408	0.99
2101	Believer	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	308897	10003794	0.99
2102	Mr. Crowley	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	344241	11184130	0.99
2103	Flying High Again	174	1	3	O. Osbourne, R. Daisley, R. Rhoads, L. Kerslake	261224	8481822	0.99
2104	Relvelation (Mother Earth)	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	349440	11367866	0.99
2105	Steal Away (The Night)	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	485720	15945806	0.99
2106	Suicide Solution (With Guitar Solo)	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	467069	15119938	0.99
2107	Iron Man	174	1	3	A. F. Iommi, W. Ward, T. Butler, J. Osbourne	172120	5609799	0.99
2108	Children Of The Grave	174	1	3	A. F. Iommi, W. Ward, T. Butler, J. Osbourne	357067	11626740	0.99
2109	Paranoid	174	1	3	A. F. Iommi, W. Ward, T. Butler, J. Osbourne	176352	5729813	0.99
2110	Goodbye To Romance	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	334393	10841337	0.99
2111	No Bone Movies	174	1	3	O. Osbourne, R. Daisley, R. Rhoads	249208	8095199	0.99
2112	Dee	174	1	3	R. Rhoads	261302	8555963	0.99
2113	Shining In The Light	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	240796	7951688	0.99
2114	When The World Was Young	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	373394	12198930	0.99
2115	Upon A Golden Horse	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	232359	7594829	0.99
2116	Blue Train	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	405028	13170391	0.99
2117	Please Read The Letter	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	262112	8603372	0.99
2118	Most High	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	336535	10999203	0.99
2119	Heart In Your Hand	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	230896	7598019	0.99
2120	Walking Into Clarksdale	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	318511	10396315	0.99
2121	Burning Up	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	321619	10525136	0.99
2122	When I Was A Child	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	345626	11249456	0.99
2123	House Of Love	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	335699	10990880	0.99
2124	Sons Of Freedom	175	1	1	Jimmy Page, Robert Plant, Charlie Jones, Michael Lee	246465	8087944	0.99
2125	United Colours	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	330266	10939131	0.99
2126	Slug	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	281469	9295950	0.99
2127	Your Blue Room	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	328228	10867860	0.99
2128	Always Forever Now	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	383764	12727928	0.99
2129	A Different Kind Of Blue	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	120816	3884133	0.99
2130	Beach Sequence	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	212297	6928259	0.99
2131	Miss Sarajevo	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	340767	11064884	0.99
2132	Ito Okashi	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	205087	6572813	0.99
2133	One Minute Warning	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	279693	9335453	0.99
2134	Corpse (These Chains Are Way Too Long)	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	214909	6920451	0.99
2135	Elvis Ate America	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	180166	5851053	0.99
2136	Plot 180	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	221596	7253729	0.99
2137	Theme From The Swan	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	203911	6638076	0.99
2138	Theme From Let's Go Native	176	1	10	Brian Eno, Bono, Adam Clayton, The Edge & Larry Mullen Jnr.	186723	6179777	0.99
2139	Wrathchild	177	1	1	Steve Harris	170396	5499390	0.99
2140	Killers	177	1	1	Paul Di'Anno/Steve Harris	309995	10009697	0.99
2141	Prowler	177	1	1	Steve Harris	240274	7782963	0.99
2142	Murders In The Rue Morgue	177	1	1	Steve Harris	258638	8360999	0.99
2143	Women In Uniform	177	1	1	Greg Macainsh	189936	6139651	0.99
2144	Remember Tomorrow	177	1	1	Paul Di'Anno/Steve Harris	326426	10577976	0.99
2145	Sanctuary	177	1	1	David Murray/Paul Di'Anno/Steve Harris	198844	6423543	0.99
2146	Running Free	177	1	1	Paul Di'Anno/Steve Harris	199706	6483496	0.99
2147	Phantom Of The Opera	177	1	1	Steve Harris	418168	13585530	0.99
2148	Iron Maiden	177	1	1	Steve Harris	235232	7600077	0.99
2149	Corduroy	178	1	1	Pearl Jam & Eddie Vedder	305293	9991106	0.99
2150	Given To Fly	178	1	1	Eddie Vedder & Mike McCready	233613	7678347	0.99
2151	Hail, Hail	178	1	1	Stone Gossard & Eddie Vedder & Jeff Ament & Mike McCready	223764	7364206	0.99
2152	Daughter	178	1	1	Dave Abbruzzese & Jeff Ament & Stone Gossard & Mike McCready & Eddie Vedder	407484	13420697	0.99
2153	Elderly Woman Behind The Counter In A Small Town	178	1	1	Dave Abbruzzese & Jeff Ament & Stone Gossard & Mike McCready & Eddie Vedder	229328	7509304	0.99
2154	Untitled	178	1	1	Pearl Jam	122801	3957141	0.99
2155	MFC	178	1	1	Eddie Vedder	148192	4817665	0.99
2156	Go	178	1	1	Dave Abbruzzese & Jeff Ament & Stone Gossard & Mike McCready & Eddie Vedder	161541	5290810	0.99
2157	Red Mosquito	178	1	1	Jeff Ament & Stone Gossard & Jack Irons & Mike McCready & Eddie Vedder	242991	7944923	0.99
2158	Even Flow	178	1	1	Stone Gossard & Eddie Vedder	317100	10394239	0.99
2159	Off He Goes	178	1	1	Eddie Vedder	343222	11245109	0.99
2160	Nothingman	178	1	1	Jeff Ament & Eddie Vedder	278595	9107017	0.99
2161	Do The Evolution	178	1	1	Eddie Vedder & Stone Gossard	225462	7377286	0.99
2162	Better Man	178	1	1	Eddie Vedder	246204	8019563	0.99
2163	Black	178	1	1	Stone Gossard & Eddie Vedder	415712	13580009	0.99
2164	F*Ckin' Up	178	1	1	Neil Young	377652	12360893	0.99
2165	Life Wasted	179	1	4	Stone Gossard	234344	7610169	0.99
2166	World Wide Suicide	179	1	4	Eddie Vedder	209188	6885908	0.99
2167	Comatose	179	1	4	Mike McCready & Stone Gossard	139990	4574516	0.99
2168	Severed Hand	179	1	4	Eddie Vedder	270341	8817438	0.99
2169	Marker In The Sand	179	1	4	Mike McCready	263235	8656578	0.99
2170	Parachutes	179	1	4	Stone Gossard	216555	7074973	0.99
2171	Unemployable	179	1	4	Matt Cameron & Mike McCready	184398	6066542	0.99
2172	Big Wave	179	1	4	Jeff Ament	178573	5858788	0.99
2173	Gone	179	1	4	Eddie Vedder	249547	8158204	0.99
2174	Wasted Reprise	179	1	4	Stone Gossard	53733	1731020	0.99
2175	Army Reserve	179	1	4	Jeff Ament	225567	7393771	0.99
2176	Come Back	179	1	4	Eddie Vedder & Mike McCready	329743	10768701	0.99
2177	Inside Job	179	1	4	Eddie Vedder & Mike McCready	428643	14006924	0.99
2178	Can't Keep	180	1	1	Eddie Vedder	219428	7215713	0.99
2179	Save You	180	1	1	Eddie Vedder/Jeff Ament/Matt Cameron/Mike McCready/Stone Gossard	230112	7609110	0.99
2180	Love Boat Captain	180	1	1	Eddie Vedder	276453	9016789	0.99
2181	Cropduster	180	1	1	Matt Cameron	231888	7588928	0.99
2182	Ghost	180	1	1	Jeff Ament	195108	6383772	0.99
2183	I Am Mine	180	1	1	Eddie Vedder	215719	7086901	0.99
2184	Thumbing My Way	180	1	1	Eddie Vedder	250226	8201437	0.99
2185	You Are	180	1	1	Matt Cameron	270863	8938409	0.99
2186	Get Right	180	1	1	Matt Cameron	158589	5223345	0.99
2187	Green Disease	180	1	1	Eddie Vedder	161253	5375818	0.99
2188	Help Help	180	1	1	Jeff Ament	215092	7033002	0.99
2189	Bushleager	180	1	1	Stone Gossard	237479	7849757	0.99
2190	1/2 Full	180	1	1	Jeff Ament	251010	8197219	0.99
2191	Arc	180	1	1	Pearl Jam	65593	2099421	0.99
2192	All or None	180	1	1	Stone Gossard	277655	9104728	0.99
2193	Once	181	1	1	Stone Gossard	231758	7561555	0.99
2194	Evenflow	181	1	1	Stone Gossard	293720	9622017	0.99
2195	Alive	181	1	1	Stone Gossard	341080	11176623	0.99
2196	Why Go	181	1	1	Jeff Ament	200254	6539287	0.99
2197	Black	181	1	1	Dave Krusen/Stone Gossard	343823	11213314	0.99
2198	Jeremy	181	1	1	Jeff Ament	318981	10447222	0.99
2199	Oceans	181	1	1	Jeff Ament/Stone Gossard	162194	5282368	0.99
2200	Porch	181	1	1	Eddie Vedder	210520	6877475	0.99
2201	Garden	181	1	1	Jeff Ament/Stone Gossard	299154	9740738	0.99
2202	Deep	181	1	1	Jeff Ament/Stone Gossard	258324	8432497	0.99
2203	Release	181	1	1	Jeff Ament/Mike McCready/Stone Gossard	546063	17802673	0.99
2204	Go	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	193123	6351920	0.99
2205	Animal	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	169325	5503459	0.99
2206	Daughter	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	235598	7824586	0.99
2207	Glorified G	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	206968	6772116	0.99
2208	Dissident	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	215510	7034500	0.99
2209	W.M.A.	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	359262	12037261	0.99
2210	Blood	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	170631	5551478	0.99
2211	Rearviewmirror	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	284186	9321053	0.99
2212	Rats	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	255425	8341934	0.99
2213	Elderly Woman Behind The Counter In A Small Town	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	196336	6499398	0.99
2214	Leash	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	189257	6191560	0.99
2215	Indifference	182	1	1	Dave Abbruzzese/Eddie Vedder/Jeff Ament/Mike McCready/Stone Gossard	302053	9756133	0.99
2216	Johnny B. Goode	141	1	8	\N	243200	8092024	0.99
2217	Don't Look Back	141	1	8	\N	221100	7344023	0.99
2218	Jah Seh No	141	1	8	\N	276871	9134476	0.99
2219	I'm The Toughest	141	1	8	\N	230191	7657594	0.99
2220	Nothing But Love	141	1	8	\N	221570	7335228	0.99
2221	Buk-In-Hamm Palace	141	1	8	\N	265665	8964369	0.99
2222	Bush Doctor	141	1	8	\N	239751	7942299	0.99
2223	Wanted Dread And Alive	141	1	8	\N	260310	8670933	0.99
2224	Mystic Man	141	1	8	\N	353671	11812170	0.99
2225	Coming In Hot	141	1	8	\N	213054	7109414	0.99
2226	Pick Myself Up	141	1	8	\N	234684	7788255	0.99
2227	Crystal Ball	141	1	8	\N	309733	10319296	0.99
2228	Equal Rights Downpresser Man	141	1	8	\N	366733	12086524	0.99
2229	Speak To Me/Breathe	183	1	1	Mason/Waters, Gilmour, Wright	234213	7631305	0.99
2230	On The Run	183	1	1	Gilmour, Waters	214595	7206300	0.99
2231	Time	183	1	1	Mason, Waters, Wright, Gilmour	425195	13955426	0.99
2232	The Great Gig In The Sky	183	1	1	Wright, Waters	284055	9147563	0.99
2233	Money	183	1	1	Waters	391888	12930070	0.99
2234	Us And Them	183	1	1	Waters, Wright	461035	15000299	0.99
2235	Any Colour You Like	183	1	1	Gilmour, Mason, Wright, Waters	205740	6707989	0.99
2236	Brain Damage	183	1	1	Waters	230556	7497655	0.99
2237	Eclipse	183	1	1	Waters	125361	4065299	0.99
2238	ZeroVinteUm	184	1	17	\N	315637	10426550	0.99
2239	Queimando Tudo	184	1	17	\N	172591	5723677	0.99
2240	Hip Hop Rio	184	1	17	\N	151536	4991935	0.99
2241	Bossa	184	1	17	\N	29048	967098	0.99
2242	100% HardCore	184	1	17	\N	165146	5407744	0.99
2243	Biruta	184	1	17	\N	213263	7108200	0.99
2244	M�o Na Cabe�a	184	1	17	\N	202631	6642753	0.99
2245	O Bicho T� Pregando	184	1	17	\N	171964	5683369	0.99
2246	Adoled (Ocean)	184	1	17	\N	185103	6009946	0.99
2247	Seus Amigos	184	1	17	\N	100858	3304738	0.99
2248	Paga Pau	184	1	17	\N	197485	6529041	0.99
2249	Rappers Reais	184	1	17	\N	202004	6684160	0.99
2250	Nega Do Cabelo Duro	184	1	17	\N	121808	4116536	0.99
2251	Hemp Family	184	1	17	\N	205923	6806900	0.99
2252	Quem Me Cobrou?	184	1	17	\N	121704	3947664	0.99
2253	Se Liga	184	1	17	\N	410409	13559173	0.99
2254	Bohemian Rhapsody	185	1	1	Mercury, Freddie	358948	11619868	0.99
2255	Another One Bites The Dust	185	1	1	Deacon, John	216946	7172355	0.99
2256	Killer Queen	185	1	1	Mercury, Freddie	182099	5967749	0.99
2257	Fat Bottomed Girls	185	1	1	May, Brian	204695	6630041	0.99
2258	Bicycle Race	185	1	1	Mercury, Freddie	183823	6012409	0.99
2259	You're My Best Friend	185	1	1	Deacon, John	172225	5602173	0.99
2260	Don't Stop Me Now	185	1	1	Mercury, Freddie	211826	6896666	0.99
2261	Save Me	185	1	1	May, Brian	228832	7444624	0.99
2262	Crazy Little Thing Called Love	185	1	1	Mercury, Freddie	164231	5435501	0.99
2263	Somebody To Love	185	1	1	Mercury, Freddie	297351	9650520	0.99
2264	Now I'm Here	185	1	1	May, Brian	255346	8328312	0.99
2265	Good Old-Fashioned Lover Boy	185	1	1	Mercury, Freddie	175960	5747506	0.99
2266	Play The Game	185	1	1	Mercury, Freddie	213368	6915832	0.99
2267	Flash	185	1	1	May, Brian	168489	5464986	0.99
2268	Seven Seas Of Rhye	185	1	1	Mercury, Freddie	170553	5539957	0.99
2269	We Will Rock You	185	1	1	Deacon, John/May, Brian	122880	4026955	0.99
2270	We Are The Champions	185	1	1	Mercury, Freddie	180950	5880231	0.99
2271	We Will Rock You	186	1	1	May	122671	4026815	0.99
2272	We Are The Champions	186	1	1	Mercury	182883	5939794	0.99
2273	Sheer Heart Attack	186	1	1	Taylor	207386	6642685	0.99
2274	All Dead, All Dead	186	1	1	May	190119	6144878	0.99
2275	Spread Your Wings	186	1	1	Deacon	275356	8936992	0.99
2276	Fight From The Inside	186	1	1	Taylor	184737	6078001	0.99
2277	Get Down, Make Love	186	1	1	Mercury	231235	7509333	0.99
2278	Sleep On The Sidewalk	186	1	1	May	187428	6099840	0.99
2279	Who Needs You	186	1	1	Deacon	186958	6292969	0.99
2280	It's Late	186	1	1	May	386194	12519388	0.99
2281	My Melancholy Blues	186	1	1	Mercury	206471	6691838	0.99
2282	Shiny Happy People	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	226298	7475323	0.99
2283	Me In Honey	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	246674	8194751	0.99
2284	Radio Song	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	255477	8421172	0.99
2285	Pop Song 89	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	185730	6132218	0.99
2286	Get Up	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	160235	5264376	0.99
2287	You Are The Everything	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	226298	7373181	0.99
2288	Stand	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	192862	6349090	0.99
2289	World Leader Pretend	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	259761	8537282	0.99
2290	The Wrong Child	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	216633	7065060	0.99
2291	Orange Crush	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	231706	7742894	0.99
2292	Turn You Inside-Out	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	257358	8395671	0.99
2293	Hairshirt	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	235911	7753807	0.99
2294	I Remember California	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	304013	9950311	0.99
2295	Untitled	188	1	4	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	191503	6332426	0.99
2296	How The West Was Won And Where It Got Us	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	271151	8994291	0.99
2297	The Wake-Up Bomb	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	308532	10077337	0.99
2298	New Test Leper	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	326791	10866447	0.99
2299	Undertow	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	309498	10131005	0.99
2300	E-Bow The Letter	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	324963	10714576	0.99
2301	Leave	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	437968	14433365	0.99
2302	Departure	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	209423	6818425	0.99
2303	Bittersweet Me	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	245812	8114718	0.99
2304	Be Mine	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	333087	10790541	0.99
2305	Binky The Doormat	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	301688	9950320	0.99
2306	Zither	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	154148	5032962	0.99
2307	So Fast, So Numb	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	252682	8341223	0.99
2308	Low Desert	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	212062	6989288	0.99
2309	Electrolite	189	1	1	Bill Berry-Peter Buck-Mike Mills-Michael Stipe	245315	8051199	0.99
2310	Losing My Religion	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	269035	8885672	0.99
2311	Low	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	296777	9633860	0.99
2312	Near Wild Heaven	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	199862	6610009	0.99
2313	Endgame	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	230687	7664479	0.99
2314	Belong	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	247013	8219375	0.99
2315	Half A World Away	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	208431	6837283	0.99
2316	Texarkana	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	220081	7260681	0.99
2317	Country Feedback	187	1	4	Bill Berry/Michael Stipe/Mike Mills/Peter Buck	249782	8178943	0.99
2318	Carnival Of Sorts	190	1	4	R.E.M.	233482	7669658	0.99
2319	Radio Free Aurope	190	1	4	R.E.M.	245315	8163490	0.99
2320	Perfect Circle	190	1	4	R.E.M.	208509	6898067	0.99
2321	Talk About The Passion	190	1	4	R.E.M.	203206	6725435	0.99
2322	So Central Rain	190	1	4	R.E.M.	194768	6414550	0.99
2323	Don't Go Back To Rockville	190	1	4	R.E.M.	272352	9010715	0.99
2324	Pretty Persuasion	190	1	4	R.E.M.	229929	7577754	0.99
2325	Green Grow The Rushes	190	1	4	R.E.M.	225671	7422425	0.99
2326	Can't Get There From Here	190	1	4	R.E.M.	220630	7285936	0.99
2327	Driver 8	190	1	4	R.E.M.	204747	6779076	0.99
2328	Fall On Me	190	1	4	R.E.M.	172016	5676811	0.99
2329	I Believe	190	1	4	R.E.M.	227709	7542929	0.99
2330	Cuyahoga	190	1	4	R.E.M.	260623	8591057	0.99
2331	The One I Love	190	1	4	R.E.M.	197355	6495125	0.99
2332	The Finest Worksong	190	1	4	R.E.M.	229276	7574856	0.99
2333	It's The End Of The World As We Know It (And I Feel Fine)	190	1	4	R.E.M.	244819	7998987	0.99
2334	Infeliz Natal	191	1	4	Rodolfo	138266	4503299	0.99
2335	A Sua	191	1	4	Rodolfo	142132	4622064	0.99
2336	Papeau Nuky Doe	191	1	4	Rodolfo	121652	3995022	0.99
2337	Merry Christmas	191	1	4	Rodolfo	126040	4166652	0.99
2338	Bodies	191	1	4	Rodolfo	180035	5873778	0.99
2339	Puteiro Em Jo�o Pessoa	191	1	4	Rodolfo	195578	6395490	0.99
2340	Esporrei Na Manivela	191	1	4	Rodolfo	293276	9618499	0.99
2341	B�-a-B�	191	1	4	Rodolfo	249051	8130636	0.99
2342	Cajueiro	191	1	4	Rodolfo	158589	5164837	0.99
2343	Palhas Do Coqueiro	191	1	4	Rodolfo	133851	4396466	0.99
2344	Maluco Beleza	192	1	1	\N	203206	6628067	0.99
2345	O Dia Em Que A Terra Parou	192	1	1	\N	261720	8586678	0.99
2346	No Fundo Do Quintal Da Escola	192	1	1	\N	177606	5836953	0.99
2347	O Segredo Do Universo	192	1	1	\N	192679	6315187	0.99
2348	As Profecias	192	1	1	\N	232515	7657732	0.99
2349	Mata Virgem	192	1	1	\N	142602	4690029	0.99
2350	Sapato 36	192	1	1	\N	196702	6507301	0.99
2351	Todo Mundo Explica	192	1	1	\N	134896	4449772	0.99
2352	Que Luz � Essa	192	1	1	\N	165067	5620058	0.99
2353	Diamante De Mendigo	192	1	1	\N	206053	6775101	0.99
2354	Neg�cio �	192	1	1	\N	175464	5826775	0.99
2355	Muita Estrela, Pouca Constela��o	192	1	1	\N	268068	8781021	0.99
2356	S�culo XXI	192	1	1	\N	244897	8040563	0.99
2357	Rock Das Aranhas (Ao Vivo) (Live)	192	1	1	\N	231836	7591945	0.99
2358	The Power Of Equality	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	243591	8148266	0.99
2359	If You Have To Ask	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	216790	7199175	0.99
2360	Breaking The Girl	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	295497	9805526	0.99
2361	Funky Monks	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	323395	10708168	0.99
2362	Suck My Kiss	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	217234	7129137	0.99
2363	I Could Have Lied	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	244506	8088244	0.99
2364	Mellowship Slinky In B Major	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	240091	7971384	0.99
2365	The Righteous & The Wicked	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	248084	8134096	0.99
2366	Give It Away	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	283010	9308997	0.99
2367	Blood Sugar Sex Magik	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	271229	8940573	0.99
2368	Under The Bridge	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	264359	8682716	0.99
2369	Naked In The Rain	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	265717	8724674	0.99
2370	Apache Rose Peacock	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	282226	9312588	0.99
2371	The Greeting Song	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	193593	6346507	0.99
2372	My Lovely Man	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	279118	9220114	0.99
2373	Sir Psycho Sexy	193	1	4	Anthony Kiedis/Chad Smith/Flea/John Frusciante	496692	16354362	0.99
2374	They're Red Hot	193	1	4	Robert Johnson	71941	2382220	0.99
2375	By The Way	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	218017	7197430	0.99
2376	Universally Speaking	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	259213	8501904	0.99
2377	This Is The Place	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	257906	8469765	0.99
2378	Dosed	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	312058	10235611	0.99
2379	Don't Forget Me	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	277995	9107071	0.99
2380	The Zephyr Song	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	232960	7690312	0.99
2381	Can't Stop	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	269400	8872479	0.99
2382	I Could Die For You	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	193906	6333311	0.99
2383	Midnight	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	295810	9702450	0.99
2384	Throw Away Your Television	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	224574	7483526	0.99
2385	Cabron	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	218592	7458864	0.99
2386	Tear	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	317413	10395500	0.99
2387	On Mercury	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	208509	6834762	0.99
2388	Minor Thing	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	217835	7148115	0.99
2389	Warm Tape	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	256653	8358200	0.99
2390	Venice Queen	194	1	1	Anthony Kiedis, Flea, John Frusciante, and Chad Smith	369110	12280381	0.99
2391	Around The World	195	1	1	Anthony Kiedis/Chad Smith/Flea/John Frusciante	238837	7859167	0.99
2392	Parallel Universe	195	1	1	Red Hot Chili Peppers	270654	8958519	0.99
2393	Scar Tissue	195	1	1	Red Hot Chili Peppers	217469	7153744	0.99
2394	Otherside	195	1	1	Red Hot Chili Peppers	255973	8357989	0.99
2395	Get On Top	195	1	1	Red Hot Chili Peppers	198164	6587883	0.99
2396	Californication	195	1	1	Red Hot Chili Peppers	321671	10568999	0.99
2397	Easily	195	1	1	Red Hot Chili Peppers	231418	7504534	0.99
2398	Porcelain	195	1	1	Anthony Kiedis/Chad Smith/Flea/John Frusciante	163787	5278793	0.99
2399	Emit Remmus	195	1	1	Red Hot Chili Peppers	240300	7901717	0.99
2400	I Like Dirt	195	1	1	Red Hot Chili Peppers	157727	5225917	0.99
2401	This Velvet Glove	195	1	1	Red Hot Chili Peppers	225280	7480537	0.99
2402	Savior	195	1	1	Anthony Kiedis/Chad Smith/Flea/John Frusciante	292493	9551885	0.99
2403	Purple Stain	195	1	1	Red Hot Chili Peppers	253440	8359971	0.99
2404	Right On Time	195	1	1	Red Hot Chili Peppers	112613	3722219	0.99
2405	Road Trippin'	195	1	1	Red Hot Chili Peppers	205635	6685831	0.99
2406	The Spirit Of Radio	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	299154	9862012	0.99
2407	The Trees	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	285126	9345473	0.99
2408	Something For Nothing	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	240770	7898395	0.99
2409	Freewill	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	324362	10694110	0.99
2410	Xanadu	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	667428	21753168	0.99
2411	Bastille Day	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	280528	9264769	0.99
2412	By-Tor And The Snow Dog	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	519888	17076397	0.99
2413	Anthem	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	264515	8693343	0.99
2414	Closer To The Heart	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	175412	5767005	0.99
2415	2112 Overture	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	272718	8898066	0.99
2416	The Temples Of Syrinx	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	133459	4360163	0.99
2417	La Villa Strangiato	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	577488	19137855	0.99
2418	Fly By Night	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	202318	6683061	0.99
2419	Finding My Way	196	1	1	Geddy Lee And Alex Lifeson/Geddy Lee And Neil Peart/Rush	305528	9985701	0.99
2420	Jingo	197	1	1	M.Babatunde Olantunji	592953	19736495	0.99
2421	El Corazon Manda	197	1	1	E.Weiss	713534	23519583	0.99
2422	La Puesta Del Sol	197	1	1	E.Weiss	628062	20614621	0.99
2423	Persuasion	197	1	1	Carlos Santana	318432	10354751	0.99
2424	As The Years Go by	197	1	1	Albert King	233064	7566829	0.99
2425	Soul Sacrifice	197	1	1	Carlos Santana	296437	9801120	0.99
2426	Fried Neckbones And Home Fries	197	1	1	W.Correa	638563	20939646	0.99
2427	Santana Jam	197	1	1	Carlos Santana	882834	29207100	0.99
2428	Evil Ways	198	1	1	\N	475402	15289235	0.99
2429	We've Got To Get Together/Jingo	198	1	1	\N	1070027	34618222	0.99
2430	Rock Me	198	1	1	\N	94720	3037596	0.99
2431	Just Ain't Good Enough	198	1	1	\N	850259	27489067	0.99
2432	Funky Piano	198	1	1	\N	934791	30200730	0.99
2433	The Way You Do To Mer	198	1	1	\N	618344	20028702	0.99
2434	Holding Back The Years	141	1	1	Mick Hucknall and Neil Moss	270053	8833220	0.99
2435	Money's Too Tight To Mention	141	1	1	John and William Valentine	268408	8861921	0.99
2436	The Right Thing	141	1	1	Mick Hucknall	262687	8624063	0.99
2437	It's Only Love	141	1	1	Jimmy and Vella Cameron	232594	7659017	0.99
2438	A New Flame	141	1	1	Mick Hucknall	237662	7822875	0.99
2439	You've Got It	141	1	1	Mick Hucknall and Lamont Dozier	235232	7712845	0.99
2440	If You Don't Know Me By Now	141	1	1	Kenny Gamble and Leon Huff	206524	6712634	0.99
2441	Stars	141	1	1	Mick Hucknall	248137	8194906	0.99
2442	Something Got Me Started	141	1	1	Mick Hucknall and Fritz McIntyre	239595	7997139	0.99
2443	Thrill Me	141	1	1	Mick Hucknall and Fritz McIntyre	303934	10034711	0.99
2444	Your Mirror	141	1	1	Mick Hucknall	240666	7893821	0.99
2445	For Your Babies	141	1	1	Mick Hucknall	256992	8408803	0.99
2446	So Beautiful	141	1	1	Mick Hucknall	298083	9837832	0.99
2447	Angel	141	1	1	Carolyn Franklin and Sonny Saunders	240561	7880256	0.99
2448	Fairground	141	1	1	Mick Hucknall	263888	8793094	0.99
2449	�gua E Fogo	199	1	1	Chico Amaral/Edgard Scandurra/Samuel Rosa	278987	9272272	0.99
2450	Tr�s Lados	199	1	1	Chico Amaral/Samuel Rosa	233665	7699609	0.99
2451	Ela Desapareceu	199	1	1	Chico Amaral/Samuel Rosa	250122	8289200	0.99
2452	Balada Do Amor Inabal�vel	199	1	1	Fausto Fawcett/Samuel Rosa	240613	8025816	0.99
2453	Can��o Noturna	199	1	1	Chico Amaral/Lelo Zanettik	238628	7874774	0.99
2454	Mu�ulmano	199	1	1	Le�o, Rodrigo F./Samuel Rosa	249600	8270613	0.99
2455	Maquinarama	199	1	1	Chico Amaral/Samuel Rosa	245629	8213710	0.99
2456	Rebeli�o	199	1	1	Chico Amaral/Samuel Rosa	298527	9817847	0.99
2457	A �ltima Guerra	199	1	1	Le�o, Rodrigo F./L� Borges/Samuel Rosa	314723	10480391	0.99
2458	Fica	199	1	1	Chico Amaral/Samuel Rosa	272169	8980972	0.99
2459	Ali	199	1	1	Nando Reis/Samuel Rosa	306390	10110351	0.99
2460	Preto Dami�o	199	1	1	Chico Amaral/Samuel Rosa	264568	8697658	0.99
2461	� Uma Partida De Futebol	200	1	1	Samuel Rosa	1071	38747	0.99
2462	Eu Disse A Ela	200	1	1	Samuel Rosa	254223	8479463	0.99
2463	Z� Trindade	200	1	1	Samuel Rosa	247954	8331310	0.99
2464	Garota Nacional	200	1	1	Samuel Rosa	317492	10511239	0.99
2465	T�o Seu	200	1	1	Samuel Rosa	243748	8133126	0.99
2466	Sem Terra	200	1	1	Samuel Rosa	279353	9196411	0.99
2467	Os Exilados	200	1	1	Samuel Rosa	245551	8222095	0.99
2468	Um Dia Qualquer	200	1	1	Samuel Rosa	292414	9805570	0.99
2469	Los Pretos	200	1	1	Samuel Rosa	239229	8025667	0.99
2470	Sul Da Am�rica	200	1	1	Samuel Rosa	254928	8484871	0.99
2471	Pocon�	200	1	1	Samuel Rosa	318406	10771610	0.99
2472	Lucky 13	201	1	4	Billy Corgan	189387	6200617	0.99
2473	Aeroplane Flies High	201	1	4	Billy Corgan	473391	15408329	0.99
2474	Because You Are	201	1	4	Billy Corgan	226403	7405137	0.99
2475	Slow Dawn	201	1	4	Billy Corgan	192339	6269057	0.99
2476	Believe	201	1	4	James Iha	192940	6320652	0.99
2477	My Mistake	201	1	4	Billy Corgan	240901	7843477	0.99
2478	Marquis In Spades	201	1	4	Billy Corgan	192731	6304789	0.99
2479	Here's To The Atom Bomb	201	1	4	Billy Corgan	266893	8763140	0.99
2480	Sparrow	201	1	4	Billy Corgan	176822	5696989	0.99
2481	Waiting	201	1	4	Billy Corgan	228336	7627641	0.99
2482	Saturnine	201	1	4	Billy Corgan	229877	7523502	0.99
2483	Rock On	201	1	4	David Cook	366471	12133825	0.99
2484	Set The Ray To Jerry	201	1	4	Billy Corgan	249364	8215184	0.99
2485	Winterlong	201	1	4	Billy Corgan	299389	9670616	0.99
2486	Soot & Stars	201	1	4	Billy Corgan	399986	12866557	0.99
2487	Blissed & Gone	201	1	4	Billy Corgan	286302	9305998	0.99
2488	Siva	202	1	4	Billy Corgan	261172	8576622	0.99
2489	Rhinocerous	202	1	4	Billy Corgan	353462	11526684	0.99
2490	Drown	202	1	4	Billy Corgan	270497	8883496	0.99
2491	Cherub Rock	202	1	4	Billy Corgan	299389	9786739	0.99
2492	Today	202	1	4	Billy Corgan	202213	6596933	0.99
2493	Disarm	202	1	4	Billy Corgan	198556	6508249	0.99
2494	Landslide	202	1	4	Stevie Nicks	190275	6187754	0.99
2495	Bullet With Butterfly Wings	202	1	4	Billy Corgan	257306	8431747	0.99
2496	1979	202	1	4	Billy Corgan	263653	8728470	0.99
2497	Zero	202	1	4	Billy Corgan	161123	5267176	0.99
2498	Tonight, Tonight	202	1	4	Billy Corgan	255686	8351543	0.99
2499	Eye	202	1	4	Billy Corgan	294530	9784201	0.99
2500	Ava Adore	202	1	4	Billy Corgan	261433	8590412	0.99
2501	Perfect	202	1	4	Billy Corgan	203023	6734636	0.99
2502	The Everlasting Gaze	202	1	4	Billy Corgan	242155	7844404	0.99
2503	Stand Inside Your Love	202	1	4	Billy Corgan	253753	8270113	0.99
2504	Real Love	202	1	4	Billy Corgan	250697	8025896	0.99
2505	[Untitled]	202	1	4	Billy Corgan	231784	7689713	0.99
2506	Nothing To Say	203	1	1	Chris Cornell/Kim Thayil	238027	7744833	0.99
2507	Flower	203	1	1	Chris Cornell/Kim Thayil	208822	6830732	0.99
2508	Loud Love	203	1	1	Chris Cornell	297456	9660953	0.99
2509	Hands All Over	203	1	1	Chris Cornell/Kim Thayil	362475	11893108	0.99
2510	Get On The Snake	203	1	1	Chris Cornell/Kim Thayil	225123	7313744	0.99
2511	Jesus Christ Pose	203	1	1	Ben Shepherd/Chris Cornell/Kim Thayil/Matt Cameron	352966	11739886	0.99
2512	Outshined	203	1	1	Chris Cornell	312476	10274629	0.99
2513	Rusty Cage	203	1	1	Chris Cornell	267728	8779485	0.99
2514	Spoonman	203	1	1	Chris Cornell	248476	8289906	0.99
2515	The Day I Tried To Live	203	1	1	Chris Cornell	321175	10507137	0.99
2516	Black Hole Sun	203	1	1	Soundgarden	320365	10425229	0.99
2517	Fell On Black Days	203	1	1	Chris Cornell	282331	9256082	0.99
2518	Pretty Noose	203	1	1	Chris Cornell	253570	8317931	0.99
2519	Burden In My Hand	203	1	1	Chris Cornell	292153	9659911	0.99
2520	Blow Up The Outside World	203	1	1	Chris Cornell	347898	11379527	0.99
2521	Ty Cobb	203	1	1	Ben Shepherd/Chris Cornell	188786	6233136	0.99
2522	Bleed Together	203	1	1	Chris Cornell	232202	7597074	0.99
2523	Morning Dance	204	1	2	Jay Beckenstein	238759	8101979	0.99
2524	Jubilee	204	1	2	Jeremy Wall	275147	9151846	0.99
2525	Rasul	204	1	2	Jeremy Wall	238315	7854737	0.99
2526	Song For Lorraine	204	1	2	Jay Beckenstein	240091	8101723	0.99
2527	Starburst	204	1	2	Jeremy Wall	291500	9768399	0.99
2528	Heliopolis	204	1	2	Jay Beckenstein	338729	11365655	0.99
2529	It Doesn't Matter	204	1	2	Chet Catallo	270027	9034177	0.99
2530	Little Linda	204	1	2	Jeremy Wall	264019	8958743	0.99
2531	End Of Romanticism	204	1	2	Rick Strauss	320078	10553155	0.99
2532	The House Is Rockin'	205	1	6	Doyle Bramhall/Stevie Ray Vaughan	144352	4706253	0.99
2533	Crossfire	205	1	6	B. Carter/C. Layton/R. Ellsworth/R. Wynans/T. Shannon	251219	8238033	0.99
2534	Tightrope	205	1	6	Doyle Bramhall/Stevie Ray Vaughan	281155	9254906	0.99
2535	Let Me Love You Baby	205	1	6	Willie Dixon	164127	5378455	0.99
2536	Leave My Girl Alone	205	1	6	B. Guy	256365	8438021	0.99
2537	Travis Walk	205	1	6	Stevie Ray Vaughan	140826	4650979	0.99
2538	Wall Of Denial	205	1	6	Doyle Bramhall/Stevie Ray Vaughan	336927	11085915	0.99
2539	Scratch-N-Sniff	205	1	6	Doyle Bramhall/Stevie Ray Vaughan	163422	5353627	0.99
2540	Love Me Darlin'	205	1	6	C. Burnett	201586	6650869	0.99
2541	Riviera Paradise	205	1	6	Stevie Ray Vaughan	528692	17232776	0.99
2542	Dead And Bloated	206	1	1	R. DeLeo/Weiland	310386	10170433	0.99
2543	Sex Type Thing	206	1	1	D. DeLeo/Kretz/Weiland	218723	7102064	0.99
2544	Wicked Garden	206	1	1	D. DeLeo/R. DeLeo/Weiland	245368	7989505	0.99
2545	No Memory	206	1	1	Dean Deleo	80613	2660859	0.99
2546	Sin	206	1	1	R. DeLeo/Weiland	364800	12018823	0.99
2547	Naked Sunday	206	1	1	D. DeLeo/Kretz/R. DeLeo/Weiland	229720	7444201	0.99
2548	Creep	206	1	1	R. DeLeo/Weiland	333191	10894988	0.99
2549	Piece Of Pie	206	1	1	R. DeLeo/Weiland	324623	10605231	0.99
2550	Plush	206	1	1	R. DeLeo/Weiland	314017	10229848	0.99
2551	Wet My Bed	206	1	1	R. DeLeo/Weiland	96914	3198627	0.99
2552	Crackerman	206	1	1	Kretz/R. DeLeo/Weiland	194403	6317361	0.99
2553	Where The River Goes	206	1	1	D. DeLeo/Kretz/Weiland	505991	16468904	0.99
2554	Soldier Side - Intro	207	1	3	Dolmayan, John/Malakian, Daron/Odadjian, Shavo	63764	2056079	0.99
2555	B.Y.O.B.	207	1	3	Tankian, Serj	255555	8407935	0.99
2556	Revenga	207	1	3	Tankian, Serj	228127	7503805	0.99
2557	Cigaro	207	1	3	Tankian, Serj	131787	4321705	0.99
2558	Radio/Video	207	1	3	Dolmayan, John/Malakian, Daron/Odadjian, Shavo	249312	8224917	0.99
2559	This Cocaine Makes Me Feel Like I'm On This Song	207	1	3	Tankian, Serj	128339	4185193	0.99
2560	Violent Pornography	207	1	3	Dolmayan, John/Malakian, Daron/Odadjian, Shavo	211435	6985960	0.99
2561	Question!	207	1	3	Tankian, Serj	200698	6616398	0.99
2562	Sad Statue	207	1	3	Tankian, Serj	205897	6733449	0.99
2563	Old School Hollywood	207	1	3	Dolmayan, John/Malakian, Daron/Odadjian, Shavo	176953	5830258	0.99
2564	Lost in Hollywood	207	1	3	Tankian, Serj	320783	10535158	0.99
2565	The Sun Road	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	880640	29008407	0.99
2566	Dark Corners	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	513541	16839223	0.99
2567	Duende	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	447582	14956771	0.99
2568	Black Light Syndrome	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	526471	17300835	0.99
2569	Falling in Circles	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	549093	18263248	0.99
2570	Book of Hours	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	583366	19464726	0.99
2571	Chaos-Control	208	1	1	Terry Bozzio, Steve Stevens, Tony Levin	529841	17455568	0.99
2572	Midnight From The Inside Out	209	1	6	Chris Robinson/Rich Robinson	286981	9442157	0.99
2573	Sting Me	209	1	6	Chris Robinson/Rich Robinson	268094	8813561	0.99
2574	Thick & Thin	209	1	6	Chris Robinson/Rich Robinson	222720	7284377	0.99
2575	Greasy Grass River	209	1	6	Chris Robinson/Rich Robinson	218749	7157045	0.99
2576	Sometimes Salvation	209	1	6	Chris Robinson/Rich Robinson	389146	12749424	0.99
2577	Cursed Diamonds	209	1	6	Chris Robinson/Rich Robinson	368300	12047978	0.99
2578	Miracle To Me	209	1	6	Chris Robinson/Rich Robinson	372636	12222116	0.99
2579	Wiser Time	209	1	6	Chris Robinson/Rich Robinson	459990	15161907	0.99
2580	Girl From A Pawnshop	209	1	6	Chris Robinson/Rich Robinson	404688	13250848	0.99
2581	Cosmic Fiend	209	1	6	Chris Robinson/Rich Robinson	308401	10115556	0.99
2582	Black Moon Creeping	210	1	6	Chris Robinson/Rich Robinson	359314	11740886	0.99
2583	High Head Blues	210	1	6	Chris Robinson/Rich Robinson	371879	12227998	0.99
2584	Title Song	210	1	6	Chris Robinson/Rich Robinson	505521	16501316	0.99
2585	She Talks To Angels	210	1	6	Chris Robinson/Rich Robinson	361978	11837342	0.99
2586	Twice As Hard	210	1	6	Chris Robinson/Rich Robinson	275565	9008067	0.99
2587	Lickin'	210	1	6	Chris Robinson/Rich Robinson	314409	10331216	0.99
2588	Soul Singing	210	1	6	Chris Robinson/Rich Robinson	233639	7672489	0.99
2589	Hard To Handle	210	1	6	A.Isbell/A.Jones/O.Redding	206994	6786304	0.99
2590	Remedy	210	1	6	Chris Robinson/Rich Robinson	337084	11049098	0.99
2591	White Riot	211	1	4	Joe Strummer/Mick Jones	118726	3922819	0.99
2592	Remote Control	211	1	4	Joe Strummer/Mick Jones	180297	5949647	0.99
2593	Complete Control	211	1	4	Joe Strummer/Mick Jones	192653	6272081	0.99
2594	Clash City Rockers	211	1	4	Joe Strummer/Mick Jones	227500	7555054	0.99
2595	(White Man) In Hammersmith Palais	211	1	4	Joe Strummer/Mick Jones	240640	7883532	0.99
2596	Tommy Gun	211	1	4	Joe Strummer/Mick Jones	195526	6399872	0.99
2597	English Civil War	211	1	4	Mick Jones/Traditional arr. Joe Strummer	156708	5111226	0.99
2598	I Fought The Law	211	1	4	Sonny Curtis	159764	5245258	0.99
2599	London Calling	211	1	4	Joe Strummer/Mick Jones	199706	6569007	0.99
2600	Train In Vain	211	1	4	Joe Strummer/Mick Jones	189675	6329877	0.99
2601	Bankrobber	211	1	4	Joe Strummer/Mick Jones	272431	9067323	0.99
2602	The Call Up	211	1	4	The Clash	324336	10746937	0.99
2603	Hitsville UK	211	1	4	The Clash	261433	8606887	0.99
2604	The Magnificent Seven	211	1	4	The Clash	268486	8889821	0.99
2605	This Is Radio Clash	211	1	4	The Clash	249756	8366573	0.99
2606	Know Your Rights	211	1	4	The Clash	217678	7195726	0.99
2607	Rock The Casbah	211	1	4	The Clash	222145	7361500	0.99
2608	Should I Stay Or Should I Go	211	1	4	The Clash	187219	6188688	0.99
2609	War (The Process)	212	1	1	Billy Duffy/Ian Astbury	252630	8254842	0.99
2610	The Saint	212	1	1	Billy Duffy/Ian Astbury	216215	7061584	0.99
2611	Rise	212	1	1	Billy Duffy/Ian Astbury	219088	7106195	0.99
2612	Take The Power	212	1	1	Billy Duffy/Ian Astbury	235755	7650012	0.99
2613	Breathe	212	1	1	Billy Duffy/Ian Astbury/Marti Frederiksen/Mick Jones	299781	9742361	0.99
2614	Nico	212	1	1	Billy Duffy/Ian Astbury	289488	9412323	0.99
2615	American Gothic	212	1	1	Billy Duffy/Ian Astbury	236878	7739840	0.99
2616	Ashes And Ghosts	212	1	1	Billy Duffy/Bob Rock/Ian Astbury	300591	9787692	0.99
2617	Shape The Sky	212	1	1	Billy Duffy/Ian Astbury	209789	6885647	0.99
2618	Speed Of Light	212	1	1	Billy Duffy/Bob Rock/Ian Astbury	262817	8563352	0.99
2619	True Believers	212	1	1	Billy Duffy/Ian Astbury	308009	9981359	0.99
2620	My Bridges Burn	212	1	1	Billy Duffy/Ian Astbury	231862	7571370	0.99
2621	She Sells Sanctuary	213	1	1	\N	253727	8368634	0.99
2622	Fire Woman	213	1	1	\N	312790	10196995	0.99
2623	Lil' Evil	213	1	1	\N	165825	5419655	0.99
2624	Spirit Walker	213	1	1	\N	230060	7555897	0.99
2625	The Witch	213	1	1	\N	258768	8725403	0.99
2626	Revolution	213	1	1	\N	256026	8371254	0.99
2627	Wild Hearted Son	213	1	1	\N	266893	8670550	0.99
2628	Love Removal Machine	213	1	1	\N	257619	8412167	0.99
2629	Rain	213	1	1	\N	236669	7788461	0.99
2630	Edie (Ciao Baby)	213	1	1	\N	241632	7846177	0.99
2631	Heart Of Soul	213	1	1	\N	274207	8967257	0.99
2632	Love	213	1	1	\N	326739	10729824	0.99
2633	Wild Flower	213	1	1	\N	215536	7084321	0.99
2634	Go West	213	1	1	\N	238158	7777749	0.99
2635	Resurrection Joe	213	1	1	\N	255451	8532840	0.99
2636	Sun King	213	1	1	\N	368431	12010865	0.99
2637	Sweet Soul Sister	213	1	1	\N	212009	6889883	0.99
2638	Earth Mofo	213	1	1	\N	282200	9204581	0.99
2639	Break on Through	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	149342	4943144	0.99
2640	Soul Kitchen	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	215066	7040865	0.99
2641	The Crystal Ship	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	154853	5052658	0.99
2642	Twentienth Century Fox	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	153913	5069211	0.99
2643	Alabama Song	214	1	1	Weill-Brecht	200097	6563411	0.99
2644	Light My Fire	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	428329	13963351	0.99
2645	Back Door Man	214	1	1	Willie Dixon, C. Burnett	214360	7035636	0.99
2646	I Looked At You	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	142080	4663988	0.99
2647	End Of The Night	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	172695	5589732	0.99
2648	Take It As It Comes	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	137168	4512656	0.99
2649	The End	214	1	1	Robby Krieger, Ray Manzarek, John Densmore, Jim Morrison	701831	22927336	0.99
2650	Roxanne	215	1	1	G M Sumner	192992	6330159	0.99
2651	Can't Stand Losing You	215	1	1	G M Sumner	181159	5971983	0.99
2652	Message in a Bottle	215	1	1	G M Sumner	291474	9647829	0.99
2653	Walking on the Moon	215	1	1	G M Sumner	302080	10019861	0.99
2654	Don't Stand so Close to Me	215	1	1	G M Sumner	241031	7956658	0.99
2655	De Do Do Do, De Da Da Da	215	1	1	G M Sumner	247196	8227075	0.99
2656	Every Little Thing She Does is Magic	215	1	1	G M Sumner	261120	8646853	0.99
2657	Invisible Sun	215	1	1	G M Sumner	225593	7304320	0.99
2658	Spirit's in the Material World	215	1	1	G M Sumner	181133	5986622	0.99
2659	Every Breath You Take	215	1	1	G M Sumner	254615	8364520	0.99
2660	King Of Pain	215	1	1	G M Sumner	300512	9880303	0.99
2661	Wrapped Around Your Finger	215	1	1	G M Sumner	315454	10361490	0.99
2662	Don't Stand So Close to Me '86	215	1	1	G M Sumner	293590	9636683	0.99
2663	Message in a Bottle (new classic rock mix)	215	1	1	G M Sumner	290951	9640349	0.99
2664	Time Is On My Side	216	1	1	Jerry Ragavoy	179983	5855836	0.99
2665	Heart Of Stone	216	1	1	Jagger/Richards	164493	5329538	0.99
2666	Play With Fire	216	1	1	Nanker Phelge	132022	4265297	0.99
2667	Satisfaction	216	1	1	Jagger/Richards	226612	7398766	0.99
2668	As Tears Go By	216	1	1	Jagger/Richards/Oldham	164284	5357350	0.99
2669	Get Off Of My Cloud	216	1	1	Jagger/Richards	176013	5719514	0.99
2670	Mother's Little Helper	216	1	1	Jagger/Richards	167549	5422434	0.99
2671	19th Nervous Breakdown	216	1	1	Jagger/Richards	237923	7742984	0.99
2672	Paint It Black	216	1	1	Jagger/Richards	226063	7442888	0.99
2673	Under My Thumb	216	1	1	Jagger/Richards	221387	7371799	0.99
2674	Ruby Tuesday	216	1	1	Jagger/Richards	197459	6433467	0.99
2675	Let's Spend The Night Together	216	1	1	Jagger/Richards	217495	7137048	0.99
2676	Intro	217	1	1	Jagger/Richards	49737	1618591	0.99
2677	You Got Me Rocking	217	1	1	Jagger/Richards	205766	6734385	0.99
2678	Gimmie Shelters	217	1	1	Jagger/Richards	382119	12528764	0.99
2679	Flip The Switch	217	1	1	Jagger/Richards	252421	8336591	0.99
2680	Memory Motel	217	1	1	Jagger/Richards	365844	11982431	0.99
2681	Corinna	217	1	1	Jesse Ed Davis III/Taj Mahal	257488	8449471	0.99
2682	Saint Of Me	217	1	1	Jagger/Richards	325694	10725160	0.99
2683	Wainting On A Friend	217	1	1	Jagger/Richards	302497	9978046	0.99
2684	Sister Morphine	217	1	1	Faithfull/Jagger/Richards	376215	12345289	0.99
2685	Live With Me	217	1	1	Jagger/Richards	234893	7709006	0.99
2686	Respectable	217	1	1	Jagger/Richards	215693	7099669	0.99
2687	Thief In The Night	217	1	1	De Beauport/Jagger/Richards	337266	10952756	0.99
2688	The Last Time	217	1	1	Jagger/Richards	287294	9498758	0.99
2689	Out Of Control	217	1	1	Jagger/Richards	479242	15749289	0.99
2690	Love Is Strong	218	1	1	Jagger/Richards	230896	7639774	0.99
2691	You Got Me Rocking	218	1	1	Jagger/Richards	215928	7162159	0.99
2692	Sparks Will Fly	218	1	1	Jagger/Richards	196466	6492847	0.99
2693	The Worst	218	1	1	Jagger/Richards	144613	4750094	0.99
2694	New Faces	218	1	1	Jagger/Richards	172146	5689122	0.99
2695	Moon Is Up	218	1	1	Jagger/Richards	222119	7366316	0.99
2696	Out Of Tears	218	1	1	Jagger/Richards	327418	10677236	0.99
2697	I Go Wild	218	1	1	Jagger/Richards	264019	8630833	0.99
2698	Brand New Car	218	1	1	Jagger/Richards	256052	8459344	0.99
2699	Sweethearts Together	218	1	1	Jagger/Richards	285492	9550459	0.99
2700	Suck On The Jugular	218	1	1	Jagger/Richards	268225	8920566	0.99
2701	Blinded By Rainbows	218	1	1	Jagger/Richards	273946	8971343	0.99
2702	Baby Break It Down	218	1	1	Jagger/Richards	249417	8197309	0.99
2703	Thru And Thru	218	1	1	Jagger/Richards	375092	12175406	0.99
2704	Mean Disposition	218	1	1	Jagger/Richards	249155	8273602	0.99
2705	Walking Wounded	219	1	4	The Tea Party	277968	9184345	0.99
2706	Temptation	219	1	4	The Tea Party	205087	6711943	0.99
2707	The Messenger	219	1	4	Daniel Lanois	212062	6975437	0.99
2708	Psychopomp	219	1	4	The Tea Party	315559	10295199	0.99
2709	Sister Awake	219	1	4	The Tea Party	343875	11299407	0.99
2710	The Bazaar	219	1	4	The Tea Party	222458	7245691	0.99
2711	Save Me (Remix)	219	1	4	The Tea Party	396303	13053839	0.99
2712	Fire In The Head	219	1	4	The Tea Party	306337	10005675	0.99
2713	Release	219	1	4	The Tea Party	244114	8014606	0.99
2714	Heaven Coming Down	219	1	4	The Tea Party	241867	7846459	0.99
2715	The River (Remix)	219	1	4	The Tea Party	343170	11193268	0.99
2716	Babylon	219	1	4	The Tea Party	169795	5568808	0.99
2717	Waiting On A Sign	219	1	4	The Tea Party	261903	8558590	0.99
2718	Life Line	219	1	4	The Tea Party	277786	9082773	0.99
2719	Paint It Black	219	1	4	Keith Richards/Mick Jagger	214752	7101572	0.99
2720	Temptation	220	1	4	The Tea Party	205244	6719465	0.99
2721	Army Ants	220	1	4	The Tea Party	215405	7075838	0.99
2722	Psychopomp	220	1	4	The Tea Party	317231	10351778	0.99
2723	Gyroscope	220	1	4	The Tea Party	177711	5810323	0.99
2724	Alarum	220	1	4	The Tea Party	298187	9712545	0.99
2725	Release	220	1	4	The Tea Party	266292	8725824	0.99
2726	Transmission	220	1	4	The Tea Party	317257	10351152	0.99
2727	Babylon	220	1	4	The Tea Party	292466	9601786	0.99
2728	Pulse	220	1	4	The Tea Party	250253	8183872	0.99
2729	Emerald	220	1	4	The Tea Party	289750	9543789	0.99
2730	Aftermath	220	1	4	The Tea Party	343745	11085607	0.99
2731	I Can't Explain	221	1	1	Pete Townshend	125152	4082896	0.99
2732	Anyway, Anyhow, Anywhere	221	1	1	Pete Townshend, Roger Daltrey	161253	5234173	0.99
2733	My Generation	221	1	1	John Entwistle/Pete Townshend	197825	6446634	0.99
2734	Substitute	221	1	1	Pete Townshend	228022	7409995	0.99
2735	I'm A Boy	221	1	1	Pete Townshend	157126	5120605	0.99
2736	Boris The Spider	221	1	1	John Entwistle	149472	4835202	0.99
2737	Happy Jack	221	1	1	Pete Townshend	132310	4353063	0.99
2738	Pictures Of Lily	221	1	1	Pete Townshend	164414	5329751	0.99
2739	I Can See For Miles	221	1	1	Pete Townshend	262791	8604989	0.99
2740	Magic Bus	221	1	1	Pete Townshend	197224	6452700	0.99
2741	Pinball Wizard	221	1	1	John Entwistle/Pete Townshend	181890	6055580	0.99
2742	The Seeker	221	1	1	Pete Townshend	204643	6736866	0.99
2743	Baba O'Riley	221	1	1	John Entwistle/Pete Townshend	309472	10141660	0.99
2744	Won't Get Fooled Again (Full Length Version)	221	1	1	John Entwistle/Pete Townshend	513750	16855521	0.99
2745	Let's See Action	221	1	1	Pete Townshend	243513	8078418	0.99
2746	5.15	221	1	1	Pete Townshend	289619	9458549	0.99
2747	Join Together	221	1	1	Pete Townshend	262556	8602485	0.99
2748	Squeeze Box	221	1	1	Pete Townshend	161280	5256508	0.99
2749	Who Are You (Single Edit Version)	221	1	1	John Entwistle/Pete Townshend	299232	9900469	0.99
2750	You Better You Bet	221	1	1	Pete Townshend	338520	11160877	0.99
2751	Primavera	222	1	7	Genival Cassiano/Silvio Rochael	126615	4152604	0.99
2752	Chocolate	222	1	7	Tim Maia	194690	6411587	0.99
2753	Azul Da Cor Do Mar	222	1	7	Tim Maia	197955	6475007	0.99
2754	O Descobridor Dos Sete Mares	222	1	7	Gilson Mendon�a/Michel	262974	8749583	0.99
2755	At� Que Enfim Encontrei Voc�	222	1	7	Tim Maia	105064	3477751	0.99
2756	Coron� Antonio Bento	222	1	7	Do Vale, Jo�o/Luiz Wanderley	131317	4340326	0.99
2757	New Love	222	1	7	Tim Maia	237897	7786824	0.99
2758	N�o Vou Ficar	222	1	7	Tim Maia	172068	5642919	0.99
2759	M�sica No Ar	222	1	7	Tim Maia	158511	5184891	0.99
2760	Salve Nossa Senhora	222	1	7	Carlos Imperial/Edardo Ara�jo	115461	3827629	0.99
2761	Voc� Fugiu	222	1	7	Genival Cassiano	238367	7971147	0.99
2762	Cristina N� 2	222	1	7	Carlos Imperial/Tim Maia	90148	2978589	0.99
2763	Compadre	222	1	7	Tim Maia	171389	5631446	0.99
2764	Over Again	222	1	7	Tim Maia	200489	6612634	0.99
2765	R�u Confesso	222	1	7	Tim Maia	217391	7189874	0.99
2766	O Que Me Importa	223	1	7	\N	153155	4977852	0.99
2767	Gostava Tanto De Voc�	223	1	7	\N	253805	8380077	0.99
2768	Voc�	223	1	7	\N	242599	7911702	0.99
2769	N�o Quero Dinheiro	223	1	7	\N	152607	5031797	0.99
2770	Eu Amo Voc�	223	1	7	\N	242782	7914628	0.99
2771	A Festa Do Santo Reis	223	1	7	\N	159791	5204995	0.99
2772	I Don't Know What To Do With Myself	223	1	7	\N	221387	7251478	0.99
2773	Padre C�cero	223	1	7	\N	139598	4581685	0.99
2774	Nosso Adeus	223	1	7	\N	206471	6793270	0.99
2775	Can�rio Do Reino	223	1	7	\N	139337	4552858	0.99
2776	Preciso Ser Amado	223	1	7	\N	174001	5618895	0.99
2777	Balan�o	223	1	7	\N	209737	6890327	0.99
2778	Preciso Aprender A Ser S�	223	1	7	\N	162220	5213894	0.99
2779	Esta � A Can��o	223	1	7	\N	184450	6069933	0.99
2780	Formigueiro	223	1	7	\N	252943	8455132	0.99
2781	Comida	224	1	4	Tit�s	322612	10786578	0.99
2782	Go Back	224	1	4	Tit�s	230504	7668899	0.99
2783	Pr� Dizer Adeus	224	1	4	Tit�s	222484	7382048	0.99
2784	Fam�lia	224	1	4	Tit�s	218331	7267458	0.99
2785	Os Cegos Do Castelo	224	1	4	Tit�s	296829	9868187	0.99
2786	O Pulso	224	1	4	Tit�s	199131	6566998	0.99
2787	Marvin	224	1	4	Tit�s	264359	8741444	0.99
2788	Nem 5 Minutos Guardados	224	1	4	Tit�s	245995	8143797	0.99
2789	Flores	224	1	4	Tit�s	215510	7148017	0.99
2790	Palavras	224	1	4	Tit�s	158458	5285715	0.99
2791	Heredit�rio	224	1	4	Tit�s	151693	5020547	0.99
2792	A Melhor Forma	224	1	4	Tit�s	191503	6349938	0.99
2793	Cabe�a Dinossauro	224	1	4	Tit�s	37120	1220930	0.99
2794	32 Dentes	224	1	4	Tit�s	184946	6157904	0.99
2795	Bichos Escrotos (Vinheta)	224	1	4	Tit�s	104986	3503755	0.99
2796	N�o Vou Lutar	224	1	4	Tit�s	189988	6308613	0.99
2797	Homem Primata (Vinheta)	224	1	4	Tit�s	34168	1124909	0.99
2798	Homem Primata	224	1	4	Tit�s	195500	6486470	0.99
2799	Pol�cia (Vinheta)	224	1	4	Tit�s	56111	1824213	0.99
2800	Querem Meu Sangue	224	1	4	Tit�s	212401	7069773	0.99
2801	Divers�o	224	1	4	Tit�s	285936	9531268	0.99
2802	Televis�o	224	1	4	Tit�s	293668	9776548	0.99
2803	Sonifera Ilha	225	1	4	Branco Mello/Carlos Barmack/Ciro Pessoa/Marcelo Fromer/Toni Belloto	170684	5678290	0.99
2804	Lugar Nenhum	225	1	4	Arnaldo Antunes/Charles Gavin/Marcelo Fromer/S�rgio Britto/Toni Bellotto	195840	6472780	0.99
2805	Sua Impossivel Chance	225	1	4	Nando Reis	246622	8073248	0.99
2806	Desordem	225	1	4	Charles Gavin/Marcelo Fromer/S�rgio Britto	213289	7067340	0.99
2807	N�o Vou Me Adaptar	225	1	4	Arnaldo Antunes	221831	7304656	0.99
2808	Domingo	225	1	4	S�rgio Britto/Toni Bellotto	208613	6883180	0.99
2809	Amanh� N�o Se Sabe	225	1	4	S�rgio Britto	189440	6243967	0.99
2810	Caras Como Eu	225	1	4	Toni Bellotto	183092	5999048	0.99
2811	Senhora E Senhor	225	1	4	Arnaldo Anutnes/Marcelo Fromer/Paulo Miklos	203702	6733733	0.99
2812	Era Uma Vez	225	1	4	Arnaldo Anutnes/Branco Mello/Marcelo Fromer/Sergio Brotto/Toni Bellotto	224261	7453156	0.99
2813	Mis�ria	225	1	4	Arnaldo Antunes/Britto, SergioMiklos, Paulo	262191	8727645	0.99
2814	Insens�vel	225	1	4	S�rgio Britto	207830	6893664	0.99
2815	Eu E Ela	225	1	4	Nando Reis	276035	9138846	0.99
2816	Toda Cor	225	1	4	Ciro Pressoa/Marcelo Fromer	209084	6939176	0.99
2817	� Preciso Saber Viver	225	1	4	Erasmo Carlos/Roberto Carlos	251115	8271418	0.99
2818	Senhor Delegado/Eu N�o Aguento	225	1	4	Antonio Lopes	156656	5277983	0.99
2819	Battlestar Galactica: The Story So Far	226	3	18	\N	2622250	490750393	1.99
2820	Occupation / Precipice	227	3	19	\N	5286953	1054423946	1.99
2821	Exodus, Pt. 1	227	3	19	\N	2621708	475079441	1.99
2822	Exodus, Pt. 2	227	3	19	\N	2618000	466820021	1.99
2823	Collaborators	227	3	19	\N	2626626	483484911	1.99
2824	Torn	227	3	19	\N	2631291	495262585	1.99
2825	A Measure of Salvation	227	3	18	\N	2563938	489715554	1.99
2826	Hero	227	3	18	\N	2713755	506896959	1.99
2827	Unfinished Business	227	3	18	\N	2622038	528499160	1.99
2828	The Passage	227	3	18	\N	2623875	490375760	1.99
2829	The Eye of Jupiter	227	3	18	\N	2618750	517909587	1.99
2830	Rapture	227	3	18	\N	2624541	508406153	1.99
2831	Taking a Break from All Your Worries	227	3	18	\N	2624207	492700163	1.99
2832	The Woman King	227	3	18	\N	2626376	552893447	1.99
2833	A Day In the Life	227	3	18	\N	2620245	462818231	1.99
2834	Dirty Hands	227	3	18	\N	2627961	537648614	1.99
2835	Maelstrom	227	3	18	\N	2622372	514154275	1.99
2836	The Son Also Rises	227	3	18	\N	2621830	499258498	1.99
2837	Crossroads, Pt. 1	227	3	20	\N	2622622	486233524	1.99
2838	Crossroads, Pt. 2	227	3	20	\N	2869953	497335706	1.99
2839	Genesis	228	3	19	\N	2611986	515671080	1.99
2840	Don't Look Back	228	3	21	\N	2571154	493628775	1.99
2841	One Giant Leap	228	3	21	\N	2607649	521616246	1.99
2842	Collision	228	3	21	\N	2605480	526182322	1.99
2843	Hiros	228	3	21	\N	2533575	488835454	1.99
2844	Better Halves	228	3	21	\N	2573031	549353481	1.99
2845	Nothing to Hide	228	3	19	\N	2605647	510058181	1.99
2846	Seven Minutes to Midnight	228	3	21	\N	2613988	515590682	1.99
2847	Homecoming	228	3	21	\N	2601351	516015339	1.99
2848	Six Months Ago	228	3	19	\N	2602852	505133869	1.99
2849	Fallout	228	3	21	\N	2594761	501145440	1.99
2850	The Fix	228	3	21	\N	2600266	507026323	1.99
2851	Distractions	228	3	21	\N	2590382	537111289	1.99
2852	Run!	228	3	21	\N	2602602	542936677	1.99
2853	Unexpected	228	3	21	\N	2598139	511777758	1.99
2854	Company Man	228	3	21	\N	2601226	493168135	1.99
2855	Company Man	228	3	21	\N	2601101	503786316	1.99
2856	Parasite	228	3	21	\N	2602727	487461520	1.99
2857	A Tale of Two Cities	229	3	19	\N	2636970	513691652	1.99
2858	Lost (Pilot, Part 1) [Premiere]	230	3	19	\N	2548875	217124866	1.99
2859	Man of Science, Man of Faith (Premiere)	231	3	19	\N	2612250	543342028	1.99
2860	Adrift	231	3	19	\N	2564958	502663995	1.99
2861	Lost (Pilot, Part 2)	230	3	19	\N	2436583	204995876	1.99
2862	The Glass Ballerina	229	3	21	\N	2637458	535729216	1.99
2863	Further Instructions	229	3	19	\N	2563980	502041019	1.99
2864	Orientation	231	3	19	\N	2609083	500600434	1.99
2865	Tabula Rasa	230	3	19	\N	2627105	210526410	1.99
2866	Every Man for Himself	229	3	21	\N	2637387	513803546	1.99
2867	Everybody Hates Hugo	231	3	19	\N	2609192	498163145	1.99
2868	Walkabout	230	3	19	\N	2587370	207748198	1.99
2869	...And Found	231	3	19	\N	2563833	500330548	1.99
2870	The Cost of Living	229	3	19	\N	2637500	505647192	1.99
2871	White Rabbit	230	3	19	\N	2571965	201654606	1.99
2872	Abandoned	231	3	19	\N	2587041	537348711	1.99
2873	House of the Rising Sun	230	3	19	\N	2590032	210379525	1.99
2874	I Do	229	3	19	\N	2627791	504676825	1.99
2875	Not In Portland	229	3	21	\N	2637303	499061234	1.99
2876	Not In Portland	229	3	21	\N	2637345	510546847	1.99
2877	The Moth	230	3	19	\N	2631327	228896396	1.99
2878	The Other 48 Days	231	3	19	\N	2610625	535256753	1.99
2879	Collision	231	3	19	\N	2564916	475656544	1.99
2880	Confidence Man	230	3	19	\N	2615244	223756475	1.99
2881	Flashes Before Your Eyes	229	3	21	\N	2636636	537760755	1.99
2882	Lost Survival Guide	229	3	21	\N	2632590	486675063	1.99
2883	Solitary	230	3	19	\N	2612894	207045178	1.99
2884	What Kate Did	231	3	19	\N	2610250	484583988	1.99
2885	Raised By Another	230	3	19	\N	2590459	223623810	1.99
2886	Stranger In a Strange Land	229	3	21	\N	2636428	505056021	1.99
2887	The 23rd Psalm	231	3	19	\N	2610416	487401604	1.99
2888	All the Best Cowboys Have Daddy Issues	230	3	19	\N	2555492	211743651	1.99
2889	The Hunting Party	231	3	21	\N	2611333	520350364	1.99
2890	Tricia Tanaka Is Dead	229	3	21	\N	2635010	548197162	1.99
2891	Enter 77	229	3	21	\N	2629796	517521422	1.99
2892	Fire + Water	231	3	21	\N	2600333	488458695	1.99
2893	Whatever the Case May Be	230	3	19	\N	2616410	183867185	1.99
2894	Hearts and Minds	230	3	19	\N	2619462	207607466	1.99
2895	Par Avion	229	3	21	\N	2629879	517079642	1.99
2896	The Long Con	231	3	19	\N	2679583	518376636	1.99
2897	One of Them	231	3	21	\N	2698791	542332389	1.99
2898	Special	230	3	19	\N	2618530	219961967	1.99
2899	The Man from Tallahassee	229	3	21	\N	2637637	550893556	1.99
2900	Expos�	229	3	21	\N	2593760	511338017	1.99
2901	Homecoming	230	3	19	\N	2515882	210675221	1.99
2902	Maternity Leave	231	3	21	\N	2780416	555244214	1.99
2903	Left Behind	229	3	21	\N	2635343	538491964	1.99
2904	Outlaws	230	3	19	\N	2619887	206500939	1.99
2905	The Whole Truth	231	3	21	\N	2610125	495487014	1.99
2906	...In Translation	230	3	19	\N	2604575	215441983	1.99
2907	Lockdown	231	3	21	\N	2610250	543886056	1.99
2908	One of Us	229	3	21	\N	2638096	502387276	1.99
2909	Catch-22	229	3	21	\N	2561394	489773399	1.99
2910	Dave	231	3	19	\N	2825166	574325829	1.99
2911	Numbers	230	3	19	\N	2609772	214709143	1.99
2912	D.O.C.	229	3	21	\N	2616032	518556641	1.99
2913	Deus Ex Machina	230	3	19	\N	2582009	214996732	1.99
2914	S.O.S.	231	3	19	\N	2639541	517979269	1.99
2915	Do No Harm	230	3	19	\N	2618487	212039309	1.99
2916	Two for the Road	231	3	21	\N	2610958	502404558	1.99
2917	The Greater Good	230	3	19	\N	2617784	214130273	1.99
2918	"?"	231	3	19	\N	2782333	528227089	1.99
2919	Born to Run	230	3	19	\N	2618619	213772057	1.99
2920	Three Minutes	231	3	19	\N	2763666	531556853	1.99
2921	Exodus (Part 1)	230	3	19	\N	2620747	213107744	1.99
2922	Live Together, Die Alone, Pt. 1	231	3	21	\N	2478041	457364940	1.99
2923	Exodus (Part 2) [Season Finale]	230	3	19	\N	2605557	208667059	1.99
2924	Live Together, Die Alone, Pt. 2	231	3	19	\N	2656531	503619265	1.99
2925	Exodus (Part 3) [Season Finale]	230	3	19	\N	2619869	197937785	1.99
2926	Zoo Station	232	1	1	U2	276349	9056902	0.99
2927	Even Better Than The Real Thing	232	1	1	U2	221361	7279392	0.99
2928	One	232	1	1	U2	276192	9158892	0.99
2929	Until The End Of The World	232	1	1	U2	278700	9132485	0.99
2930	Who's Gonna Ride Your Wild Horses	232	1	1	U2	316551	10304369	0.99
2931	So Cruel	232	1	1	U2	349492	11527614	0.99
2932	The Fly	232	1	1	U2	268982	8825399	0.99
2933	Mysterious Ways	232	1	1	U2	243826	8062057	0.99
2934	Tryin' To Throw Your Arms Around The World	232	1	1	U2	232463	7612124	0.99
2935	Ultraviolet (Light My Way)	232	1	1	U2	330788	10754631	0.99
2936	Acrobat	232	1	1	U2	270288	8824723	0.99
2937	Love Is Blindness	232	1	1	U2	263497	8531766	0.99
2938	Beautiful Day	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	248163	8056723	0.99
2939	Stuck In A Moment You Can't Get Out Of	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	272378	8997366	0.99
2940	Elevation	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	227552	7479414	0.99
2941	Walk On	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	296280	9800861	0.99
2942	Kite	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	266893	8765761	0.99
2943	In A Little While	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	219271	7189647	0.99
2944	Wild Honey	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	226768	7466069	0.99
2945	Peace On Earth	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	288496	9476171	0.99
2946	When I Look At The World	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	257776	8500491	0.99
2947	New York	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	330370	10862323	0.99
2948	Grace	233	1	1	Adam Clayton, Bono, Larry Mullen, The Edge	330657	10877148	0.99
2949	The Three Sunrises	234	1	1	U2	234788	7717990	0.99
2950	Spanish Eyes	234	1	1	U2	196702	6392710	0.99
2951	Sweetest Thing	234	1	1	U2	185103	6154896	0.99
2952	Love Comes Tumbling	234	1	1	U2	282671	9328802	0.99
2953	Bass Trap	234	1	1	U2	213289	6834107	0.99
2954	Dancing Barefoot	234	1	1	Ivan Kral/Patti Smith	287895	9488294	0.99
2955	Everlasting Love	234	1	1	Buzz Cason/Mac Gayden	202631	6708932	0.99
2956	Unchained Melody	234	1	1	Alex North/Hy Zaret	294164	9597568	0.99
2957	Walk To The Water	234	1	1	U2	289253	9523336	0.99
2958	Luminous Times (Hold On To Love)	234	1	1	Brian Eno/U2	277760	9015513	0.99
2959	Hallelujah Here She Comes	234	1	1	U2	242364	8027028	0.99
2960	Silver And Gold	234	1	1	Bono	279875	9199746	0.99
2961	Endless Deep	234	1	1	U2	179879	5899070	0.99
2962	A Room At The Heartbreak Hotel	234	1	1	U2	274546	9015416	0.99
2963	Trash, Trampoline And The Party Girl	234	1	1	U2	153965	5083523	0.99
2964	Vertigo	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	194612	6329502	0.99
2965	Miracle Drug	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	239124	7760916	0.99
2966	Sometimes You Can't Make It On Your Own	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	308976	10112863	0.99
2967	Love And Peace Or Else	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	290690	9476723	0.99
2968	City Of Blinding Lights	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	347951	11432026	0.99
2969	All Because Of You	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	219141	7198014	0.99
2970	A Man And A Woman	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	270132	8938285	0.99
2971	Crumbs From Your Table	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	303568	9892349	0.99
2972	One Step Closer	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	231680	7512912	0.99
2973	Original Of The Species	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	281443	9230041	0.99
2974	Yahweh	235	1	1	Adam Clayton, Bono, Larry Mullen & The Edge	262034	8636998	0.99
2975	Discotheque	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	319582	10442206	0.99
2976	Do You Feel Loved	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	307539	10122694	0.99
2977	Mofo	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	349178	11583042	0.99
2978	If God Will Send His Angels	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	322533	10563329	0.99
2979	Staring At The Sun	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	276924	9082838	0.99
2980	Last Night On Earth	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	285753	9401017	0.99
2981	Gone	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	266866	8746301	0.99
2982	Miami	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	293041	9741603	0.99
2983	The Playboy Mansion	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	280555	9274144	0.99
2984	If You Wear That Velvet Dress	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	315167	10227333	0.99
2985	Please	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	302602	9909484	0.99
2986	Wake Up Dead Man	236	1	1	Bono, The Edge, Adam Clayton, and Larry Mullen	292832	9515903	0.99
2987	Helter Skelter	237	1	1	Lennon, John/McCartney, Paul	187350	6097636	0.99
2988	Van Diemen's Land	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	186044	5990280	0.99
2989	Desire	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	179226	5874535	0.99
2990	Hawkmoon 269	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	382458	12494987	0.99
2991	All Along The Watchtower	237	1	1	Dylan, Bob	264568	8623572	0.99
2992	I Still Haven't Found What I'm Looking for	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	353567	11542247	0.99
2993	Freedom For My People	237	1	1	Mabins, Macie/Magee, Sterling/Robinson, Bobby	38164	1249764	0.99
2994	Silver And Gold	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	349831	11450194	0.99
2995	Pride (In The Name Of Love)	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	267807	8806361	0.99
2996	Angel Of Harlem	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	229276	7498022	0.99
2997	Love Rescue Me	237	1	1	Bono/Clayton, Adam/Dylan, Bob/Mullen Jr., Larry/The Edge	384522	12508716	0.99
2998	When Love Comes To Town	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	255869	8340954	0.99
2999	Heartland	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	303360	9867748	0.99
3000	God Part II	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	195604	6497570	0.99
3001	The Star Spangled Banner	237	1	1	Hendrix, Jimi	43232	1385810	0.99
3002	Bullet The Blue Sky	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	337005	10993607	0.99
3003	All I Want Is You	237	1	1	Bono/Clayton, Adam/Mullen Jr., Larry/The Edge	390243	12729820	0.99
3004	Pride (In The Name Of Love)	238	1	1	U2	230243	7549085	0.99
3005	New Year's Day	238	1	1	U2	258925	8491818	0.99
3006	With Or Without You	238	1	1	U2	299023	9765188	0.99
3007	I Still Haven't Found What I'm Looking For	238	1	1	U2	280764	9306737	0.99
3008	Sunday Bloody Sunday	238	1	1	U2	282174	9269668	0.99
3009	Bad	238	1	1	U2	351817	11628058	0.99
3010	Where The Streets Have No Name	238	1	1	U2	276218	9042305	0.99
3011	I Will Follow	238	1	1	U2	218253	7184825	0.99
3012	The Unforgettable Fire	238	1	1	U2	295183	9684664	0.99
3013	Sweetest Thing	238	1	1	U2 & Daragh O'Toole	183066	6071385	0.99
3014	Desire	238	1	1	U2	179853	5893206	0.99
3015	When Love Comes To Town	238	1	1	U2	258194	8479525	0.99
3016	Angel Of Harlem	238	1	1	U2	230217	7527339	0.99
3017	All I Want Is You	238	1	1	U2 & Van Dyke Parks	591986	19202252	0.99
3018	Sunday Bloody Sunday	239	1	1	U2	278204	9140849	0.99
3019	Seconds	239	1	1	U2	191582	6352121	0.99
3020	New Year's Day	239	1	1	U2	336274	11054732	0.99
3021	Like A Song...	239	1	1	U2	287294	9365379	0.99
3022	Drowning Man	239	1	1	U2	254458	8457066	0.99
3023	The Refugee	239	1	1	U2	221283	7374043	0.99
3024	Two Hearts Beat As One	239	1	1	U2	243487	7998323	0.99
3025	Red Light	239	1	1	U2	225854	7453704	0.99
3026	Surrender	239	1	1	U2	333505	11221406	0.99
3027	"40"	239	1	1	U2	157962	5251767	0.99
3028	Zooropa	240	1	1	U2; Bono	392359	12807979	0.99
3029	Babyface	240	1	1	U2; Bono	241998	7942573	0.99
3030	Numb	240	1	1	U2; Edge, The	260284	8577861	0.99
3031	Lemon	240	1	1	U2; Bono	418324	13988878	0.99
3032	Stay (Faraway, So Close!)	240	1	1	U2; Bono	298475	9785480	0.99
3033	Daddy's Gonna Pay For Your Crashed Car	240	1	1	U2; Bono	320287	10609581	0.99
3034	Some Days Are Better Than Others	240	1	1	U2; Bono	257436	8417690	0.99
3035	The First Time	240	1	1	U2; Bono	225697	7247651	0.99
3036	Dirty Day	240	1	1	U2; Bono & Edge, The	324440	10652877	0.99
3037	The Wanderer	240	1	1	U2; Bono	283951	9258717	0.99
3038	Breakfast In Bed	241	1	8	\N	196179	6513325	0.99
3039	Where Did I Go Wrong	241	1	8	\N	226742	7485054	0.99
3040	I Would Do For You	241	1	8	\N	334524	11193602	0.99
3041	Homely Girl	241	1	8	\N	203833	6790788	0.99
3042	Here I Am (Come And Take Me)	241	1	8	\N	242102	8106249	0.99
3043	Kingston Town	241	1	8	\N	226951	7638236	0.99
3044	Wear You To The Ball	241	1	8	\N	213342	7159527	0.99
3045	(I Can't Help) Falling In Love With You	241	1	8	\N	207568	6905623	0.99
3046	Higher Ground	241	1	8	\N	260179	8665244	0.99
3047	Bring Me Your Cup	241	1	8	\N	341498	11346114	0.99
3048	C'est La Vie	241	1	8	\N	270053	9031661	0.99
3049	Reggae Music	241	1	8	\N	245106	8203931	0.99
3050	Superstition	241	1	8	\N	319582	10728099	0.99
3051	Until My Dying Day	241	1	8	\N	235807	7886195	0.99
3052	Where Have All The Good Times Gone?	242	1	1	Ray Davies	186723	6063937	0.99
3053	Hang 'Em High	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	210259	6872314	0.99
3054	Cathedral	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	82860	2650998	0.99
3055	Secrets	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	206968	6803255	0.99
3056	Intruder	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	100153	3282142	0.99
3057	(Oh) Pretty Woman	242	1	1	Bill Dees/Roy Orbison	174680	5665828	0.99
3058	Dancing In The Street	242	1	1	Ivy Jo Hunter/Marvin Gaye/William Stevenson	225985	7461499	0.99
3059	Little Guitars (Intro)	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	42240	1439530	0.99
3060	Little Guitars	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	228806	7453043	0.99
3061	Big Bad Bill (Is Sweet William Now)	242	1	1	Jack Yellen/Milton Ager	165146	5489609	0.99
3062	The Full Bug	242	1	1	Alex Van Halen/David Lee Roth/Edward Van Halen/Michael Anthony	201116	6551013	0.99
3063	Happy Trails	242	1	1	Dale Evans	65488	2111141	0.99
3064	Eruption	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony	102164	3272891	0.99
3065	Ain't Talkin' 'bout Love	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony	228336	7569506	0.99
3066	Runnin' With The Devil	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony	215902	7061901	0.99
3067	Dance the Night Away	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony	185965	6087433	0.99
3068	And the Cradle Will Rock...	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony	213968	7011402	0.99
3069	Unchained	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony	208953	6777078	0.99
3070	Jump	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth	241711	7911090	0.99
3071	Panama	243	1	1	Edward Van Halen, Alex Van Halen, David Lee Roth	211853	6921784	0.99
3072	Why Can't This Be Love	243	1	1	Van Halen	227761	7457655	0.99
3073	Dreams	243	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony,/Edward Van Halen, Alex Van Halen, Michael Anthony, Sammy Hagar	291813	9504119	0.99
3074	When It's Love	243	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony,/Edward Van Halen, Alex Van Halen, Michael Anthony, Sammy Hagar	338991	11049966	0.99
3075	Poundcake	243	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony,/Edward Van Halen, Alex Van Halen, Michael Anthony, Sammy Hagar	321854	10366978	0.99
3076	Right Now	243	1	1	Van Halen	321828	10503352	0.99
3077	Can't Stop Loving You	243	1	1	Van Halen	248502	8107896	0.99
3078	Humans Being	243	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony,/Edward Van Halen, Alex Van Halen, Michael Anthony, Sammy Hagar	308950	10014683	0.99
3079	Can't Get This Stuff No More	243	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony,/Edward Van Halen, Alex Van Halen, Michael Anthony, David Lee Roth	315376	10355753	0.99
3080	Me Wise Magic	243	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony,/Edward Van Halen, Alex Van Halen, Michael Anthony, David Lee Roth	366053	12013467	0.99
3081	Runnin' With The Devil	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	216032	7056863	0.99
3082	Eruption	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	102556	3286026	0.99
3083	You Really Got Me	244	1	1	Ray Davies	158589	5194092	0.99
3084	Ain't Talkin' 'Bout Love	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	230060	7617284	0.99
3085	I'm The One	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	226507	7373922	0.99
3086	Jamie's Cryin'	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	210546	6946086	0.99
3087	Atomic Punk	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	182073	5908861	0.99
3088	Feel Your Love Tonight	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	222850	7293608	0.99
3089	Little Dreamer	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	203258	6648122	0.99
3090	Ice Cream Man	244	1	1	John Brim	200306	6573145	0.99
3091	On Fire	244	1	1	Edward Van Halen, Alex Van Halen, Michael Anthony and David Lee Roth	180636	5879235	0.99
3092	Neworld	245	1	1	Van Halen	105639	3495897	0.99
3093	Without You	245	1	1	Van Halen	390295	12619558	0.99
3094	One I Want	245	1	1	Van Halen	330788	10743970	0.99
3095	From Afar	245	1	1	Van Halen	324414	10524554	0.99
3096	Dirty Water Dog	245	1	1	Van Halen	327392	10709202	0.99
3097	Once	245	1	1	Van Halen	462837	15378082	0.99
3098	Fire in the Hole	245	1	1	Van Halen	331728	10846768	0.99
3099	Josephina	245	1	1	Van Halen	342491	11161521	0.99
3100	Year to the Day	245	1	1	Van Halen	514612	16621333	0.99
3101	Primary	245	1	1	Van Halen	86987	2812555	0.99
3102	Ballot or the Bullet	245	1	1	Van Halen	342282	11212955	0.99
3103	How Many Say I	245	1	1	Van Halen	363937	11716855	0.99
3104	Sucker Train Blues	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	267859	8738780	0.99
3105	Do It For The Kids	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	235911	7693331	0.99
3106	Big Machine	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	265613	8673442	0.99
3107	Illegal I Song	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	257750	8483347	0.99
3108	Spectacle	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	221701	7252876	0.99
3109	Fall To Pieces	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	270889	8823096	0.99
3110	Headspace	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	223033	7237986	0.99
3111	Superhuman	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	255921	8365328	0.99
3112	Set Me Free	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	247954	8053388	0.99
3113	You Got No Right	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	335412	10991094	0.99
3114	Slither	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	248398	8118785	0.99
3115	Dirty Little Thing	246	1	1	Dave Kushner, Duff, Keith Nelson, Matt Sorum, Scott Weiland & Slash	237844	7732982	0.99
3116	Loving The Alien	246	1	1	Dave Kushner, Duff, Matt Sorum, Scott Weiland & Slash	348786	11412762	0.99
3117	Pela Luz Dos Olhos Teus	247	1	7	\N	119196	3905715	0.99
3118	A Bencao E Outros	247	1	7	\N	421093	14234427	0.99
3119	Tudo Na Mais Santa Paz	247	1	7	\N	222406	7426757	0.99
3120	O Velho E Aflor	247	1	7	\N	275121	9126828	0.99
3121	Cotidiano N 2	247	1	7	\N	55902	1805797	0.99
3122	Adeus	247	1	7	\N	221884	7259351	0.99
3123	Samba Pra Endrigo	247	1	7	\N	259265	8823551	0.99
3124	So Por Amor	247	1	7	\N	236591	7745764	0.99
3125	Meu Pranto Rolou	247	1	7	\N	181760	6003345	0.99
3126	Mulher Carioca	247	1	7	\N	191686	6395048	0.99
3127	Um Homem Chamado Alfredo	247	1	7	\N	151640	4976227	0.99
3128	Samba Do Jato	247	1	7	\N	220813	7357840	0.99
3129	Oi, La	247	1	7	\N	167053	5562700	0.99
3130	Vinicius, Poeta Do Encontro	247	1	7	\N	336431	10858776	0.99
3131	Soneto Da Separacao	247	1	7	\N	193880	6277511	0.99
3132	Still Of The Night	141	1	3	Sykes	398210	13043817	0.99
3133	Here I Go Again	141	1	3	Marsden	233874	7652473	0.99
3134	Is This Love	141	1	3	Sykes	283924	9262360	0.99
3135	Love Ain't No Stranger	141	1	3	Galley	259395	8490428	0.99
3136	Looking For Love	141	1	3	Sykes	391941	12769847	0.99
3137	Now You're Gone	141	1	3	Vandenberg	251141	8162193	0.99
3138	Slide It In	141	1	3	Coverdale	202475	6615152	0.99
3139	Slow An' Easy	141	1	3	Moody	367255	11961332	0.99
3140	Judgement Day	141	1	3	Vandenberg	317074	10326997	0.99
3141	You're Gonna Break My Hart Again	141	1	3	Sykes	250853	8176847	0.99
3142	The Deeper The Love	141	1	3	Vandenberg	262791	8606504	0.99
3143	Crying In The Rain	141	1	3	Coverdale	337005	10931921	0.99
3144	Fool For Your Loving	141	1	3	Marsden/Moody	250801	8129820	0.99
3145	Sweet Lady Luck	141	1	3	Vandenberg	273737	8919163	0.99
3146	Faixa Amarela	248	1	7	Beto Gogo/Jess� Pai/Luiz Carlos/Zeca Pagodinho	240692	8082036	0.99
3147	Posso At� Me Apaixonar	248	1	7	Dudu Nobre	200698	6735526	0.99
3148	N�o Sou Mais Disso	248	1	7	Jorge Arag�o/Zeca Pagodinho	225985	7613817	0.99
3149	Vivo Isolado Do Mundo	248	1	7	Alcides Dias Lopes	180035	6073995	0.99
3150	Cora��o Em Desalinho	248	1	7	Mauro Diniz/Ratino Sigem	185208	6225948	0.99
3151	Seu Balanc�	248	1	7	Paulinho Rezende/Toninho Geraes	219454	7311219	0.99
3152	Vai Adiar	248	1	7	Alcino Corr�a/Monarco	270393	9134882	0.99
3153	Rugas	248	1	7	Augusto Garcez/Nelson Cavaquinho	140930	4703182	0.99
3154	Feirinha da Pavuna/Luz do Repente/Baga�o da Laranja	248	1	7	Arlindo Cruz/Franco/Marquinhos PQD/Negro, Jovelina P�rolo/Zeca Pagodinho	107206	3593684	0.99
3155	Sem Essa de Malandro Agulha	248	1	7	Aldir Blanc/Jayme Vignoli	158484	5332668	0.99
3156	Chico N�o Vai na Corimba	248	1	7	Dudu Nobre/Zeca Pagodinho	269374	9122188	0.99
3157	Papel Principal	248	1	7	Almir Guineto/Ded� Paraiso/Luverci Ernesto	217495	7325302	0.99
3158	Saudade Louca	248	1	7	Acyr Marques/Arlindo Cruz/Franco	243591	8136475	0.99
3159	Camar�o que Dorme e Onda Leva	248	1	7	Acyi Marques/Arlindo Bruz/Bra�o, Beto Sem/Zeca Pagodinho	299102	10012231	0.99
3160	Sapopemba e Maxambomba	248	1	7	Nei Lopes/Wilson Moreira	245394	8268712	0.99
3161	Minha F�	248	1	7	Muril�o	206994	6981474	0.99
3162	Lua de Ogum	248	1	7	Ratinho/Zeca Pagodinho	168463	5719129	0.99
3163	Samba pras mo�as	248	1	7	Grazielle/Roque Ferreira	152816	5121366	0.99
3164	Verdade	248	1	7	Carlinhos Santana/Nelson Rufino	332826	11120708	0.99
3165	The Brig	229	3	21	\N	2617325	488919543	1.99
3166	.07%	228	3	21	\N	2585794	541715199	1.99
3167	Five Years Gone	228	3	21	\N	2587712	530551890	1.99
3168	The Hard Part	228	3	21	\N	2601017	475996611	1.99
3169	The Man Behind the Curtain	229	3	21	\N	2615990	493951081	1.99
3170	Greatest Hits	229	3	21	\N	2617117	522102916	1.99
3171	Landslide	228	3	21	\N	2600725	518677861	1.99
3172	The Office: An American Workplace (Pilot)	249	3	19	\N	1380833	290482361	1.99
3173	Diversity Day	249	3	19	\N	1306416	257879716	1.99
3174	Health Care	249	3	19	\N	1321791	260493577	1.99
3175	The Alliance	249	3	19	\N	1317125	266203162	1.99
3176	Basketball	249	3	19	\N	1323541	267464180	1.99
3177	Hot Girl	249	3	19	\N	1325458	267836576	1.99
3178	The Dundies	250	3	19	\N	1253541	246845576	1.99
3179	Sexual Harassment	250	3	19	\N	1294541	273069146	1.99
3180	Office Olympics	250	3	19	\N	1290458	256247623	1.99
3181	The Fire	250	3	19	\N	1288166	266856017	1.99
3182	Halloween	250	3	19	\N	1315333	249205209	1.99
3183	The Fight	250	3	19	\N	1320028	277149457	1.99
3184	The Client	250	3	19	\N	1299341	253836788	1.99
3185	Performance Review	250	3	19	\N	1292458	256143822	1.99
3186	Email Surveillance	250	3	19	\N	1328870	265101113	1.99
3187	Christmas Party	250	3	19	\N	1282115	260891300	1.99
3188	Booze Cruise	250	3	19	\N	1267958	252518021	1.99
3189	The Injury	250	3	19	\N	1275275	253912762	1.99
3190	The Secret	250	3	19	\N	1264875	253143200	1.99
3191	The Carpet	250	3	19	\N	1264375	256477011	1.99
3192	Boys and Girls	250	3	19	\N	1278333	255245729	1.99
3193	Valentine's Day	250	3	19	\N	1270375	253552710	1.99
3194	Dwight's Speech	250	3	19	\N	1278041	255001728	1.99
3195	Take Your Daughter to Work Day	250	3	19	\N	1268333	253451012	1.99
3196	Michael's Birthday	250	3	19	\N	1237791	247238398	1.99
3197	Drug Testing	250	3	19	\N	1278625	244626927	1.99
3198	Conflict Resolution	250	3	19	\N	1274583	253808658	1.99
3199	Casino Night - Season Finale	250	3	19	\N	1712791	327642458	1.99
3200	Gay Witch Hunt	251	3	19	\N	1326534	276942637	1.99
3201	The Convention	251	3	19	\N	1297213	255117055	1.99
3202	The Coup	251	3	19	\N	1276526	267205501	1.99
3203	Grief Counseling	251	3	19	\N	1282615	256912833	1.99
3204	The Initiation	251	3	19	\N	1280113	251728257	1.99
3205	Diwali	251	3	19	\N	1279904	252726644	1.99
3206	Branch Closing	251	3	19	\N	1822781	358761786	1.99
3207	The Merger	251	3	19	\N	1801926	345960631	1.99
3208	The Convict	251	3	22	\N	1273064	248863427	1.99
3209	A Benihana Christmas, Pts. 1 & 2	251	3	22	\N	2519436	515301752	1.99
3210	Back from Vacation	251	3	22	\N	1271688	245378749	1.99
3211	Traveling Salesmen	251	3	22	\N	1289039	250822697	1.99
3212	Producer's Cut: The Return	251	3	22	\N	1700241	337219980	1.99
3213	Ben Franklin	251	3	22	\N	1271938	264168080	1.99
3214	Phyllis's Wedding	251	3	22	\N	1271521	258561054	1.99
3215	Business School	251	3	22	\N	1302093	254402605	1.99
3216	Cocktails	251	3	22	\N	1272522	259011909	1.99
3217	The Negotiation	251	3	22	\N	1767851	371663719	1.99
3218	Safety Training	251	3	22	\N	1271229	253054534	1.99
3219	Product Recall	251	3	22	\N	1268268	251208610	1.99
3220	Women's Appreciation	251	3	22	\N	1732649	338778844	1.99
3221	Beach Games	251	3	22	\N	1676134	333671149	1.99
3222	The Job	251	3	22	\N	2541875	501060138	1.99
3223	How to Stop an Exploding Man	228	3	21	\N	2687103	487881159	1.99
3224	Through a Looking Glass	229	3	21	\N	5088838	1059546140	1.99
3225	Your Time Is Gonna Come	252	2	1	Page, Jones	310774	5126563	0.99
3226	Battlestar Galactica, Pt. 1	253	3	20	\N	2952702	541359437	1.99
3227	Battlestar Galactica, Pt. 2	253	3	20	\N	2956081	521387924	1.99
3228	Battlestar Galactica, Pt. 3	253	3	20	\N	2927802	554509033	1.99
3229	Lost Planet of the Gods, Pt. 1	253	3	20	\N	2922547	537812711	1.99
3230	Lost Planet of the Gods, Pt. 2	253	3	20	\N	2914664	534343985	1.99
3231	The Lost Warrior	253	3	20	\N	2920045	558872190	1.99
3232	The Long Patrol	253	3	20	\N	2925008	513122217	1.99
3233	The Gun On Ice Planet Zero, Pt. 1	253	3	20	\N	2907615	540980196	1.99
3234	The Gun On Ice Planet Zero, Pt. 2	253	3	20	\N	2924341	546542281	1.99
3235	The Magnificent Warriors	253	3	20	\N	2924716	570152232	1.99
3236	The Young Lords	253	3	20	\N	2863571	587051735	1.99
3237	The Living Legend, Pt. 1	253	3	20	\N	2924507	503641007	1.99
3238	The Living Legend, Pt. 2	253	3	20	\N	2923298	515632754	1.99
3239	Fire In Space	253	3	20	\N	2926593	536784757	1.99
3240	War of the Gods, Pt. 1	253	3	20	\N	2922630	505761343	1.99
3241	War of the Gods, Pt. 2	253	3	20	\N	2923381	487899692	1.99
3242	The Man With Nine Lives	253	3	20	\N	2956998	577829804	1.99
3243	Murder On the Rising Star	253	3	20	\N	2935894	551759986	1.99
3244	Greetings from Earth, Pt. 1	253	3	20	\N	2960293	536824558	1.99
3245	Greetings from Earth, Pt. 2	253	3	20	\N	2903778	527842860	1.99
3246	Baltar's Escape	253	3	20	\N	2922088	525564224	1.99
3247	Experiment In Terra	253	3	20	\N	2923548	547982556	1.99
3248	Take the Celestra	253	3	20	\N	2927677	512381289	1.99
3249	The Hand of God	253	3	20	\N	2924007	536583079	1.99
3250	Pilot	254	3	19	\N	2484567	492670102	1.99
3251	Through the Looking Glass, Pt. 2	229	3	21	\N	2617117	550943353	1.99
3252	Through the Looking Glass, Pt. 1	229	3	21	\N	2610860	493211809	1.99
3253	Instant Karma	255	2	9	\N	193188	3150090	0.99
3254	#9 Dream	255	2	9	\N	278312	4506425	0.99
3255	Mother	255	2	9	\N	287740	4656660	0.99
3256	Give Peace a Chance	255	2	9	\N	274644	4448025	0.99
3257	Cold Turkey	255	2	9	\N	281424	4556003	0.99
3258	Whatever Gets You Thru the Night	255	2	9	\N	215084	3499018	0.99
3259	I'm Losing You	255	2	9	\N	240719	3907467	0.99
3260	Gimme Some Truth	255	2	9	\N	232778	3780807	0.99
3261	Oh, My Love	255	2	9	\N	159473	2612788	0.99
3262	Imagine	255	2	9	\N	192329	3136271	0.99
3263	Nobody Told Me	255	2	9	\N	210348	3423395	0.99
3264	Jealous Guy	255	2	9	\N	239094	3881620	0.99
3265	Working Class Hero	255	2	9	\N	265449	4301430	0.99
3266	Power to the People	255	2	9	\N	213018	3466029	0.99
3267	Imagine	255	2	9	\N	219078	3562542	0.99
3268	Beautiful Boy	255	2	9	\N	227995	3704642	0.99
3269	Isolation	255	2	9	\N	156059	2558399	0.99
3270	Watching the Wheels	255	2	9	\N	198645	3237063	0.99
3271	Grow Old With Me	255	2	9	\N	149093	2447453	0.99
3272	Gimme Some Truth	255	2	9	\N	187546	3060083	0.99
3273	[Just Like] Starting Over	255	2	9	\N	215549	3506308	0.99
3274	God	255	2	9	\N	260410	4221135	0.99
3275	Real Love	255	2	9	\N	236911	3846658	0.99
3276	Sympton of the Universe	256	2	1	\N	340890	5489313	0.99
3277	Snowblind	256	2	1	\N	295960	4773171	0.99
3278	Black Sabbath	256	2	1	\N	364180	5860455	0.99
3279	Fairies Wear Boots	256	2	1	\N	392764	6315916	0.99
3280	War Pigs	256	2	1	\N	515435	8270194	0.99
3281	The Wizard	256	2	1	\N	282678	4561796	0.99
3282	N.I.B.	256	2	1	\N	335248	5399456	0.99
3283	Sweet Leaf	256	2	1	\N	354706	5709700	0.99
3284	Never Say Die	256	2	1	\N	258343	4173799	0.99
3285	Sabbath, Bloody Sabbath	256	2	1	\N	333622	5373633	0.99
3286	Iron Man/Children of the Grave	256	2	1	\N	552308	8858616	0.99
3287	Paranoid	256	2	1	\N	189171	3071042	0.99
3288	Rock You Like a Hurricane	257	2	1	\N	255766	4300973	0.99
3289	No One Like You	257	2	1	\N	240325	4050259	0.99
3290	The Zoo	257	2	1	\N	332740	5550779	0.99
3291	Loving You Sunday Morning	257	2	1	\N	339125	5654493	0.99
3292	Still Loving You	257	2	1	\N	390674	6491444	0.99
3293	Big City Nights	257	2	1	\N	251865	4237651	0.99
3294	Believe in Love	257	2	1	\N	325774	5437651	0.99
3295	Rhythm of Love	257	2	1	\N	231246	3902834	0.99
3296	I Can't Explain	257	2	1	\N	205332	3482099	0.99
3297	Tease Me Please Me	257	2	1	\N	287229	4811894	0.99
3298	Wind of Change	257	2	1	\N	315325	5268002	0.99
3299	Send Me an Angel	257	2	1	\N	273041	4581492	0.99
3300	Jump Around	258	1	17	E. Schrody/L. Muggerud	217835	8715653	0.99
3301	Salutations	258	1	17	E. Schrody/L. Dimant	69120	2767047	0.99
3302	Put Your Head Out	258	1	17	E. Schrody/L. Freese/L. Muggerud	182230	7291473	0.99
3303	Top O' The Morning To Ya	258	1	17	E. Schrody/L. Dimant	216633	8667599	0.99
3304	Commercial 1	258	1	17	L. Muggerud	7941	319888	0.99
3305	House And The Rising Sun	258	1	17	E. Schrody/J. Vasquez/L. Dimant	219402	8778369	0.99
3306	Shamrocks And Shenanigans	258	1	17	E. Schrody/L. Dimant	218331	8735518	0.99
3307	House Of Pain Anthem	258	1	17	E. Schrody/L. Dimant	155611	6226713	0.99
3308	Danny Boy, Danny Boy	258	1	17	E. Schrody/L. Muggerud	114520	4583091	0.99
3309	Guess Who's Back	258	1	17	E. Schrody/L. Muggerud	238393	9537994	0.99
3310	Commercial 2	258	1	17	L. Muggerud	21211	850698	0.99
3311	Put On Your Shit Kickers	258	1	17	E. Schrody/L. Muggerud	190432	7619569	0.99
3312	Come And Get Some Of This	258	1	17	E. Schrody/L. Muggerud/R. Medrano	170475	6821279	0.99
3313	Life Goes On	258	1	17	E. Schrody/R. Medrano	163030	6523458	0.99
3314	One For The Road	258	1	17	E. Schrody/L. Dimant/L. Muggerud	170213	6810820	0.99
3315	Feel It	258	1	17	E. Schrody/R. Medrano	239908	9598588	0.99
3316	All My Love	258	1	17	E. Schrody/L. Dimant	200620	8027065	0.99
3317	Jump Around (Pete Rock Remix)	258	1	17	E. Schrody/L. Muggerud	236120	9447101	0.99
3318	Shamrocks And Shenanigans (Boom Shalock Lock Boom/Butch Vig Mix)	258	1	17	E. Schrody/L. Dimant	237035	9483705	0.99
3319	Instinto Colectivo	259	1	15	\N	300564	12024875	0.99
3320	Chapa o Coco	259	1	15	\N	143830	5755478	0.99
3321	Prostituta	259	1	15	\N	359000	14362307	0.99
3322	Eu So Queria Sumir	259	1	15	\N	269740	10791921	0.99
3323	Tres Reis	259	1	15	\N	304143	12168015	0.99
3324	Um Lugar ao Sol	259	1	15	\N	212323	8495217	0.99
3325	Batalha Naval	259	1	15	\N	285727	11431382	0.99
3326	Todo o Carnaval tem seu Fim	259	1	15	\N	237426	9499371	0.99
3327	O Misterio do Samba	259	1	15	\N	226142	9047970	0.99
3328	Armadura	259	1	15	\N	232881	9317533	0.99
3329	Na Ladeira	259	1	15	\N	221570	8865099	0.99
3330	Carimbo	259	1	15	\N	328751	13152314	0.99
3331	Catimbo	259	1	15	\N	254484	10181692	0.99
3332	Funk de Bamba	259	1	15	\N	237322	9495184	0.99
3333	Chega no Suingue	259	1	15	\N	221805	8874509	0.99
3334	Mun-Ra	259	1	15	\N	274651	10988338	0.99
3335	Freestyle Love	259	1	15	\N	318484	12741680	0.99
3336	War Pigs	260	4	23	\N	234013	8052374	0.99
3337	Past, Present, and Future	261	3	21	\N	2492867	490796184	1.99
3338	The Beginning of the End	261	3	21	\N	2611903	526865050	1.99
3339	LOST Season 4 Trailer	261	3	21	\N	112712	20831818	1.99
3340	LOST In 8:15	261	3	21	\N	497163	98460675	1.99
3341	Confirmed Dead	261	3	21	\N	2611986	512168460	1.99
3342	The Economist	261	3	21	\N	2609025	516934914	1.99
3343	Eggtown	261	3	19	\N	2608817	501061240	1.99
3344	The Constant	261	3	21	\N	2611569	520209363	1.99
3345	The Other Woman	261	3	21	\N	2605021	513246663	1.99
3346	Ji Yeon	261	3	19	\N	2588797	506458858	1.99
3347	Meet Kevin Johnson	261	3	19	\N	2612028	504132981	1.99
3348	The Shape of Things to Come	261	3	21	\N	2591299	502284266	1.99
3349	Amanda	262	5	2	Luca Gusella	246503	4011615	0.99
3350	Despertar	262	5	2	Andrea Dulbecco	307385	4821485	0.99
3351	Din Din Wo (Little Child)	263	5	16	Habib Koit�	285837	4615841	0.99
3352	Distance	264	5	15	Karsh Kale/Vishal Vaid	327122	5327463	0.99
3353	I Guess You're Right	265	5	1	Darius "Take One" Minwalla/Jon Auer/Ken Stringfellow/Matt Harris	212044	3453849	0.99
3354	I Ka Barra (Your Work)	263	5	16	Habib Koit�	300605	4855457	0.99
3355	Love Comes	265	5	1	Darius "Take One" Minwalla/Jon Auer/Ken Stringfellow/Matt Harris	199923	3240609	0.99
3356	Muita Bobeira	266	5	7	Luciana Souza	172710	2775071	0.99
3357	OAM's Blues	267	5	2	Aaron Goldberg	266936	4292028	0.99
3358	One Step Beyond	264	5	15	Karsh Kale	366085	6034098	0.99
3359	Symphony No. 3 in E-flat major, Op. 55, "Eroica" - Scherzo: Allegro Vivace	268	5	24	Ludwig van Beethoven	356426	5817216	0.99
3360	Something Nice Back Home	261	3	21	\N	2612779	484711353	1.99
3361	Cabin Fever	261	3	21	\N	2612028	477733942	1.99
3362	There's No Place Like Home, Pt. 1	261	3	21	\N	2609526	522919189	1.99
3363	There's No Place Like Home, Pt. 2	261	3	21	\N	2497956	523748920	1.99
3364	There's No Place Like Home, Pt. 3	261	3	21	\N	2582957	486161766	1.99
3365	Say Hello 2 Heaven	269	2	23	\N	384497	6477217	0.99
3366	Reach Down	269	2	23	\N	672773	11157785	0.99
3367	Hunger Strike	269	2	23	\N	246292	4233212	0.99
3368	Pushin Forward Back	269	2	23	\N	225278	3892066	0.99
3369	Call Me a Dog	269	2	23	\N	304458	5177612	0.99
3370	Times of Trouble	269	2	23	\N	342539	5795951	0.99
3371	Wooden Jesus	269	2	23	\N	250565	4302603	0.99
3372	Your Savior	269	2	23	\N	244226	4199626	0.99
3373	Four Walled World	269	2	23	\N	414474	6964048	0.99
3374	All Night Thing	269	2	23	\N	231803	3997982	0.99
3375	No Such Thing	270	2	23	Chris Cornell	224837	3691272	0.99
3376	Poison Eye	270	2	23	Chris Cornell	237120	3890037	0.99
3377	Arms Around Your Love	270	2	23	Chris Cornell	214016	3516224	0.99
3378	Safe and Sound	270	2	23	Chris Cornell	256764	4207769	0.99
3379	She'll Never Be Your Man	270	2	23	Chris Cornell	204078	3355715	0.99
3380	Ghosts	270	2	23	Chris Cornell	231547	3799745	0.99
3381	Killing Birds	270	2	23	Chris Cornell	218498	3588776	0.99
3382	Billie Jean	270	2	23	Michael Jackson	281401	4606408	0.99
3383	Scar On the Sky	270	2	23	Chris Cornell	220193	3616618	0.99
3384	Your Soul Today	270	2	23	Chris Cornell	205959	3385722	0.99
3385	Finally Forever	270	2	23	Chris Cornell	217035	3565098	0.99
3386	Silence the Voices	270	2	23	Chris Cornell	267376	4379597	0.99
3387	Disappearing Act	270	2	23	Chris Cornell	273320	4476203	0.99
3388	You Know My Name	270	2	23	Chris Cornell	240255	3940651	0.99
3389	Revelations	271	2	23	\N	252376	4111051	0.99
3390	One and the Same	271	2	23	\N	217732	3559040	0.99
3391	Sound of a Gun	271	2	23	\N	260154	4234990	0.99
3392	Until We Fall	271	2	23	\N	230758	3766605	0.99
3393	Original Fire	271	2	23	\N	218916	3577821	0.99
3394	Broken City	271	2	23	\N	228366	3728955	0.99
3395	Somedays	271	2	23	\N	213831	3497176	0.99
3396	Shape of Things to Come	271	2	23	\N	274597	4465399	0.99
3397	Jewel of the Summertime	271	2	23	\N	233242	3806103	0.99
3398	Wide Awake	271	2	23	\N	266308	4333050	0.99
3399	Nothing Left to Say But Goodbye	271	2	23	\N	213041	3484335	0.99
3400	Moth	271	2	23	\N	298049	4838884	0.99
3401	Show Me How to Live (Live at the Quart Festival)	271	2	23	\N	301974	4901540	0.99
3402	Band Members Discuss Tracks from "Revelations"	271	3	23	\N	294294	61118891	0.99
3403	Intoitus: Adorate Deum	272	2	24	Anonymous	245317	4123531	0.99
3404	Miserere mei, Deus	273	2	24	Gregorio Allegri	501503	8285941	0.99
3405	Canon and Gigue in D Major: I. Canon	274	2	24	Johann Pachelbel	271788	4438393	0.99
3406	Concerto No. 1 in E Major, RV 269 "Spring": I. Allegro	275	2	24	Antonio Vivaldi	199086	3347810	0.99
3407	Concerto for 2 Violins in D Minor, BWV 1043: I. Vivace	276	2	24	Johann Sebastian Bach	193722	3192890	0.99
3408	Aria Mit 30 Ver�nderungen, BWV 988 "Goldberg Variations": Aria	277	2	24	Johann Sebastian Bach	120463	2081895	0.99
3409	Suite for Solo Cello No. 1 in G Major, BWV 1007: I. Pr�lude	278	2	24	Johann Sebastian Bach	143288	2315495	0.99
3410	The Messiah: Behold, I Tell You a Mystery... The Trumpet Shall Sound	279	2	24	George Frideric Handel	582029	9553140	0.99
3411	Solomon HWV 67: The Arrival of the Queen of Sheba	280	2	24	George Frideric Handel	197135	3247914	0.99
3412	"Eine Kleine Nachtmusik" Serenade In G, K. 525: I. Allegro	281	2	24	Wolfgang Amadeus Mozart	348971	5760129	0.99
3413	Concerto for Clarinet in A Major, K. 622: II. Adagio	282	2	24	Wolfgang Amadeus Mozart	394482	6474980	0.99
3414	Symphony No. 104 in D Major "London": IV. Finale: Spiritoso	283	4	24	Franz Joseph Haydn	306687	10085867	0.99
3415	Symphony No.5 in C Minor: I. Allegro con brio	284	2	24	Ludwig van Beethoven	392462	6419730	0.99
3416	Ave Maria	285	2	24	Franz Schubert	338243	5605648	0.99
3417	Nabucco: Chorus, "Va, Pensiero, Sull'ali Dorate"	286	2	24	Giuseppe Verdi	274504	4498583	0.99
3418	Die Walk�re: The Ride of the Valkyries	287	2	24	Richard Wagner	189008	3114209	0.99
3419	Requiem, Op.48: 4. Pie Jesu	288	2	24	Gabriel Faur�	258924	4314850	0.99
3420	The Nutcracker, Op. 71a, Act II: Scene 14: Pas de deux: Dance of the Prince & the Sugar-Plum Fairy	289	2	24	Peter Ilyich Tchaikovsky	304226	5184289	0.99
3421	Nimrod (Adagio) from Variations On an Original Theme, Op. 36 "Enigma"	290	2	24	Edward Elgar	250031	4124707	0.99
3422	Madama Butterfly: Un Bel D� Vedremo	291	2	24	Giacomo Puccini	277639	4588197	0.99
3423	Jupiter, the Bringer of Jollity	292	2	24	Gustav Holst	522099	8547876	0.99
3424	Turandot, Act III, Nessun dorma!	293	2	24	Giacomo Puccini	176911	2920890	0.99
3425	Adagio for Strings from the String Quartet, Op. 11	294	2	24	Samuel Barber	596519	9585597	0.99
3426	Carmina Burana: O Fortuna	295	2	24	Carl Orff	156710	2630293	0.99
3427	Fanfare for the Common Man	296	2	24	Aaron Copland	198064	3211245	0.99
3428	Branch Closing	251	3	22	\N	1814855	360331351	1.99
3429	The Return	251	3	22	\N	1705080	343877320	1.99
3430	Toccata and Fugue in D Minor, BWV 565: I. Toccata	297	2	24	Johann Sebastian Bach	153901	2649938	0.99
3431	Symphony No.1 in D Major, Op.25 "Classical", Allegro Con Brio	298	2	24	Sergei Prokofiev	254001	4195542	0.99
3432	Scheherazade, Op. 35: I. The Sea and Sindbad's Ship	299	2	24	Nikolai Rimsky-Korsakov	545203	8916313	0.99
3433	Concerto No.2 in F Major, BWV1047, I. Allegro	300	2	24	Johann Sebastian Bach	307244	5064553	0.99
3434	Concerto for Piano No. 2 in F Minor, Op. 21: II. Larghetto	301	2	24	Fr�d�ric Chopin	560342	9160082	0.99
3435	Cavalleria Rusticana \\ Act \\ Intermezzo Sinfonico	302	2	24	Pietro Mascagni	243436	4001276	0.99
3436	Karelia Suite, Op.11: 2. Ballade (Tempo Di Menuetto)	303	2	24	Jean Sibelius	406000	5908455	0.99
3437	Piano Sonata No. 14 in C Sharp Minor, Op. 27, No. 2, "Moonlight": I. Adagio sostenuto	304	2	24	Ludwig van Beethoven	391000	6318740	0.99
3438	Fantasia On Greensleeves	280	2	24	Ralph Vaughan Williams	268066	4513190	0.99
3439	Das Lied Von Der Erde, Von Der Jugend	305	2	24	Gustav Mahler	223583	3700206	0.99
3440	Concerto for Cello and Orchestra in E minor, Op. 85: I. Adagio - Moderato	306	2	24	Edward Elgar	483133	7865479	0.99
3441	Two Fanfares for Orchestra: II. Short Ride in a Fast Machine	307	2	24	John Adams	254930	4310896	0.99
3442	Wellington's Victory or the Battle Symphony, Op.91: 2. Symphony of Triumph	308	2	24	Ludwig van Beethoven	412000	6965201	0.99
3443	Missa Papae Marcelli: Kyrie	309	2	24	Giovanni Pierluigi da Palestrina	240666	4244149	0.99
3444	Romeo et Juliette: No. 11 - Danse des Chevaliers	310	2	24	\N	275015	4519239	0.99
3445	On the Beautiful Blue Danube	311	2	24	Johann Strauss II	526696	8610225	0.99
3446	Symphonie Fantastique, Op. 14: V. Songe d'une nuit du sabbat	312	2	24	Hector Berlioz	561967	9173344	0.99
3447	Carmen: Overture	313	2	24	Georges Bizet	132932	2189002	0.99
3448	Lamentations of Jeremiah, First Set \\ Incipit Lamentatio	314	2	24	Thomas Tallis	69194	1208080	0.99
3449	Music for the Royal Fireworks, HWV351 (1749): La R�jouissance	315	2	24	George Frideric Handel	120000	2193734	0.99
3450	Peer Gynt Suite No.1, Op.46: 1. Morning Mood	316	2	24	Edvard Grieg	253422	4298769	0.99
3451	Die Zauberfl�te, K.620: "Der H�lle Rache Kocht in Meinem Herze"	317	2	25	Wolfgang Amadeus Mozart	174813	2861468	0.99
3452	SCRIABIN: Prelude in B Major, Op. 11, No. 11	318	4	24	\N	101293	3819535	0.99
3453	Pavan, Lachrimae Antiquae	319	2	24	John Dowland	253281	4211495	0.99
3454	Symphony No. 41 in C Major, K. 551, "Jupiter": IV. Molto allegro	320	2	24	Wolfgang Amadeus Mozart	362933	6173269	0.99
3455	Rehab	321	2	14	\N	213240	3416878	0.99
3456	You Know I'm No Good	321	2	14	\N	256946	4133694	0.99
3457	Me & Mr. Jones	321	2	14	\N	151706	2449438	0.99
3458	Just Friends	321	2	14	\N	191933	3098906	0.99
3459	Back to Black	321	2	14	Mark Ronson	240320	3852953	0.99
3460	Love Is a Losing Game	321	2	14	\N	154386	2509409	0.99
3461	Tears Dry On Their Own	321	2	14	Nickolas Ashford & Valerie Simpson	185293	2996598	0.99
3462	Wake Up Alone	321	2	14	Paul O'duffy	221413	3576773	0.99
3463	Some Unholy War	321	2	14	\N	141520	2304465	0.99
3464	He Can Only Hold Her	321	2	14	Richard Poindexter & Robert Poindexter	166680	2666531	0.99
3465	You Know I'm No Good (feat. Ghostface Killah)	321	2	14	\N	202320	3260658	0.99
3466	Rehab (Hot Chip Remix)	321	2	14	\N	418293	6670600	0.99
3467	Intro / Stronger Than Me	322	2	9	\N	234200	3832165	0.99
3468	You Sent Me Flying / Cherry	322	2	9	\N	409906	6657517	0.99
3469	F**k Me Pumps	322	2	9	Salaam Remi	200253	3324343	0.99
3470	I Heard Love Is Blind	322	2	9	\N	129666	2190831	0.99
3471	(There Is) No Greater Love (Teo Licks)	322	2	9	Isham Jones & Marty Symes	167933	2773507	0.99
3472	In My Bed	322	2	9	Salaam Remi	315960	5211774	0.99
3473	Take the Box	322	2	9	Luke Smith	199160	3281526	0.99
3474	October Song	322	2	9	Matt Rowe & Stefan Skarbek	204846	3358125	0.99
3475	What Is It About Men	322	2	9	Delroy "Chris" Cooper, Donovan Jackson, Earl Chinna Smith, Felix Howard, Gordon Williams, Luke Smith, Paul Watson & Wilburn Squiddley Cole	209573	3426106	0.99
3476	Help Yourself	322	2	9	Freddy James, Jimmy hogarth & Larry Stock	300884	5029266	0.99
3477	Amy Amy Amy (Outro)	322	2	9	Astor Campbell, Delroy "Chris" Cooper, Donovan Jackson, Dorothy Fields, Earl Chinna Smith, Felix Howard, Gordon Williams, James Moody, Jimmy McHugh, Matt Rowe, Salaam Remi & Stefan Skarbek	663426	10564704	0.99
3478	Slowness	323	2	23	\N	215386	3644793	0.99
3479	Prometheus Overture, Op. 43	324	4	24	Ludwig van Beethoven	339567	10887931	0.99
3480	Sonata for Solo Violin: IV: Presto	325	4	24	B�la Bart�k	299350	9785346	0.99
3481	A Midsummer Night's Dream, Op.61 Incidental Music: No.7 Notturno	326	2	24	\N	387826	6497867	0.99
3482	Suite No. 3 in D, BWV 1068: III. Gavotte I & II	327	2	24	Johann Sebastian Bach	225933	3847164	0.99
3483	Concert pour 4 Parties de V**les, H. 545: I. Prelude	328	2	24	Marc-Antoine Charpentier	110266	1973559	0.99
3484	Adios nonino	329	2	24	Astor Piazzolla	289388	4781384	0.99
3485	Symphony No. 3 Op. 36 for Orchestra and Soprano "Symfonia Piesni Zalosnych" \\ Lento E Largo - Tranquillissimo	330	2	24	Henryk G�recki	567494	9273123	0.99
3486	Act IV, Symphony	331	2	24	Henry Purcell	364296	5987695	0.99
3487	3 Gymnop�dies: No.1 - Lent Et Grave, No.3 - Lent Et Douloureux	332	2	24	Erik Satie	385506	6458501	0.99
3488	Music for the Funeral of Queen Mary: VI. "Thou Knowest, Lord, the Secrets of Our Hearts"	333	2	24	Henry Purcell	142081	2365930	0.99
3489	Symphony No. 2: III. Allegro vivace	334	2	24	Kurt Weill	376510	6129146	0.99
3490	Partita in E Major, BWV 1006A: I. Prelude	335	2	24	Johann Sebastian Bach	285673	4744929	0.99
3491	Le Sacre Du Printemps: I.iv. Spring Rounds	336	2	24	Igor Stravinsky	234746	4072205	0.99
3492	Sing Joyfully	314	2	24	William Byrd	133768	2256484	0.99
3493	Metopes, Op. 29: Calypso	337	2	24	Karol Szymanowski	333669	5548755	0.99
3494	Symphony No. 2, Op. 16 -  "The Four Temperaments": II. Allegro Comodo e Flemmatico	338	2	24	Carl Nielsen	286998	4834785	0.99
3495	24 Caprices, Op. 1, No. 24, for Solo Violin, in A Minor	339	2	24	Niccol� Paganini	265541	4371533	0.99
3496	�tude 1, In C Major - Preludio (Presto) - Liszt	340	4	24	\N	51780	2229617	0.99
3497	Erlkonig, D.328	341	2	24	\N	261849	4307907	0.99
3498	Concerto for Violin, Strings and Continuo in G Major, Op. 3, No. 9: I. Allegro	342	4	24	Pietro Antonio Locatelli	493573	16454937	0.99
3499	Pini Di Roma (Pinien Von Rom) \\ I Pini Della Via Appia	343	2	24	\N	286741	4718950	0.99
3500	String Quartet No. 12 in C Minor, D. 703 "Quartettsatz": II. Andante - Allegro assai	344	2	24	Franz Schubert	139200	2283131	0.99
3501	L'orfeo, Act 3, Sinfonia (Orchestra)	345	2	24	Claudio Monteverdi	66639	1189062	0.99
3502	Quintet for Horn, Violin, 2 Violas, and Cello in E Flat Major, K. 407/386c: III. Allegro	346	2	24	Wolfgang Amadeus Mozart	221331	3665114	0.99
3503	Koyaanisqatsi	347	2	10	Philip Glass	206005	3305164	0.99
\.


--
-- Name: Album PK_Album; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "PK_Album" PRIMARY KEY ("AlbumId");


--
-- Name: Artist PK_Artist; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Artist"
    ADD CONSTRAINT "PK_Artist" PRIMARY KEY ("ArtistId");


--
-- Name: Customer PK_Customer; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "PK_Customer" PRIMARY KEY ("CustomerId");


--
-- Name: Employee PK_Employee; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "PK_Employee" PRIMARY KEY ("EmployeeId");


--
-- Name: Genre PK_Genre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Genre"
    ADD CONSTRAINT "PK_Genre" PRIMARY KEY ("GenreId");


--
-- Name: Invoice PK_Invoice; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invoice"
    ADD CONSTRAINT "PK_Invoice" PRIMARY KEY ("InvoiceId");


--
-- Name: InvoiceLine PK_InvoiceLine; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InvoiceLine"
    ADD CONSTRAINT "PK_InvoiceLine" PRIMARY KEY ("InvoiceLineId");


--
-- Name: MediaType PK_MediaType; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MediaType"
    ADD CONSTRAINT "PK_MediaType" PRIMARY KEY ("MediaTypeId");


--
-- Name: Playlist PK_Playlist; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Playlist"
    ADD CONSTRAINT "PK_Playlist" PRIMARY KEY ("PlaylistId");


--
-- Name: PlaylistTrack PK_PlaylistTrack; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PlaylistTrack"
    ADD CONSTRAINT "PK_PlaylistTrack" PRIMARY KEY ("PlaylistId", "TrackId");


--
-- Name: Track PK_Track; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Track"
    ADD CONSTRAINT "PK_Track" PRIMARY KEY ("TrackId");


--
-- Name: IFK_AlbumArtistId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_AlbumArtistId" ON public."Album" USING btree ("ArtistId");


--
-- Name: IFK_CustomerSupportRepId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_CustomerSupportRepId" ON public."Customer" USING btree ("SupportRepId");


--
-- Name: IFK_EmployeeReportsTo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_EmployeeReportsTo" ON public."Employee" USING btree ("ReportsTo");


--
-- Name: IFK_InvoiceCustomerId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_InvoiceCustomerId" ON public."Invoice" USING btree ("CustomerId");


--
-- Name: IFK_InvoiceLineInvoiceId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_InvoiceLineInvoiceId" ON public."InvoiceLine" USING btree ("InvoiceId");


--
-- Name: IFK_InvoiceLineTrackId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_InvoiceLineTrackId" ON public."InvoiceLine" USING btree ("TrackId");


--
-- Name: IFK_PlaylistTrackTrackId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_PlaylistTrackTrackId" ON public."PlaylistTrack" USING btree ("TrackId");


--
-- Name: IFK_TrackAlbumId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_TrackAlbumId" ON public."Track" USING btree ("AlbumId");


--
-- Name: IFK_TrackGenreId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_TrackGenreId" ON public."Track" USING btree ("GenreId");


--
-- Name: IFK_TrackMediaTypeId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IFK_TrackMediaTypeId" ON public."Track" USING btree ("MediaTypeId");


--
-- Name: Album FK_AlbumArtistId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Album"
    ADD CONSTRAINT "FK_AlbumArtistId" FOREIGN KEY ("ArtistId") REFERENCES public."Artist"("ArtistId");


--
-- Name: Customer FK_CustomerSupportRepId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "FK_CustomerSupportRepId" FOREIGN KEY ("SupportRepId") REFERENCES public."Employee"("EmployeeId");


--
-- Name: Employee FK_EmployeeReportsTo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "FK_EmployeeReportsTo" FOREIGN KEY ("ReportsTo") REFERENCES public."Employee"("EmployeeId");


--
-- Name: Invoice FK_InvoiceCustomerId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invoice"
    ADD CONSTRAINT "FK_InvoiceCustomerId" FOREIGN KEY ("CustomerId") REFERENCES public."Customer"("CustomerId");


--
-- Name: InvoiceLine FK_InvoiceLineInvoiceId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InvoiceLine"
    ADD CONSTRAINT "FK_InvoiceLineInvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES public."Invoice"("InvoiceId");


--
-- Name: InvoiceLine FK_InvoiceLineTrackId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InvoiceLine"
    ADD CONSTRAINT "FK_InvoiceLineTrackId" FOREIGN KEY ("TrackId") REFERENCES public."Track"("TrackId");


--
-- Name: PlaylistTrack FK_PlaylistTrackPlaylistId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PlaylistTrack"
    ADD CONSTRAINT "FK_PlaylistTrackPlaylistId" FOREIGN KEY ("PlaylistId") REFERENCES public."Playlist"("PlaylistId");


--
-- Name: PlaylistTrack FK_PlaylistTrackTrackId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PlaylistTrack"
    ADD CONSTRAINT "FK_PlaylistTrackTrackId" FOREIGN KEY ("TrackId") REFERENCES public."Track"("TrackId");


--
-- Name: Track FK_TrackAlbumId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Track"
    ADD CONSTRAINT "FK_TrackAlbumId" FOREIGN KEY ("AlbumId") REFERENCES public."Album"("AlbumId");


--
-- Name: Track FK_TrackGenreId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Track"
    ADD CONSTRAINT "FK_TrackGenreId" FOREIGN KEY ("GenreId") REFERENCES public."Genre"("GenreId");


--
-- Name: Track FK_TrackMediaTypeId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Track"
    ADD CONSTRAINT "FK_TrackMediaTypeId" FOREIGN KEY ("MediaTypeId") REFERENCES public."MediaType"("MediaTypeId");


--
-- PostgreSQL database dump complete
--

