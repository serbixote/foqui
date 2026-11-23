/// Search keywords for the label icon picker.
///
/// Adapted from emoji_picker_flutter 4.5.4
/// https://github.com/Fintasys/emoji_picker_flutter
///
/// MIT License
///
/// Copyright (c) 2024 Stefan Humm
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
library;

/// One line per emoji: the character, then `|`, then `|`-separated keywords.
const labelEmojiCatalog = <String, String>{
  'de': r'''
😀|froh|fröhlich|Gesicht|grinsen|haha|lachen|lol|lustig|Smiley
😃|Augen|fröhlich|Gesicht|glücklich|grinsen|große|lächeln|lachen|lol|lustig|Mund|offen|Smiley
😄|Augen|fröhlich|geschlossen|Gesicht|glücklich|grinsen|lächeln|lachen|lol|lustig|Mund|offen|Smiley|witzig
😁|Augen|fröhlich|Gesicht|grinsen|happy|lächeln|lachen|lustig|Smiley|strahlen|Zähne
😆|Augen|geschlossen|Gesicht|Grinsegesicht|grinsen|haha|hehe|hihi|lachen|lol|lustig|Mund|offen|Smiley|witzig|zugekniffen|zusammengekniffen
😅|Gesicht|grinsen|lächeln|lachen|lustig|Mund|nervös|offen|Schweiß|Schweißtropfen|schwitzen|Smiley
🤣|Boden|Gesicht|haha|hehe|lachen|lol|lustig|muahaha|rofl|Smiley|Tränen|wälzen|witzig
😂|Freude|Freudentränen|fröhlich|Gesicht|haha|happy|hehe|hihi|lachen|lol|lustig|muahaha|rofl|Smiley|Tränen|witzig
🙂|Gesicht|lächeln|leicht|Smiley
🙃|auf dem Kopf|Gesicht|lächeln|Smiley|stehen|umgekehrt
😉|Auge|flirten|Gesicht|sexy|Smiley|zudrücken|zugedrückt|zukneifen|zuzwinkern|Zwinkern
😊|Augen|erröten|Freude|freundlich|Gesicht|glücklich|lächeln|lachen|rot|Wangen
😇|brav|Engel|Gesicht|glücklich|Heiligenschein|Lächeln|lieb|seelig|Smiley
🥰|3|anhimmeln|bewundern|Gesicht|HDGDL|HDL|Herzchen|Herzen|lächeln|lieb|Liebe|Smiley|verknallt|verliebt|verzückt
😍|Augen|Gesicht|glücklich|Herzen|herzförmig|lächeln|Liebe|Smiley|verliebt
🤩|aufgeregt|Augen|Gesicht|grinsen|Smiley|Star|Stern|überwältigt|wow
😘|flirten|Gesicht|Kuss|Küsschen|küssen|lieb|Smiley|zuwerfen
😗|flirten|Gesicht|HDL|Knutsch|Kuss|küssen|Smiley|xoxo
☺️|fröhlich|Gesicht|lächeln|rot|Smiley|Wangen
😚|geschlossen|Gesicht|Knutsch|Kuss|Küsschen|küssen|rot|Smiley|ugen|Wangen
😙|Augen|flirten|Gesicht|knutsch|Kuss|küssen|lächeln|Smiley
😋|Gesicht|lächeln|lecker|leckeres Essen|Sich die Lippen leckender Smiley|sich die Lippen leckendes Gesicht|Smiley|Zunge
😛|ätsch|bäh|Gesicht|herausgestreckt|lachen|lustig|Smiley|Zunge
😜|Auge|Gesicht|herausgestreckt|herausstrecken|Smiley|zudrücken|zugedrückt|Zunge|Zwinkern
🤪|Auge|Augen|Gesicht|groß|irre|klein|Smiley|verrückt
😝|Auge|Augen|bäh|ekel|Gesicht|herausgestreckt|herausstrecken|igitt|schmeck|schrecklich|Smiley|Zunge|zusammengekniffen|zusammenkneifen
🤑|Dollar|Dollarzeichen|Geld|Gesicht|Mund|Smiley|Zunge
🤗|drücken|Gesicht|Hände|Smiley|umarmen|Umarmung
🫣|Auge|Finger|gebannt|Gesicht|hervorlugen|linsen|schüchtern|Smiley|spähen|starren|verlegen
🤭|Gesicht|haha|Hand|hihi|Huch|kichern|lachen|Mund|rot|Smiley|verlegen|Wangen
🫢|Augen|Erschrecken|Erstaunen|Furcht|geschockt|Gesicht|Hand|Mund|offen|OMG|Schock|Smiley|Überraschung|Unglauben|Verlegenheit
🫡|Aye|Gesicht|jawohl|jawoll|Militär|ok|Respekt|salutieren|Smiley|zu Befehl
🤫|ermahnen|Finger|Gesicht|leise|psst|pst|Ruhe|ruhig|sch|Smiley
🫠|auflösen|beschämt|flüssig|Gesicht|Hitze|Sarkasmus|sarkastisch|schmelzen|schwitzen|Smiley|verschwinden
🤔|fragen|Gesicht|grübeln|hm|komisch|nachdenken|nachdenklich|Smiley|wundern
🤐|Geheimnis|Gesicht|halten|Mund|Reißverschluss|schweigen|Smiley|wahren
🤨|argwöhnisch|Augenbrauen|Gesicht|hochgezogen|misstrauen|skeptisch|Smiley|stutzig|Zweifel
😐|ausdruckslos|Gesicht|kommentarlos|neutral|Smiley|todernst|unbeeindruckt
🫤|enttäuscht|genervt|Gesicht|hmpf|keine Ahnung|langweilig|skeptisch|Smiley|unsicher|zweifelnd
😑|ausdruckslos|Gesicht|kommentarlos|selbstgefällig|Smiley|unbeeindruckt|unglaublich
😶|Gesicht|kein|Mund|ohne|Smiley|sprachlos
🫥|depressiv|deprimiert|egal|Gesicht|gestrichelt|introvertiert|Smiley|traurig|unsichtbar|verschwinden|verstecken
😏|feixen|flirten|Gesicht|lächeln|Mundwinkel|schief|Smiley|süffisant
😒|Gesicht|langweilig|Smiley|traurig|unglücklich|unzufrieden|verstimmt
🙄|Augen|genervt|Gesicht|meinetwegen|nerv|ohje|rollen|Smiley|verdrehen|verrollen
😬|Gesicht|Grimasse|peinlich|schneiden|Smiley|verziehen|Zähne
🤥|Gesicht|Lüge|Nase|Pinocchio|Schwindel
😌|Augen|entspannt|erleichtert|geschlossen|Gesicht|Smiley|Zen|zufrieden
😔|enttäuscht|Gesicht|nachdenklich|schrecklich|Smiley|traurig|verlieren|verloren
🥹|aufgebracht|dankbar|Freude|Freudentränen|gerührt|Gesicht|Rührung|Smiley|stolz|Tränen|weinen|zurückhalten
😪|Gesicht|gute|müde|Nacht|schläfrig|Smiley|traurig
🤤|Gesicht|sabbern|Smiley
😴|dösen|einschlafen|gähnen|Gesicht|gute Nacht|langweilig|Mittagsschlaf|müde|Nickerchen|Schlaf|schlafen|Smiley|zzz
😷|Arzt|Atemschutzmaske|Bazillen|erkältet|Gesicht|krank|Krankheit|Mund|Mundschutz|Schutzmaske|Smiley|Viren|Virus
🤒|Fieber|Gesicht|krank|messen|Smiley|Thermometer
🤕|aua|autsch|Gesicht|Kopf|Schmerzen|Smiley|Verband|Verletzung
🤢|ekel|eklig|erbrechen|Gesicht|grün|igitt|Smiley|Übelkeit|übergeben|widerlich|würgen
🤮|brechen|erbrechen|Gesicht|kotzen|krank|schlecht|Smiley|speien|spucken|übel|übergeben
🤧|erkältet|Erkältung|Gesicht|Gesundheit|Grippe|hatschi|krank|Nase|niesen|putzen|Smiley|Taschentuch
🥵|erhitzt|Fieber|fiebrig|Gesicht|heiß|herausstrecken|Hitze|Hitzschlag|rot|schnaufen|schwitzen|Smiley|Zunge
🥶|bibbern|blau|eisig|erfrieren|frieren|frösteln|frostig|Gesicht|kalt|Smiley|unter Null|Zähne|Zähneklappern|zittern
🥴|angeheitert|angeschwipst|angetrunken|benebelt|berauscht|beschwipst|betrunken|gewellt|Mund|schwindelig|schwindlig|Smiley
😵|Augen|benommen|Gesicht|ko|krank|Kreuze|schwindelig|schwindlig|Smiley
😵‍💫|Augen|Gesicht|Höhenangst|Hypnose|hypnotisiert|omg|schwindelig|schwindlig|Smiley|Spiralen|verwirrt|wirr
🤯|entsetzt|explodieren|geschockt|Gesicht|Kopf|Schock|schockiert|Smiley|überwältigt|unglaublich
🤠|Cowboy|Cowboyhut|Cowgirl|Gesicht|Hut|Smiley
🥳|aufgeregt|Feier|Fest|fröhlich|Geburtstag|Gesicht|Glückwunsch|Hurra|Hut|Party|Smiley|Überraschung
😎|cool|Gesicht|lächeln|Smiley|Sonnenbrille
🤓|Brille|Gesicht|intelligent|klug|Nerd|schlau|Schlaumeier|smart|Smiley|Streber|Strebergesicht
🧐|elegant|Gesicht|Monokel|reich|Smiley
😕|Gesicht|keine Ahnung|Smiley|traurig|verwirrt|verwundert|weiß nicht
😟|besorgt|Gesicht|Smiley|sorgen|traurig
🙁|betrübt|Gesicht|schade|Smiley|traurig
☹️|deprimiert|düster|Gesicht|Smiley|stirnrunzelnd|traurig
😮|erstaunt|Gesicht|Mund|offen|omg|schockiert|unglaublich|vergessen|wow
😯|erstaunt|Gesicht|omg|Smiley|sprachlos|verdutzt
😲|erstaunt|Gesicht|nee|omg|schockiert|Smiley|verwundert
😳|Augen|erröten|Gesicht|groß|peinlich|rot|Scham|schämen|Smiley|überrascht|verlegen|Wangen
🥺|anflehen|Augen|betteln|bettelnd|bitte|bitten|flehend|Gesicht|groß|Kulleraugen|Smiley|traurig|Welpenaugen
😦|entsetzt|Gesicht|Mund|offen|schockiert|Smiley|verwundert
😧|arm|Gesicht|leidend|qualvoll|Smiley|vergessen|wow
😨|Angst|ängstlich|besorgt|Gesicht
😰|Angst|ängstlich|Angstschweiß|besorgt|Gesicht|Mund|nervös|offen|Schweiß
😥|ängstlich|enttäuscht|erleichtert|Gesicht|knapp|Schweiß|traurig
😢|Gesicht|Smiley|Träne|traurig|weinen
😭|flennen|Gesicht|heulen|schluchzen|Smiley|Tränen|Tränenfluss|traurig|weinen
😱|Angst|ängstlich|Gesicht|Munch|omg|Panik|Schrei|schreien|schreiend
😖|bestürzt|frustriert|Gesicht|konfus|Smiley|verwirrt|verzweifelt
😣|ausdauernd|durchhalten|Fokus|Gesicht|Konzentration|konzentrieren|Kopfschmerzen
😞|enttäuscht|Gesicht|leider|schade|Smiley|traurig|verloren
😓|Angstschweiß|Augen|bedrückt|geschlossen|Gesicht|Kopfschmerzen|Schweiß|Smiley
😩|erschöpft|Fehlschlag|Gesicht|hungrig|müde|nein|Smiley|unglücklich
😫|Gesicht|müde|niesen|Smiley|traurig
😤|erleichtert|Gesicht|gewonnen|schnaubendes Gesicht
😡|Gesicht|rot|Rot angelaufener Smiley|schmollendes Gesicht|wütend
😠|ärgern|böse|Gesicht|Smiley|verärgert|Wut|wütend|zornig
🤬|Ärger|ärgern|fluchen|Gesicht|Mund|schimpfen|Schimpfwort|Smiley|Symbole|verdammt|Wut|wütend|Zensur
😈|böse|Dämon|Dämonin|Fantasie|grinsen|Hörner|lila|Märchen|Satan|Smiley|Teufel|violett
👿|böse|Dämon|Dämonin|Fantasie|Fantasy|Gesicht|Hörner|Kobold|lila|Märchen|Satan|Teufel|Teufelchen|violett|wütend
💀|Gesicht|Knochen|Märchen|Schädel|Tod|tot|Totenkopf|yolo
☠️|gekreuzt|Gesicht|Knochen|Piratenflagge|Schädel|Tod|tot|Totenkopf
💩|Kot|Kothaufen|Mist
🤡|Clown|Clown-Gesicht|Gesicht
👹|Gesicht|gruselig|Japan|japanisch|Märchen|Maske|Monster|Oger|Ungeheuer
👺|gemein|Gesicht|Japan|japanisch|Kobold|Märchen|Maske|Monster|Tengu|Ungeheuer|wütend
👻|buh|Fantasy|Geist|Gesicht|Gespenst|gruselig|Halloween|Märchen|Spuk|Zunge
👽|Alien|All|außerirdisch|Außerirdische|Außerirdischer|Fantasy|Gesicht|Märchen|Monster|UFO|Weltraum|Wesen
👾|Computerspiel-Monster|Gesicht|Monster|UFO
🤖|Gesicht|Monster|Roboter|Robotergesicht|Roboterkopf
🎃|Halloween|Halloweenkürbis|Herbst|Kürbis|Kürbislaterne
😺|Gesicht|grinsen|Katze|Katzengesicht|lachen|lol|lustig|Mund|offen|Smiley|Tier
😸|Augen|Gesicht|grinsen|Katze|Katzengesicht|lachen|Smiley|Tier
😹|Freude|Freudentränen|Gesicht|Katze|Katzengesicht|lachen|Smiley|Tier|Tränen
😻|Augen|Gesicht|Herzaugen|Herzen|Katze|Katzengesicht|lächeln|lachen|Liebe|Smiley|Tier|verliebt
😼|Gesicht|grinsen|ironisch|Katze|Katzengesicht|lächeln|lachen|Smiley|Tier|verwegen
😽|Augen|geschlossen|Gesicht|Katze|Katzengesicht|Kuss|Küsschen|Küsse|küssen|rot|Smiley|Tier|Wangen
🙀|Angst|erschöpft|Gesicht|Katze|Katzengesicht|Panik|Schock|schockiert|Schrei|schreien|Smiley|Tier|überrascht
😿|Gesicht|Katze|Katzengesicht|Smiley|Tier|Träne|traurig|weinen
😾|Gesicht|Katze|Katzengesicht|schmollen|Schmollmund|Smiley|Tier|verärgert
🫶|<3|Finger|Geste|Hände|Händeherz|Handgeste|Handherz|hdl|Herz|Liebe
👋|auf Wiedersehen|bis später|ciao|guten Tag|hallo|Hand|hey|hi|tschüs|tschüss|winken
🤚|erhoben|erhobene Hand von hinten|erhobener Handrücken|Hand
🖐️|5|Finger|fünf|gespreizt|Hand|Hand mit gespreizten Fingern
✋|5|erhoben|halt|Hand|Handfläche|high five|schlag ein|Stopp|warte
🖖|Finger|Gruß|grüßen|Hand|Hände|spreizen
👌|exzellent|Finger|genial|Hand|in Ordnung|natürlich|OK|OK-Zeichen|perfekt|super
🤌|Bündelhand|Finger|Fingerspitzen|gehts noch|Geste|Hand|Handgeste|italienisch|was|zusammengedrückt|zusammengelegt
🤏|Betrag|Finger|gering|Geste|Hand|klein|Menge|unbedeutend|wenig|Wenig-Geste|winzig
🫳|abweisen|fallen lassen|fallenlassen|Hand|Handfläche|Handgeste|hau ab|unten|verscheuchen|wegscheuchen|wegschicken
🫴|anbieten|Angebot|darbieten|einladen|entgegenstrecken|Hand|Handfläche|Handgeste|kommen|locken|oben|reichen
✌️|Sieg|V|Victory|Victory-Geste
🫰|Daumen|Finger|Fingerherz|gekreuzt|Geld|Hand|Handgeste|Kosten|teuer|Zeigefinger
🤞|Finger|gekreuzt|Hand|Hand mit gekreuzten Fingern
🤟|drei|Finger|Geste|Hand|hdl|Ich-liebe-dich-Geste|Liebe
🤘|corna|Finger|Hand|Heavy|Hörner|Mano cornuta|Metal|Metalhand|Pommesgabel|Rock|Teufel|Teufelsgruß|yeah
🤙|Anruf|anrufen|Hand|ruf|Ruf-mich-an-Handzeichen|Shaka
👈|Finger|Handrückseite|links|weisen|Zeigefinger|zeigen
👉|Finger|Handrückseite|rechts|weisen|Zeigefinger|zeigen
👆|aufwärts|Finger|Handrücken|Handrückseite|hier|hinauf|melden|oben|rauf|weisen|Zeigefinger|zeigen
🖕|Finger|Hand|Mittelfinger
👇|abwärts|Finger|Handrücken|Handrückseite|hinab|hinunter|runter|unten|weisen|Zeigefinger|zeigen
☝️|Finger|Hand|Handvorderseite|hier|melden|oben|weisen|Zeigefinger|zeigen
👍|Daumen|Daumen hoch|einverstanden|Finger|gut|Hand|in Ordnung|jawohl|klar|klasse|like|nach oben|ok|super|top
👎|Daumen|Daumen runter|Hand|nach unten|schlecht
✊|erhoben|Faust|Hand|Kampf|Solidarität
👊|absolut|Bro|Faust|geballt|Hand|korrekt|zustimmen
🤛|Faust|Hand|nach links
🤜|Faust|Hand|nach rechts
🫲|ausgestreckt|ausstrecken|Hand|Hände|Händeschütteln|links|reichen|schütteln|weisen
🫱|ausgestreckt|ausstrecken|Hand|Hände|Händeschütteln|rechts|reichen|schütteln|weisen
👏|applaudieren|Applaus|Beifall|Gratulation|großartig|gut|Hand|Hände|Klatschen|klatschend|toll
🙌|erhoben|feiern|Geste|Hände|Handflächen|hurra|zwei
👐|Hände|Jazz|offen|umarmen|Umarmung
🤲|beten|Gebet|Hand|Hände|nach oben|zusammen
🤝|Hände|Händeschütteln|Handschlag|Vereinbarung
🙏|beten|betend|bitten|danke|danken|Gebet|gefaltet|grüßen|Handflächen|zusammengelegt
🫵|deuten|du|Finger|Fingerzeig|Hand|Handgeste|Sie|stupsen|Zeigefinger|zeigen
✍️|Hand|schreiben|schreibend|Stift
💅|Kosmetik|Maniküre|Nagel|Nagellack|Nagelpflege
🤳|Selfie|Smartphone
💪|Arm|Bizeps|Bodybuilder|Bro|Fitnessstudio|Gewichtheben|Muckies|Muskeln|stark|Training
🦵|Bein|Extremität|Fuß|gebeugtes Knie|Gliedmaße|Knie|Körperglied|Körperteil|Treten|Tritt
🦶|Fuß|Füße|Kick|Knöchel|Körperteil|stampfen|treten|Tritt
👂|hören|Körperteil|Ohr
👃|Körperteil|Nase|riechen
🧠|Gehirn|Hirn|intelligent|Intelligenz|klug|schlau
🦴|Hund|Hundeknochen|Kauknochen|Knochen|Skelett
👀|Auge|Augen|Gesicht|gucken|schauen|sehen
👁️|Auge|Blick|Körper|Körperteil|schauen|sehen
💋|Gefühl|Knutsch|Kuss|Kussabdruck|küssen|Liebe|Lippen|Lippenstift|romantisch|sexy
👄|Körperteil|Kuss|Lippen|Lippenstift|Mund
🫦|Angst|ängstlich|beißen|besorgt|flirten|flirtend|Kuss|Lippenstift|Mund|nervös|sexy|unbehaglich|Zähne
🦷|perlweiß|weiß|Zahn|Zahnarzt|Zahnärztin|Zähne
👅|ätsch|hmm|Körperteil|lecken|lecker|mmh|Zunge
👶|Baby|Gesicht|jung|Kind|Kleinkind|Locke
🧒|Enkelkind|jung|jünger|Kind|munter|strahlend
👦|Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👧|Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
🧑|erwachsen|erwachsene Person|Mensch|Person
👨|erwachsen|Gesicht|Mann
🧔|Bart|bärtig|Person|Schnurrbart
👱|blond|blondhaarig|Gesicht|Mensch|Person
👨‍🦰|erwachsen|Gesicht|Mann rote Haare|rotes Haar|rothaarig|Rotschopf
👨‍🦱|erwachsen|Gesicht|Mann Afro|Lockenkopf|lockig|lockiges Haar
👨‍🦳|erwachsen|Gesicht|Mann grau|graues Haar|grauhaarig|weißes Haar|weißhaarig
👨‍🦲|erwachsen|Gesicht|Mann Chemo|Glatze|haarlos|kein Haar|rasiert
👩|erwachsen|Frau|Gesicht
👱‍♀️|blond|blondhaarig|Gesicht|Mensch|Person Frau|Frauensymbol|weiblich|Zeichen
👩‍🦰|erwachsen|Frau|Gesicht rote Haare|rotes Haar|rothaarig|Rotschopf
👩‍🦱|erwachsen|Frau|Gesicht Afro|Lockenkopf|lockig|lockiges Haar
👩‍🦳|erwachsen|Frau|Gesicht grau|graues Haar|grauhaarig|weißes Haar|weißhaarig
👩‍🦲|erwachsen|Frau|Gesicht Chemo|Glatze|haarlos|kein Haar|rasiert
🧓|alt|älter|erwachsen|Großeltern|Mensch|Person|weise
👴|alt|älter|erwachsen|Großeltern|Großvater|Mann|Mensch|Opa|Senior|weise
👵|alt|älter|erwachsen|Frau|Großeltern|Großmutter|Mensch|Oma|Seniorin|weise
🙍‍♂️|frustriert|Gesicht|missmutig|Person|runzeln|stirnrunzelnd|unzufrieden|verärgert Mann|Männersymbol|Symbol|Zeichen
🙍‍♀️|frustriert|Gesicht|missmutig|Person|runzeln|stirnrunzelnd|unzufrieden|verärgert Frau|Frauensymbol|weiblich|Zeichen
🙎‍♂️|eingeschnappt|enttäuscht|jammerd|jammern|Person|schmollen|schmollend|verärgert Mann|Männersymbol|Symbol|Zeichen
🙎‍♀️|eingeschnappt|enttäuscht|jammerd|jammern|Person|schmollen|schmollend|verärgert Frau|Frauensymbol|weiblich|Zeichen
🙅‍♂️|Arme|Gesicht|NEIN|nicht|Person|überkreuzt|verbieten|verboten Mann|Männersymbol|Symbol|Zeichen
🙅‍♀️|Arme|Gesicht|NEIN|nicht|Person|überkreuzt|verbieten|verboten Frau|Frauensymbol|weiblich|Zeichen
🙆‍♂️|Geste|Hände|oje|OK|omg|Person|über Kopf|Übung Mann|Männersymbol|Symbol|Zeichen
🙆‍♀️|Geste|Hände|oje|OK|omg|Person|über Kopf|Übung Frau|Frauensymbol|weiblich|Zeichen
💁‍♂️|abgekippt|beleidigen|Gerüchte|Geste|Hand|Klatsch|klatschen|Person|Sarkasmus|sarkastisch|Tratsch|tratschen Mann|Männersymbol|Symbol|Zeichen
💁‍♀️|abgekippt|beleidigen|Gerüchte|Geste|Hand|Klatsch|klatschen|Person|Sarkasmus|sarkastisch|Tratsch|tratschen Frau|Frauensymbol|weiblich|Zeichen
🙋‍♂️|aufzeigen|drankommen|drannehmen|Frage|Geste|Hand|heben|hier|ich|Person|sich melden|wissen Mann|Männersymbol|Symbol|Zeichen
🙋‍♀️|aufzeigen|drankommen|drannehmen|Frage|Geste|Hand|heben|hier|ich|Person|sich melden|wissen Frau|Frauensymbol|weiblich|Zeichen
🙇‍♂️|Bedauern|bitten|Demut|Entschuldigung|Geste|Kniefall|Meditation|meditieren|Person|sorry|unterwerfen|verbeugen|Verzeihung Mann|Männersymbol|Symbol|Zeichen
🙇‍♀️|Bedauern|bitten|Demut|Entschuldigung|Geste|Kniefall|Meditation|meditieren|Person|sorry|unterwerfen|verbeugen|Verzeihung Frau|Frauensymbol|weiblich|Zeichen
🤦‍♂️|fassen|frustriert|genervt|Gesicht|Kopf|oh nein|OMG|Person|unfassbar|unglaublich|verzweifelt Mann|Männersymbol|Symbol|Zeichen
🤦‍♀️|fassen|frustriert|genervt|Gesicht|Kopf|oh nein|OMG|Person|unfassbar|unglaublich|verzweifelt Frau|Frauensymbol|weiblich|Zeichen
🤷‍♂️|egal|gleichgültig|keine Ahnung|Person|Schultern zucken|schulterzuckend|weiß nicht|Zweifel Mann|Männersymbol|Symbol|Zeichen
🤷‍♀️|egal|gleichgültig|keine Ahnung|Person|Schultern zucken|schulterzuckend|weiß nicht|Zweifel Frau|Frauensymbol|weiblich|Zeichen
👨‍⚕️|erwachsen|Gesicht|Mann Apotheke|Arznei|Asklepiosstab|Äskulapstab|Medizin
👩‍⚕️|erwachsen|Frau|Gesicht Apotheke|Arznei|Asklepiosstab|Äskulapstab|Medizin
👨‍🎓|Absolvent|Diplom|Doktorhut|Student|Uni
👩‍🎓|Abschluss|Absolventin|Diplom|Doktorhut|Studentin|Uni
👨‍🏫|Dozent|Lehrer|Mann|Professor|Tafel
👩‍🏫|Dozentin|Frau|Lehrerin|Professorin
👨‍⚖️|erwachsen|Gesicht|Mann Gerechtigkeit|Gewicht|Waage|Werkzeug|wiegen
👩‍⚖️|erwachsen|Frau|Gesicht Gerechtigkeit|Gewicht|Waage|Werkzeug|wiegen
👨‍🌾|Ähre|Bauer|Farmer|Gärtner|Landwirt|Rancher
👩‍🌾|Ähre|Bäuerin|Farmerin|Gärtnerin|Landwirtin
👨‍🍳|Koch|Kochen|Restaurant
👩‍🍳|kochen|Köchin
👨‍🔧|Elektriker|Handwerker|Klempner|Mann|Mechaniker
👩‍🔧|Elektrikerin|Frau|Handwerkerin|Klempnerin|Mechanikerin
👨‍🏭|Fabrik|Fabrikarbeiter|Helm
👩‍🏭|Fabrik|Fabrikarbeiterin|Frau|Helm
👨‍💼|Angestellter|Büro|Büroangestellter|Manager|Mann
👩‍💼|Angestellte|Büro|Büroangestellte|Frau|Managerin|Mangerin
👨‍🔬|Chemie|Forscher|Labor|Wissenschaftler
👩‍🔬|Forscherin|Frau|Labor|Wissenschaftlerin
👨‍💻|Arbeit|Bildschirm|Büro|Computer|Entwickler|IT-Experte|Mann|Office
👩‍💻|Arbeit|Bildschirm|Büro|Computer|Entwickler|Entwicklerin|Frau|IT-Expertin|Laptop|Office
👨‍🎤|Mann|Mikrofon|Popstar|Sänger|Schauspieler
👩‍🎤|Frau|Mikrofon|Popstar|Sängerin|Schauspielerin
👨‍🎨|Farbpalette|Künstler|Maler|Mann
👩‍🎨|Farbpalette|Frau|Künstlerin|Malerin
👨‍✈️|erwachsen|Gesicht|Mann Flieger|Flugzeug
👩‍✈️|erwachsen|Frau|Gesicht Flieger|Flugzeug
👨‍🚀|Astronaut|Mann|Raumfahrt|Weltraum
👩‍🚀|Astronautin|Frau|Raumfahrt|Weltraum
👨‍🚒|Feuerwehr|Feuerwehrhelm|Feuerwehrmann|Mann
👩‍🚒|Feuerwehrfrau|Feuerwehrhelm|Frau
👮‍♂️|Beruf|festnehmen|Gesetzeshüter|Gesicht|Person|Polizei|Polizist|Polizist(in)|Polizistin|Uniform|verhaften Mann|Männersymbol|Symbol|Zeichen
👮‍♀️|Beruf|festnehmen|Gesetzeshüter|Gesicht|Person|Polizei|Polizist|Polizist(in)|Polizistin|Uniform|verhaften Frau|Frauensymbol|weiblich|Zeichen
🕵️‍♂️|Detektiv|Detektiv(in)|Lupe|Sherlock|Spion Mann|Männersymbol|Symbol|Zeichen
🕵️‍♀️|Detektiv|Detektiv(in)|Lupe|Sherlock|Spion Frau|Frauensymbol|weiblich|Zeichen
💂‍♂️|Bärenfellmütze|Buckingham Palace|Gesicht|London|Wache|Wachfrau|Wachmann|Wachsoldat|Wachsoldatin|Wächter Mann|Männersymbol|Symbol|Zeichen
💂‍♀️|Bärenfellmütze|Buckingham Palace|Gesicht|London|Wache|Wachfrau|Wachmann|Wachsoldat|Wachsoldatin|Wächter Frau|Frauensymbol|weiblich|Zeichen
👷‍♂️|Arbeit|Bau|Bauarbeiter|Bauarbeiter(in)|Bauarbeiterin|Beruf|Gesicht|Helm|Person|Schutzhelm|umbauen Mann|Männersymbol|Symbol|Zeichen
👷‍♀️|Arbeit|Bau|Bauarbeiter|Bauarbeiter(in)|Bauarbeiterin|Beruf|Gesicht|Helm|Person|Schutzhelm|umbauen Frau|Frauensymbol|weiblich|Zeichen
🤴|Krone|Prinz
👸|Gesicht|Krone|Märchen|Prinzessin
👳‍♂️|Bart|Dreitagebart|Person|Person mit Turban|Turban Mann|Männersymbol|Symbol|Zeichen
👳‍♀️|Bart|Dreitagebart|Person|Person mit Turban|Turban Frau|Frauensymbol|weiblich|Zeichen
👲|China|chinesisch|Gesicht|Hut|Kappe|Mütze|Person
🧕|Frau|Frau mit Kopftuch|Hidschab|Hijab|Kopftuch|Mantilla|Person|Tichel|Tuch
🤵|Anzug|Bräutigam|formell|Mann|Person|Person im Smoking|Smoking|vornehm
👰|Braut|Braut mit Schleier|Gesicht|Hochzeit|Person|Person mit Schleier|Schleier
🤰|Frau|schwanger|schwangere Frau
🤱|Baby|Brust|Frau|Person|stillen|Stillen
👼|Engel|Gesicht|Kind|Märchen|Putte
🎅|Weihnachten|Weihnachtsmann
🤶|Weihnachten|Weihnachtsfrau
🦸‍♂️|Held|Person|Superheld|Superheld(in)|Superheldin|Superkraft|Superkräfte|Superman|Übermensch|Umhang Mann|Männersymbol|Symbol|Zeichen
🦸‍♀️|Held|Person|Superheld|Superheld(in)|Superheldin|Superkraft|Superkräfte|Superman|Übermensch|Umhang Frau|Frauensymbol|weiblich|Zeichen
🦹‍♂️|böse|Bösewicht|Bösewichtin|Krimineller|Person|Schurke|Schurkin|Superkräfte|Superschurke|Superschurkin|Verbrecher Mann|Männersymbol|Symbol|Zeichen
🦹‍♀️|böse|Bösewicht|Bösewichtin|Krimineller|Person|Schurke|Schurkin|Superkräfte|Superschurke|Superschurkin|Verbrecher Frau|Frauensymbol|weiblich|Zeichen
🧙‍♂️|Hexe|Hexenmeister|Magier|Magier(in)|Magiker|Person|Zauberer|Zauberin|zaubern|Zauberspruch|Zauberstab Mann|Männersymbol|Symbol|Zeichen
🧙‍♀️|Hexe|Hexenmeister|Magier|Magier(in)|Magiker|Person|Zauberer|Zauberin|zaubern|Zauberspruch|Zauberstab Frau|Frauensymbol|weiblich|Zeichen
🧚‍♂️|Elf|Elfe|Fantasy|Fee|Flügel|geflügelt|Märchen|Märchenfee|mystisch|Person|Wesen Mann|Männersymbol|Symbol|Zeichen
🧚‍♀️|Elf|Elfe|Fantasy|Fee|Flügel|geflügelt|Märchen|Märchenfee|mystisch|Person|Wesen Frau|Frauensymbol|weiblich|Zeichen
🧛‍♂️|Blutsauger|Dracula|Halloween|Person|Reißzähne|untot|Untoter|Vampir|Zähne Mann|Männersymbol|Symbol|Zeichen
🧛‍♀️|Blutsauger|Dracula|Halloween|Person|Reißzähne|untot|Untoter|Vampir|Zähne Frau|Frauensymbol|weiblich|Zeichen
🧜‍♂️|Märchen|Meerjungfrau|Meermann|Nixe|Person|Sirene|Wasserfrau|Wassermann|Wassermensch Mann|Männersymbol|Symbol|Zeichen
🧜‍♀️|Märchen|Meerjungfrau|Meermann|Nixe|Person|Sirene|Wasserfrau|Wassermann|Wassermensch Frau|Frauensymbol|weiblich|Zeichen
🧝‍♂️|Elbe|Elben|Elbin|Elf|Elf(e)|Elfe|Fantasy|Herr der Ringe|Magie|magisch|Person Mann|Männersymbol|Symbol|Zeichen
🧝‍♀️|Elbe|Elben|Elbin|Elf|Elf(e)|Elfe|Fantasy|Herr der Ringe|Magie|magisch|Person Frau|Frauensymbol|weiblich|Zeichen
🧞‍♂️|Aladdin|Aladin|Dschinn|Flaschengeist|Lampe|Person|Wunderlampe|Wünsche Mann|Männersymbol|Symbol|Zeichen
🧞‍♀️|Aladdin|Aladin|Dschinn|Flaschengeist|Lampe|Person|Wunderlampe|Wünsche Frau|Frauensymbol|weiblich|Zeichen
🧟‍♂️|Apokalypse|Halloween|Horror|Person|untot|Untoter|Walking Dead|wandelnder Toter|Zombie Mann|Männersymbol|Symbol|Zeichen
🧟‍♀️|Apokalypse|Halloween|Horror|Person|untot|Untoter|Walking Dead|wandelnder Toter|Zombie Frau|Frauensymbol|weiblich|Zeichen
💆‍♂️|Behandlung|die eine Kopfmassage bekommt|entspannen|Kopfmassage|Kopfschmerzen|Massage|Migräne|Person|Person, die eine Kopfmassage bekommt|Salon|Spa|Therapie Mann|Männersymbol|Symbol|Zeichen
💆‍♀️|Behandlung|die eine Kopfmassage bekommt|entspannen|Kopfmassage|Kopfschmerzen|Massage|Migräne|Person|Person, die eine Kopfmassage bekommt|Salon|Spa|Therapie Frau|Frauensymbol|weiblich|Zeichen
💇‍♂️|Friseur|Friseurin|Friseuse|Frisör|Frisörin|Frisur|Haare|Haarschnitt|Person|Person beim Haareschneiden|Schere Mann|Männersymbol|Symbol|Zeichen
💇‍♀️|Friseur|Friseurin|Friseuse|Frisör|Frisörin|Frisur|Haare|Haarschnitt|Person|Person beim Haareschneiden|Schere Frau|Frauensymbol|weiblich|Zeichen
🚶‍♂️|Fußgänger|Fußgänger(in)|Fußgängerin|gehen|gehend|Person|schlendern|schlurfen|wandern Mann|Männersymbol|Symbol|Zeichen
🚶‍♀️|Fußgänger|Fußgänger(in)|Fußgängerin|gehen|gehend|Person|schlendern|schlurfen|wandern Frau|Frauensymbol|weiblich|Zeichen
🏃‍♂️|eilig|joggen|laufen|Laufen|laufende Person|Läufer|Läuferin|Marathon|Person|rennen|schnell|Sport Mann|Männersymbol|Symbol|Zeichen
🏃‍♀️|eilig|joggen|laufen|Laufen|laufende Person|Läufer|Läuferin|Marathon|Person|rennen|schnell|Sport Frau|Frauensymbol|weiblich|Zeichen
🕺|Mann|tanzen|tanzender Mann
💃|Frau|Tanz|tanzen|tanzende Frau|Tänzerin
🕴️|Anzug|geschäftlich|Mann|schwebender Mann im Anzug|Schwebender Mann im Anzug
👯‍♂️|Bunny|Bunnys|doppelt|Hasenohren|Leute|Party|Person|Personen mit Hasenohren|seelenverwandt|Tanzen|Tänzerinnen|Zwillinge Mann|Männersymbol|Symbol|Zeichen
👯‍♀️|Bunny|Bunnys|doppelt|Hasenohren|Leute|Party|Person|Personen mit Hasenohren|seelenverwandt|Tanzen|Tänzerinnen|Zwillinge Frau|Frauensymbol|weiblich|Zeichen
🧖‍♂️|abschalten|Dampfbad|Dampfsauna|entspannen|Frau|luxuriös|Person|Person in Dampfsauna|Relaxen|Sauna|Spa Mann|Männersymbol|Symbol|Zeichen
🧖‍♀️|abschalten|Dampfbad|Dampfsauna|entspannen|Frau|luxuriös|Person|Person in Dampfsauna|Relaxen|Sauna|Spa Frau|Frauensymbol|weiblich|Zeichen
🧘|burmesischer Sitz|Frau|Lotussitz|Meditation|Person|Person im Lotossitz|Person in Lotussitz|Schneidersitz|Yoga|Zen
👭|Frauen|Händchen halten|Händchen haltende Frauen|Paar|Pärchen aus Frau und Frau
👫|Frau|Händchen halten|Mann|Mann und Frau halten Hände|Paar|Pärchen aus Frau und Mann
👬|Händchen halten|Händchen haltende Männer|Männer|Paar|Pärchen aus Mann und Mann|Zwillinge
💏|Frau|Herz|Kuss|küssen|Küssendes Paar|Mann|sich küssendes Paar
👨‍❤️‍💋‍👨|erwachsen|Gesicht|Mann Herz|rotes Herz Gefühl|Knutsch|Kuss|Kussabdruck|küssen|Liebe|Lippen|Lippenstift|romantisch|sexy erwachsen|Gesicht|Mann
👩‍❤️‍💋‍👩|erwachsen|Frau|Gesicht Herz|rotes Herz Gefühl|Knutsch|Kuss|Kussabdruck|küssen|Liebe|Lippen|Lippenstift|romantisch|sexy erwachsen|Frau|Gesicht
💑|Frau|Herz|Liebe|Liebespaar|Mann|Paar
👨‍❤️‍👨|erwachsen|Gesicht|Mann Herz|rotes Herz erwachsen|Gesicht|Mann
👩‍❤️‍👩|erwachsen|Frau|Gesicht Herz|rotes Herz erwachsen|Frau|Gesicht
👪|Familie|Junge|Kind|Mutter|Vater
👨‍👩‍👦|erwachsen|Gesicht|Mann erwachsen|Frau|Gesicht Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👩‍👧|erwachsen|Gesicht|Mann erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👨‍👩‍👧‍👦|erwachsen|Gesicht|Mann erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👩‍👦‍👦|erwachsen|Gesicht|Mann erwachsen|Frau|Gesicht Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👩‍👧‍👧|erwachsen|Gesicht|Mann erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👨‍👨‍👦|erwachsen|Gesicht|Mann erwachsen|Gesicht|Mann Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👨‍👧|erwachsen|Gesicht|Mann erwachsen|Gesicht|Mann Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👨‍👨‍👧‍👦|erwachsen|Gesicht|Mann erwachsen|Gesicht|Mann Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👨‍👦‍👦|erwachsen|Gesicht|Mann erwachsen|Gesicht|Mann Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👨‍👧‍👧|erwachsen|Gesicht|Mann erwachsen|Gesicht|Mann Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👩‍👩‍👦|erwachsen|Frau|Gesicht erwachsen|Frau|Gesicht Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👩‍👩‍👧|erwachsen|Frau|Gesicht erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👩‍👩‍👧‍👦|erwachsen|Frau|Gesicht erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👩‍👩‍👦‍👦|erwachsen|Frau|Gesicht erwachsen|Frau|Gesicht Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👩‍👩‍👧‍👧|erwachsen|Frau|Gesicht erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👨‍👦|erwachsen|Gesicht|Mann Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👦‍👦|erwachsen|Gesicht|Mann Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👧|erwachsen|Gesicht|Mann Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👨‍👧‍👦|erwachsen|Gesicht|Mann Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👨‍👧‍👧|erwachsen|Gesicht|Mann Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👩‍👦|erwachsen|Frau|Gesicht Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👩‍👦‍👦|erwachsen|Frau|Gesicht Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👩‍👧|erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
👩‍👧‍👦|erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkelsohn|Gesicht|jung|Junge|jünger|Kind|munter|Sohn|strahlend
👩‍👧‍👧|erwachsen|Frau|Gesicht Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter Enkeltochter|Gesicht|jung|jünger|Kind|Mädchen|munter|strahlend|Tochter
🗣️|Gesicht|Kopf|Silhouette|sprechen|sprechend|Sprechende Person|sprechender Kopf
👤|Büste|Person|Silhouette einer Büste
👥|Büsten|Personen|Silhouette mehrerer Büsten
🫂|Abschied|Danke|drücken|Drücker|Freundschaft|Hallo|Liebe|sich umarmende Personen|Tschüss|Umarmung
👣|Abdruck|auf dem Weg|Fuß|Fußabdruck|Fußabdrücke
🧳|Ballast|Gepäck|Hartschalenkoffer|Koffer|Reise|Trolley-Tasche
🌂|geschlossener Regenschirm|Geschlossener Regenschirm|Regen|Regenschirm
☂️|Bekleidung|Regen|Regenschirm|Wetter
🧵|Faden|Nadel|nähen|Nähen|Nähfaden|Nähgarn|Rolle|Spule|Zwirn
🧶|Ball|Garn|häkeln|Häkeln|spinnen|stricken|Stricken|Wolle|Wollknäuel|Zwirn
👓|Accessoire|Brille
🕶️|Augen|Brille|dunkel|Sonnenbrille
🥽|Augenschutz|Brille|Schutzbrille|schweißen|Schweißen|Schweißerbrille|schwimmen|Schwimmen|tauchen|Taucherbrille
🥼|Arzt|Arztkittel|Doc|Doktor|Experiment|Kleidung|Kleidungsstück|Laborkittel|Labormantel|weiße Jacke|weißer Mantel|Wissenschaftler
👔|Hemd|Hemd mit Krawatte|Kleidung|Kragen|Schlips
👕|Kleidung|Shirt|T-Shirt
👖|Hose|Jeans|Kleidung
🧣|Hals|kalt|Kleidung|Schal|warm anziehen
🧤|Hand|Handschuh|Handschuhe
🧥|brr|Jacke|kalt|Kleidung|Mantel|warm anziehen
🧦|socken|Socken|strumpf|strümpfe|Strümpfe
👗|Kleid|Kleidung
👘|japanisch|Kimono|Kleid|Kleidung
👙|Badeanzug|Bikini|Kleidung
👚|Bluse|Damenmode|Kleidung|Oberbekleidung|Shirt
👛|Accessoire|Brieftasche|Geldbörse|Münzen|Portemonnaie
👜|Accessoire|einkaufen|Handtasche|Tasche
👝|Accessoire|Beutel|Clutch|Handtasche|Kulturbeutel|Tasche|Waschtasche
🎒|Ranzen|Rucksack|Schule|Schulranzen|Tornister
👞|gehen|Herren|Herrenschuh|Schuh
👟|laufen|rennen|Schuh|Sneaker|sportlich|Sportschuh|Turnschuh
🥾|brauner Schuh|campen|Camping|Kleidungsstück|Outdoor|Rucksacktour|Schuh|Stiefel|Wandern|Wanderstiefel|Wanderung
🥿|Ballerina|Ballet-Pumps|bequem|flacher Schuh|Frauenschuh|Kleidungsstück|Schuh|Slipper
👠|Absatz|Absatzschuh|Damen|elegant|High Heel|Highheels|Pumps|rot|Schuh|Stöckelschuh|vornehm
👡|Damen|Damensandale|Sandale|Schuh
👢|Damen|Damenstiefel|Schuh|Stiefel
👑|König|Königin|Kopfbedeckung|Krone|Majestät
👒|Damenhut|Damenhut mit Schleife|Hut|Kleidung|Kopfbedeckung|Schleife
🎩|Hut|Kopfbedeckung|Unterhaltung|Zauberer|Zylinder|Zylinderhut
🎓|Abschlussfeier|Diplom|Doktorhut
🧢|Baseball|Baseball-Kappe|Baseball-mütze|Baseballkappe|Baseballmütze|Mütze|Schirmkappe
⛑️|bergen|erste Hilfe|Helm|Helm mit weißem Kreuz|Hilfe|Kreuz|retten|Rettungshelm|roter Helm|Sanitäter
💄|Kosmetik|Lippenstift|Make-up|makeup|Rot|Schminke
💍|Diamantring|Edelstein|Ring|Schmuck|Verlobung
💼|Aktentasche|Tasche
🐶|Gesicht|Hund|Hundegesicht|Tier|treu|Wau|wuff
🐱|Gesicht|Katze|Katzengesicht|Miau|Miez|Miezekatze|Tier
🐭|Gesicht|Maus|Mäusegesicht|Mausgesicht|Nagetier|Tier
🐹|Gesicht|Hamster|Hamstergesicht|Tier
🐰|Gesicht|Hase|Hasengesicht|Kaninchen|Karnickel|Langohr|Mümmelmann|Nager|Nagetier|Tier
🦊|Fuchs|Fuchsgesicht|Gesicht|Tier
🐻|Bär|Bärengesicht|Gesicht|Tier
🐼|Gesicht|Panda|Pandabär|Pandagesicht|Tier
🐨|Koala|Koalabär|Koalagesicht|Tier
🐯|Gesicht|Raubkatze|Tier|Tiger|Tigergesicht
🦁|Gesicht|Löwe|Löwengesicht|Sternzeichen|Tier|Tierkreis
🐮|Gesicht|Kuh|Kuhgesicht|Tier
🐷|Gesicht|Schwein|Schweinegesicht|Tier
🐽|Nase|Schwein|Schweinerüssel|Tier
🐸|Frosch|Froschgesicht|Gesicht|grün|quak|Tier
🐵|Affe|Affengesicht|Banane|Dschungel|Gesicht|Tier|Zoo
🙈|Affe|Affengesicht|Augen|böse|Geheimnis|gemein|Geste|nein|omg|sehen|Tier|verboten|vergessen|verstecken|zuhalten
🙉|Affe|Affengesicht|böse|Geheimnis|gemein|Geste|hören|nein|Ohren|Tier|verboten|zuhalten|zuhören
🙊|Affe|Affengesicht|böse|Geheimnis|gemein|Geste|Hand|heimlich|leise|Mund|nein|sagen|sprechen|still|Tier|ups|verboten|zuhalten
🐒|Affe|Tier
💥|Bombe|Boom|Comic|explodieren|Explosion|kollidieren|Kollision|Zusammenstoß|zusammenstoßen
💫|benommen|Benommenheit|Comic|Komet|schwindlig|Stern|Sterne|Sternschnuppe
💦|Comic|feucht|nass|Schweiß|Schweißtropfen|schwitzen|trainieren|Training|Tropfen|Wasser
💨|Comic|rennen|Staubwolke|weglaufen
🦍|Affe|Gesicht|Gorilla|Tier
🐕|Haustier|Hund|Tier|wau|wuff
🐩|Hund|Pudel|Tier
🐺|Gesicht|Tier|Wolf|Wolfsgesicht
🦝|klug|neugierig|schlau|Tier|Waschbär
🐈|Haustier|Katze|miau|Tier
🐅|Tier|Tiger
🐆|gepunktet|Leopard|Punkte|Raubkatze|Raubtier|Tier|Zoo
🐴|Gesicht|Pferd|Pferdegesicht|Pferdekopf|Tier
🐎|Pferd|Rennen|Rennpferd|Tier
🦄|Einhorn|Einhorngesicht|Gesicht
🦓|streifen|Streifen|tier|zebra|Zebra
🐂|Kuh|Ochse|Sternzeichen|Stier|Tier|Tierkreis
🐃|Büffel|Tier|Wasser|Wasserbüffel
🐄|Bauernhof|Kuh|muh|Tier
🐖|Bauernhof|Sau|Schwein|Tier
🐗|Eber|Schwein|Tier|Wildschwein
🐏|Schaf|Sternzeichen|Tierkreis|Widder
🐑|Bock|mäh|Schaf|Tier|Widder|Wolle
🐐|Steinbock|Sternzeichen|Tier|Tierkreis|Ziege
🐪|Dromedar|einhöckrig|Kamel|Tier|Wüste
🐫|Kamel|Tier|Wüste|zweihöckrig
🦙|Alpaca|Alpaka|Anden|Kamel|Lama|Tier|Vicuña|Wolle
🦒|flecken|Flecken|giraffe|Giraffe|tier
🐘|Elefant|Tier
🦏|Nashorn|Rhinozeros|Tier
🦛|Flusspferd|Hippo|Nilpferd|Tier
🐁|Maus|Nage|Tier
🐀|Nagetier|Ratte|Tier
🐇|Hase|Kaninchen|Karnickel|Mümmelmann|Nagetier|Tier
🐿️|Streifenhörnchen|Tier
🦔|igel|Igel|stachelig|stacheln|tier
🦇|Fledermaus|Tier|Vampir
🦘|Australien|Beuteltier|Down Under|hüpfen|Hüpfen|Känguru|Quokka|Skippy|springen|Tier|Wallaby
🦡|Dachs|Dachse|Frechdachs|Honigdachs|Ratel|Tier
🐾|Abdruck|Tatzen|Tatzenabdrücke|Tier
🦃|Geflügel|Pute|Thanksgiving|Truthahn
🐔|Geflügel|Henne|Huhn|Tier|Tierkopf
🐓|Hahn|Tier
🐣|Ei|Küken|Küken in Eierschale|Piep|schlüpfen|schlüpfendes Küken|Tier|Vogel
🐤|Küken|Kükenkopf|Tier
🐥|Geflügel|Küken|Küken in Frontansicht|Küken von vorne|Tier
🐦|Papagei|Taube|Tier|Vogel|Vogelkopf
🐧|Pinguin|Pinguinkopf|Tier|Vogel
🕊️|fliegen|Friede|Frieden|Friedenstaube|Taube|Vogel
🦅|Adler|Tier|Vogel
🦆|Ente|Tier|Vogel
🦢|hässliches Entlein|Schwan|Tier|Vogel
🦉|Eule|Raubvogel|Tier|Uhu|Vogel|weise
🦚|bunt|Pfau|stolz|stolzieren|Tier|Vogel
🦜|ausplaudern|Papagei|Pirat|plappern|sprechen|Tier|Vogel|Wiederholen
🐊|Krokodil|Reptil|Schnappi|Tier
🐢|Schildkröte|Tier
🦎|Eidechse|Reptil
🐍|Schlange|Schlangenträger|Sternzeichen|Tier|Tierkreis
🐲|Drache|Drachengesicht|Gesicht|Märchen|Tier
🐉|chinesisch Neujahr|Drache|Märchen|Tier
🦕|brachiosaurus|Brachiosaurus|brontosaurus|Brontosaurus|Dino|dinosaurier|Dinosaurier|diplodocus|Diplodocus|saurier|Saurier|sauropod|Sauropode|tier
🦖|Dino|dinosaurier|Dinosaurier|saurier|Saurier|t-rex|T-Rex|tree|Tyrannosaurus Rex
🧌|Fantasy|gruslig|Kobold|Märchen|Monster|Ork|Troll|Ungeheuer
🐳|blasender Wal|Blasender Wal|Meer|Ozean|Tier|Wal
🐋|Ozean|Tier|Wal
🐬|Delfin|Meer|Ozean|Strand|Tier
🐟|Aquarium|Fisch|Fische|Meehr|Sternzeichen|Tier|Tierkreis
🐠|Fisch|Tier|Tropenfisch
🐡|Fisch|Kugelfisch|kugelrund|Meer|Tier
🦈|Fisch|Hai|Haifisch|Meer|Tier
🐙|Krake|Meer|Oktopus|Tier|Tintenfisch
🪹|Heim|leeres Nest|Nest|Nestbau|nisten|Vogelnest|Zuhause
🪺|Heim|Nest|Nest mit blauen Eiern|Nest mit Eiern|Nestbau|nisten|Vogelnest|Zuhause
🐚|Muschel|Schneckenhaus|Strand|Tier
🪸|Great Barrier Reef|Klimawandel|Koralle|Korallenriff|Meer|Ozean|Riff|Tier
🐌|langsam|Schnecke|Tier
🦋|Insekt|Schmetterling|schön
🐛|gefräßig|Insekt|Raupe|Tier
🐜|Ameise|Insekt|Tier
🐝|Biene|Honig|Honigbiene|Hummel|Insekt|Maja|Natur|Summ|Tier
🐞|Glückskäfer|Insekt|Käfer|krabbel|Marienkäfer|Punkte|Tier
🦗|grashüpfer|grille|Grille|Heuschrecke|insekt|tier|zikade
🕷️|Insekt|Spinne|Tier
🕸️|Netz|Spinne|Spinnennetz
🦂|Horoskop|Skorpion|Sternzeichen|Tierkreis
🦟|Biss|Fieber|Insekt|Insektenbiss|Insektenstich|Krankheit|Malaria|Moskito|Mücke|Schnake|Stechmücke|Stich|Tier|Virus
🦠|Amöbe|Amöben|Bakterie|Bakterien|Einzeller|Medizin|Mikrobe|Virus|Wissenschaft
💐|Blumen|Blumenstrauß|Bouquet
🌸|Blume|Blüte|Kirschblüte|Kirsche|Pflanze
💮|Blume|Blumenstempel
🏵️|Pflanze|Rosette
🪷|Blume|Buddhismus|Erleuchtung|Gleichmut|Hinduismus|Liebe|Lotosblume|Lotusblüte|Pflanze|Reinheit|Ruhe|Schönheit
🌹|Blume|Blüte|Pflanze|Rose
🥀|am sterben|Blume|sterbend|verwelkt|welk|welke Blume|welkende Blume
🌺|Blume|Blüte|Hibiskus|Pflanze|Rosa
🌻|Blume|Blüte|Pflanze|Sonne|Sonnenblume
🌼|Blume|Blüte|gelbe Blüte|Gelbe Blüte|Pflanze
🌷|Blume|Blüte|Pflanze|Tulpe
🌱|junge Pflanze|Spross
🌲|Baum|Nadelbaum|Pflanze|Tannenbaum
🌳|Baum|Blätter|grün|Laub|Laubbaum|Pflanze|Wald
🌴|Baum|Kokusnuss|Oase|Palme|Pflanze|Strand|Tropen
🌵|Dürre|Kaktus|Natur|Pflanze|Trockenzeit|Wüste
🌾|Ähre|Pflanze|Reis|Reisähre|Reispflanze
🌿|Blätter|Kräuter|Pflanze
☘️|grün|Kleeblatt|Pflanze
🍀|Blatt|Glück|Glücksklee|Klee|Kleeblatt|Pflanze|Silverster|vier|vierblättrig|Vierblättriges Kleeblatt
🍁|Ahorn|Ahornblatt|Blatt|Herbst|Laub|Pflanze
🍂|Blatt|Blätter|Fallendes Laub|Herbst|Laub|Pflanze
🍃|Blatt|Blätter|Blätter im Wind|Laub|Pflanze|Wind
🍄|Fliegenpilz|giftig|Pilz
🌰|Kastanie|Marone
🦀|Krabbe|Krebs|Meer|Sternzeichen|Strand|Tierkreis
🦞|Hummer|Lobster|Meeresfrucht|Meeresfrüchte|Meerestier|Scheren|Tier
🦐|Garnele|Gourmet|Krustentier|Meeresfrucht|Shrimp
🦑|Kalmar|Tier|Tintenfisch
🌍|Afrika|Erde|Europa|Globus mit Europa und Afrika|Weltkugel
🌎|Erde|Globus|Globus mit Amerika|Nordamerika|Südamerika|Weltkugel
🌏|Asien|Australien|Erde|Globus|Globus mit Asien und Australien|Weltkugel
🌐|Breitengrad|Globus mit Meridianen|Längengrad
🌑|Mond|Neumond
🌒|erstes Mondviertel|Erstes Mondviertel|Mond|zunehmend
🌓|Halbmond|Mond|zunehmend|zunehmender Halbmond|Zunehmender Halbmond
🌔|Mond|zunehmend|zweites Mondviertel|Zweites Mondviertel
🌕|Mond|Vollmond
🌖|abnehmend|drittes Mondviertel|Drittes Mondviertel|Mond
🌗|abnehmend|abnehmender Halbmond|Abnehmender Halbmond|Halbmond
🌘|abnehmend|letztes Mondviertel|Letztes Mondviertel|Mond|Nacht
🌙|Mond|Mondsichel|Nacht
🌚|Gesicht|Mond|Mondgesicht|Neumond|Neumond mit Gesicht
🌛|Gesicht|Mond|Mondsichel|Mondsichel mit Gesicht links|Weltall
🌜|Gesicht|Mondsichel|Mondsichel mit Gesicht rechts|Nacht
☀️|Sonne|Sonnenstrahlen|sonnig|Strahlen|Wetter
🌝|Gesicht|Vollmond|Vollmond mit Gesicht
🌞|Gesicht|Sonne|Sonne mit Gesicht|Sonnengesicht|Sonnenschein
⭐|astronomie|gelber Stern|Himmel|Stern|weißer mittelgroßer Stern
🌟|funkeln|funkelnder Stern|Funkelnder Stern|glitzern|Stern
🌠|Himmel|Sternschnuppe
☁️|Wetter|Wolke|wolkig
⛅|Sonne|Sonne hinter Wolke|Wolke|wolkig
⛈️|Blitz|Gewitter|Regen|Wetter|Wolke|Wolke mit Blitz und Regen|wolkig
🌤️|bewölkt|kleine Wolke|Sonne|Sonne hinter kleiner Wolke|Wetter|Wolke
🌥️|bewölkt|große Wolke|Sonne|Sonne hinter großer Wolke|Wetter|Wolke
🌦️|Regenwolke|Sonne|Sonne hinter Regenwolke|Wetter
🌧️|Regen|Regenwolke|Wetter|Wolke|Wolke mit Regen
🌨️|kalt|Schnee|Wetter|Wolke|Wolke mit Schnee
🌩️|Blitz|Gewitter|Wetter|Wolke|Wolke mit Blitz
🌪️|Tornado|Wetter|Wirbelsturm
🌫️|Nebel|neblig|Wetter
🌬️|Wetter|Wind|windig
🌈|Regenbogen|Wetter
☔|Regen|Regenschirm|Regenschirm im Regen
⚡|Blitz|Elektrizität|Gefahr|Gewitter|Hochspannung|Hochspannungszeichen|Strom
❄️|Flocke|kalt|Schnee|Schneeflocke|schneien|Wetter|Winter
☃️|Schnee|Schneemann|Schneemann im Schnee
⛄|kalt|Schnee|Schneemann|Schneemann ohne Schneeflocken|Winter
☄️|Komet|Weltall
🔥|brennen|Feuer|Flamme|heiß
💧|Schweiß|Träne|Tropfen|Wasser|Wassertropfen
🫧|Blasen|Perlen|reinigen|Schaum|schweben|Seife|Seifenblasen|unter Wasser|Wasserblasen
🌊|Meer|Welle
🎄|Baum|Tanne|Weihnachten|Weihnachtsbaum
✨|*|funkel|funkeln|funkelnde Sterne|Funkelnde Sterne|Sterne
🎋|Baum|Fest|Japan|Sternenfest|Tanabata-Baum|Zettel
🎍|Japan|Neujahrsfest|Piniendekoration
🍇|Frucht|Obst|Traube|Trauben|Wein
🍈|cantaloupe|Frucht|Honigmelone|Melone|Obst
🍉|Frucht|Melone|Obst|Wasser|Wassermelone
🍊|Apfelsine|Frucht|Mandarine|Obst|Orange|Vitamin
🍋|Frucht|Obst|sauer|Zitrone|Zitrusfrucht
🍌|Banane|Frucht|Obst|Schale
🍍|Ananas|Frucht|Obst
🥭|Essen|Frucht|Früchte|Mango|Obst|Shaker|tropisch
🍎|Apfel|Frucht|Obst|rot|roter Apfel
🍏|Apfel|Frucht|gesund|grün|grüner Apfel|Obst
🍐|Birne|Frucht|Obst
🍑|Frucht|Obst|Pfirsich
🍒|Frucht|Kirsche|Kirschen|Obst
🍓|Beere|Erdbeere|Essen|Frucht|Obst
🥝|Frucht|Kiwi|Obst
🍅|Essen|Gemüse|Obst|Tomate
🥥|Colada|Essen|Frucht|Kokosnuss|Palme|Piña
🥑|Avocado|Essen|Frucht
🍆|Aubergine|Gemüse
🥔|Essen|Gemüse|Kartoffel
🥕|Gemüse|Karotte|Möhre|Mohrrübe
🌽|Gemüse|Mais|Maiskolben
🌶️|Chili|Paprika|Peperoni|Pfeffer|Pflanze|scharf
🥒|Essen|Gemüse|Gurke|Scheiben
🥬|Blattgemüse|blattgrün|Essen|Gemüse|Grünkohl|Grünzeug|Kohl|Kraut|Mangold|Pak Choi|Pok Choi|Salat|Salatblatt|Spinat
🥦|Broccoli|Brokkoli|essen|Gemüse|Gemüsekohl|Kohl
🥜|Erdnuss|Essen
🫘|Bohne|Bohnen|Essen|Gemüse|Hülsenfrucht|Kidney-Bohne|Kidneybohne|Lebensmittel
🍞|Brot|Brotlaib|Essen|Kohlenhydrate|Laib Brot|Toast|Weißbrot|Weizen
🥐|Corissant|Croissant|französisch|Frühstück|Frühstückshörnchen
🥖|Baguette|Brot|französisch|Frühstück
🥨|brezel|Brezel|brezen|brezn|essen|gedreht|oktoberfest
🥯|Bäckerei|Backwaren|Bagel|Brötchen|Essen|Frühstück|Pausenbrot
🥞|Crepe|Eierpfannkuchen|Essen|Pfannkuchen
🧀|Käse|Käsestück
🍖|Fleisch|Fleischhachse|Knochen|Restaurant
🍗|Fleisch|Geflügel|Hähnchenschenkel|Hühnerbein|Restaurant
🥩|essen|Fleisch|Fleischstück|Kotelett|Lammkotelett|rot|Schnitzel|Schweinekotelett|Steak
🥓|Bacon|Essen|Frühstücksspeck|Speck|Speckstreifen
🍔|Burger|Fast Food|Hamburger|Restaurant
🍟|Fritten|Pommes|Pommes frites|Pommes Frites
🍕|Pizza|Pizzastück|Pizzeria
🌭|Essen|Frankfurter|Hot Dog|Hotdog|Wurst|Würstchen
🥪|brot|Brot|essen|sandwich|Sandwich
🌮|Essen|mexikanisch|Taco
🌯|Burrito|essen|mexikanisch
🥙|Döner|Döner Kebab|Falafel|Wrap
🍳|braten|Bratpfanne|Kochen|Pfanne|Spiegelei|Spiegelei in Bratpfanne
🥘|Essen|Paella|Pfannengericht|Reispfanne
🍲|Eintopf|Gericht|Schüssel|Suppe|Topf mit Essen
🥣|brei|Cerealien|essen|Frühstück|haferbrei|Reisbrei|schüssel|Schüssel mit Löffel|suppe
🥗|Blattgemüse|Essen|gesund|grün|Salat
🍿|Kino|Popcorn|Snack
🧂|gesalzen|Geschmack|Gewürz|Salz|salzig|Salzstreuer|Würze|Zutat
🥫|Büchse|Dose|essen|Konserve
🫙|Einmachglas|Einweckglas|Essen|Gewürzglas|leer|leerer Behälter|leeres Einweckglas|leeres Glas|Marmeladeglas|Schraubglas
🍱|Bento|Bento-Box|Japanisches essen|Sushi
🍘|Cracker|Reiscracker
🍙|Essen|japanisch|Reis|Reisbällchen
🍚|Essen|Reis|Reis in Schüssel
🍛|Curry|Reis|Reis mit Curry
🍜|chinesisches Essen|dampfend|Eiernudeln|Nudeln|Schüssel|Schüssel und Essstäbchen|Stäbchen|Suppe
🍝|Essse|Nudeln mit Tomatensoße|Pasta|Restaurant|Spaghetti
🍠|Essen|Gemüse|geröstet|Süßkartoffel
🍢|japanisches Gericht|Oden|Restaurant
🍣|japanisches Gericht|Restaurant|Sushi
🍤|frittierte Garnele|Frittierte Garnele|Garnele|Restaurant|tempura
🍥|Fisch|Fischfrikadelle|Restaurant|Spirale
🥮|Essen|Fest|Festival|Herbst|Kuchen|Mondfest|Mondkuchen|Pinyin|Yuebing
🍡|Dango|japanisches Gericht|Mochi-Kugeln auf einem Spieß|Restaurant
🥟|chinesische Teigtasche|dumpling|empanada|Empanada|essen|Gyōza|Jiaozi|kloß|Pierogi|potsticker|Teigtasche
🥠|essen|Glückskeks|Prophezeiung
🥡|chinesisches essen|essen|stäbchen|Takeaway-Box|Takeaway-Schachtel
🍦|Eis|Softeis
🍧|Eis|Sorbet|Wassereis|zerstoßen
🍨|Eis|Eisbecher|Eiscreme|Eisdiele
🍩|Donut|Doughnut|Essen|Kuchen|süß
🍪|Cookie|Keks|Plätchen
🎂|Essen|feier|Feier|Geburtstag|Geburtstagskuchen|Geburtstagstorte|happy birthday|kerzen|Kuchen|Lebensmittel|Torte
🍰|Kuchen|Kuchenstück|Stück Torte|Torte|Tortenstück
🧁|Bäckerei|Cupcake|Dessert|Essen|Gebäck|Kalorienbombe|Konditorei|Muffin|Nachspeise|Streusel|süß|Zucker
🥧|Essen|Füllung|Gebäck|Kuchen|Pastete|Torte
🍫|Essen|Schokolade|Schokoladentafel|Süßigkeit
🍬|Bonbon|süß|Süßigkeit
🍭|Lolli|Lutscher|Süßigkeit
🍮|Dessert|Flan|Nachspeise|Nachtisch|Pudding|Schokolade|Soße
🍯|Honig|Honigtopf|süß
🍼|Baby|Babyflasche|Fläschchen|Flasche|Kind|Milch|trinken
🥛|Getränk|Glas|Milch|trinken
🫗|ausgießen|ausleeren|Flüssigkeit ausgießen|Getränk|gießen|Glas|leer|Missgeschick|tropfende Flüssigkeit|verschütten
☕|Cafe|dampfend|Getränk|heiß|Heißgetränk|Kaffee|Tasse|Tee|trinken
🍵|Getränk|grüner Tee|Oolong|Schale|Tee|Teetasse|Teetasse ohne Henkel
🧉|Getränk|Mate-Tee|Tee
🍶|Flasche|Getränk|Sake|Sake-Flasche mit Tasse|Sake-Flasche und -tasse|Tasse|trinken
🍾|Champagner|Flasche|Flasche mit knallendem Korken|Getränk|knallen|Korken|Sekt|trinken
🍷|Alkohol|Bar|Glas|Wein|Weinglas
🍸|Bar|Cocktail|Cocktailglas|Drink|martini
🍹|Bar|Cocktail|exotisches Getränk
🍺|Bar|Bier|Bierkrug|Krug|Oktoberfest|prost|Weizenbier
🍻|anstoßen|Bier|Bierkrüge|Oktoberfest|prosit|prost|Weizen
🥂|anstoßen|Feier|feiern|Getränk|Gläser|prost|Sekt|Sektgläser
🥃|Bar|Schnaps|Trinkglas|Whiskey
🥤|becher|Becher mit Strohhalm|brause|erfrischung|Saft|Selters|soda|strohhalm|trinken|trinkhalm|wasser
🥢|chinesisches essen|essen|Essstäbchen|Hashi|japanisches essen|stäbchen|Stäbchen
🍽️|Gabel|Geschirr|kochen|Messer|Teller|Teller mit Messer und Gabel
🍴|Abendessen|Besteck|Essen|Frühstück|Gabel|Gabel und Messer|Geschirr|Hunger|lecker|Messer|Messer und Gabel|Mittagessen|Restaurant
🥄|Besteck|Löffel
🗾|Japan|Karte|Umriss von Japan
🏔️|Berg|Gebirge|kalt|Schnee|schneebedeckter Berg|Schneebedeckter Berg
⛰️|Berg|Gebirge
🌋|Ausbruch|Berg|Lava|Vulkan|Vulkanausbruch|Wetter
🗻|Berg|Fuji|Vulkan
🏕️|campen|Camping|Zelt|zelten
🏖️|Meer|Sonnenschirm|Strand|Strand mit Sonnenschirm
🏜️|heiß|Wüste
🏝️|einsam|einsame Insel|Einsame Insel|Insel|Meer|Palme|Strand|verlassen
🏞️|Berg|Fluss|Nationalpark|Natur|Park|Schutzgebiet
🏟️|Arena|Stadion
🏛️|antik|antikes Gebäude|Antikes Gebäude|Gebäude|klassizistisch
🏗️|Bau|bauen|Kran
🏘️|Dorf|Gebäude|Haus|Häuser|Wohnhaus|Wohnhäuser|Wohnsiedlung
🏚️|Gebäude|Haus|heruntergekommen|verfallen|verfallenes Haus|verlassen|Verlassenes Haus
🏠|Gebäude|Haus|Zuhause
🏡|Baum|Haus|Haus mit Baum|Haus mit Garten
🏢|Bürogebäude|Hochhaus
🏣|Japan|japanisches Postgebäude|Japanisches Postgebäude|Post
🏤|Europa|Europäisches Postgebäude|Post|Postgebäude
🏥|Ambulanz|Arzt|Gebäude|krank|Krankenhaus|Medizin|Notaufnahme
🏦|Bank|Gebäude|Geld
🏨|Gebäude|Hotel|übernachten|Unterkunft
🏩|Gebäude|Hotel|Liebe|Stundenhotel|Unterkunft
🏪|einkaufen|Gebäude|Geschäft|Lebensmittel|Minimarkt
🏫|Gebäude|Schule|Schulgebäude
🏬|einkaufen|Gebäude|Geschäft|Kaufhaus|shoppen
🏭|Fabrik|Fabrikgebäude|Gebäude
🏯|Bauwerk|Gebäude|Japan|japanisch|japanisches Schloss|Japanisches Schloss|Schloss
🏰|Bauwerk|Burg|Europa|europäisch|Gebäude|Märchen|Märchenschloss|Schloss
💒|Herz|Hochzeit|Kirche
🗼|Fernsehturm|Tokio|Tokyo Tower
🗽|Amerika|Freiheit|Freiheitsstatue
⛪|Christ|Christentum|christlich|Gebäude|Kirche|Kreuz|Religion
🕌|Islam|Moschee|Moslem|Muslim|Religion
🕍|Jude|jüdisch|Religion|Synagoge|Tempel
⛩️|Religion|Schrein|Shinto|Shinto-Schrein
🕋|Hajj|Islam|Kaaba|Moslem|Muslim|Religion
⛲|Brunnen|Garten|Park|Springbrunnen
⛺|Camping|Campingurlaub|Zelt|Zeltplatz
🌁|Nebel|neblig|Wetter
🌃|City|Hochhäuser|Nacht|Skyline|Stadt|Sterne|Sternenhimmel
🏙️|Gebäude|Großstadt|Häuser|Hochhäuser|Skyline|Stadt|Wolkenkratzer
🌄|Berge|Sonnenaufgang|Sonnenaufgang über Bergen
🌅|Meer|Sonnenaufgang|Sonnenaufgang über dem Meer
🌆|Abendstimmung in der Stadt|Hochhäuser|New York|Skyline|Sonnenaufgang|Sonnenuntergang|Wolkenkratzer
🌇|Großstadt|Hochhäuser|Morgenrot|Sonnenaufgang|Sonnenuntergang|Sonnenuntergang in der Stadt|Wolkenkratzer
🌉|Brücke|Brücke vor Nachthimmel|Golden Gate|Nacht|nachts
🎠|Karussell|Karussellpferd|Pferd|reiten
🎡|Freizeitpark|Rad|Riesenrad|Volksfest
🎢|Achterbahn|Freizeitpark|Volksfest
🚂|Bahn|Dampf|Dampflok|Dampflokomotive|Fahrzeug|Lokomotive|Schiene|Zug
🚃|Eisenbahnwagen|Fahrzeug|Straßenbahn|Straßenbahnwagen|Tram|Wagen|Waggon|Wagon|Zug
🚄|Hochgeschwindigkeitszug mit spitzer Nase|ICE|Shinkansen|TGV|Zug
🚅|Bahn|Hochgeschwindigkeitszug|Japan|Shinkansen|Zug
🚆|Bahn|Eisenbahn|ICE|Zug
🚇|Metro|U-Bahn
🚈|Bahn|ICE|Monorail|S-Bahn|Zug
🚉|Bahn|Bahnhof|Zug
🚊|Straßenbahn|Tram|Verkehrsmittel
🚝|Bahn|Einschienenbahn|Magnetschwebebahn|Monorail
🚞|Bahn|Bergbahn|Bimmelbahn|Zug
🚋|Straßenbahn|Straßenbahnwagen|Tram|Tramwagen|Transport|Verkehrsmittel|Waggon
🚌|Bus|Fahrzeug|Schulbus
🚍|Bus|Bus von vorne|Verkehrsmittel|Vorderansicht Bus
🚎|Oberleitungsbus|Straßenbahn|Trolleybus
🚐|Bus|Fahrzeug|Kleinbus
🚑|Ambulanz|Krankenwagen|Notfall
🚒|Brand|Feuerwehrauto|Löschfahrzeug
🚓|Polizei|Polizeiwagen|Streifenwagen
🚔|Polizei|Polizeiwagen von vorne|Streifenwagen|Vorderansicht Polizeiwagen
🚕|Auto|Fahrzeug|Taxi
🚖|Auto|fahren|gelb|Taxi|Taxi von vorne|Vorderansicht Taxi
🚗|Auto|fahren|Fahrzeug|rot|Verkehr
🚘|Auto|Auto von vorne|Automobil|Fahrzeug|rot|Vorderansicht Auto
🚚|Lastwagen|Lieferwagen|LKW
🚛|Lastwagen|LKW|Sattelzug|umziehen|ziehen um
🚜|Bauernhof|Landwirtschaft|Traktor|Trecker
🏎️|Autorennen|Rennauto
🏍️|Moped|Motorrad|Motorrennen
🛵|Motoroller|Motorroller|Roller|Vespa
🚲|BMX|Fahrrad|Rad|Radeln|Radler|Spinning
🛴|Roller|Tretroller
🚏|Bus|Bushaltestelle|Haltestelle
🛤️|Bahn|Bahngleis|Gleise|Schienen
⛽|Benzin|Tanke|tanken|Tanksäule|Tankstelle
🛞|Autorad|Autoreifen|drehen|Rad|Reifen|Reifen mit Felgen|rotieren
🚨|Polizei|Polizeilicht|Sirene
🚥|Ampel|horizontale Verkehrsampel|Horizontale Verkehrsampel|Verkehrsampel|vertikal
🚦|Ampel|horizontal|Verkehrsampel|vertikale Verkehrsampel|Vertikale Verkehrsampel
🚧|Baustelle|Baustellenabsperrung|Baustellenschild|Schild
⚓|Anker|Hafen|Meer
⛵|Boot|Segelboot
🚤|Boot|Luxus|Schnellboot|See|Sommer|Wasser|Yacht
🛳️|Aida|Passagierschiff|Rundreise|Schiff|Seereise|Traumschiff
⛴️|Fähre|Schiff
🛥️|Boot|Motorboot|Schiff
🚢|Dampfer|Kreuzfahrtschiff|Schiff|Traumschiff
🛟|Leben retten|Lebensretter|retten|Rettung|Rettungsring|Schwimmring|Sicherheit
✈️|Flieger|Flugzeug
🛩️|Flugzeug|klein|kleines Flugzeug|Kleines Flugzeug|Privatjet
🛫|Abflug|fliegen|Flughafen|Flugzeug|Start|Start eines Flugzeugs
🛬|Ankunft|Flieger|Flughafen|Flugzeug|landen|Landung|Landung eines Flugzeugs
💺|Bus|Flugzeug|Sitz|Sitzplatz|Zug
🚁|fliegen|Helikopter|Hubschrauber|reisen
🚟|Hängebahn|Schwebebahn
🚠|Bergschwebebahn|Schwebebahn
🚡|Bergseilbahn|Gondel|Seilbahn
🛰️|Satellit|Sputnik|Weltraum
🚀|All|Rakete|Weltraum
🛸|Alien|Außerirdisch|fliegende Untertasse|UFO
🌌|Galaxie|Milchstraße|Universum
⛱️|aufgestellt|aufgestellter Sonnenschirm|Aufgestellter Sonnenschirm|Sonnenschirm|Strand
🎆|Feuerwerk|Silvester
🎇|Feiern|Feuerwerk|Party|Wunderkerze
🎑|Japan|Mond|Mondfest|traditionelles Mondfest|Traditionelles Mondfest
🗿|Gesicht|Maske|Osterinsel|Statue
🛂|Pass|Passkontrolle
🛃|Zoll|Zollkontrolle
🛄|Gepäck|Gepäckausgabe
🛅|Gepäck|Gepäckaufbewahrung|Schließfach
🧗‍♂️|Bergsteiger|Bergsteiger(in)|Fels|Kletterer|klettern|Person|Sport Mann|Männersymbol|Symbol|Zeichen
🧗‍♀️|Bergsteiger|Bergsteiger(in)|Fels|Kletterer|klettern|Person|Sport Frau|Frauensymbol|weiblich|Zeichen
🏇|Jockey auf Pferd|Pferderennen|schnell|Sport|um die Wette|wetten
⛷️|Schnee|Ski|Skifahrer|Skifahrer(in)|Skifahrerin|Sport
🏂|Snowboard|Snowboarden|Snowboarder|Snowboarder(in)|Snowboarderin|Sport
🏌️‍♂️|Abschlagplatz|Golf|Golfer|Golfer(in)|Golferin|Golfspieler|Golfspielerin|Person|Sport|Sportler|Sportlerin Mann|Männersymbol|Symbol|Zeichen
🏌️‍♀️|Abschlagplatz|Golf|Golfer|Golfer(in)|Golferin|Golfspieler|Golfspielerin|Person|Sport|Sportler|Sportlerin Frau|Frauensymbol|weiblich|Zeichen
🏄‍♂️|Person|Sport|Surfboard|Surfbrett|Surfen|Surfer|Surfer(in)|Surferin|Wassersport|Wellenreiten|Wellenreiter|Wellenreiterin Mann|Männersymbol|Symbol|Zeichen
🏄‍♀️|Person|Sport|Surfboard|Surfbrett|Surfen|Surfer|Surfer(in)|Surferin|Wassersport|Wellenreiten|Wellenreiter|Wellenreiterin Frau|Frauensymbol|weiblich|Zeichen
🚣‍♂️|Angeln|Boot|Kanu|Paddel|Person|Person im Ruderboot|Ruderboot|Rudern|Sport Mann|Männersymbol|Symbol|Zeichen
🚣‍♀️|Angeln|Boot|Kanu|Paddel|Person|Person im Ruderboot|Ruderboot|Rudern|Sport Frau|Frauensymbol|weiblich|Zeichen
🏊‍♂️|Kraulen|Person|Pool|Schwimmbecken|Schwimmen|Schwimmer|Schwimmer(in)|Schwimmerin|Sport|Triathlon|Wasser Mann|Männersymbol|Symbol|Zeichen
🏊‍♀️|Kraulen|Person|Pool|Schwimmbecken|Schwimmen|Schwimmer|Schwimmer(in)|Schwimmerin|Sport|Triathlon|Wasser Frau|Frauensymbol|weiblich|Zeichen
⛹️‍♂️|Ball|Basketball|Basketballer|Basketballspieler|Basketballspielerin|Dribbeln|Person|Person mit Ball|Sport|Sportler|Sportlerin Mann|Männersymbol|Symbol|Zeichen
⛹️‍♀️|Ball|Basketball|Basketballer|Basketballspieler|Basketballspielerin|Dribbeln|Person|Person mit Ball|Sport|Sportler|Sportlerin Frau|Frauensymbol|weiblich|Zeichen
🏋️‍♂️|Gewicht|Gewichtheber|Gewichtheber(in)|Gewichtheberin|Hantel|Muskeln|Person|schwer|Sport|stark|Training Mann|Männersymbol|Symbol|Zeichen
🏋️‍♀️|Gewicht|Gewichtheber|Gewichtheber(in)|Gewichtheberin|Hantel|Muskeln|Person|schwer|Sport|stark|Training Frau|Frauensymbol|weiblich|Zeichen
🚴‍♂️|Fahrrad|Person|Rad|radeln|Radfahren|Radfahrer|Radfahrer(in)|Radfahrerin|Sport|Tour de France Mann|Männersymbol|Symbol|Zeichen
🚴‍♀️|Fahrrad|Person|Rad|radeln|Radfahren|Radfahrer|Radfahrer(in)|Radfahrerin|Sport|Tour de France Frau|Frauensymbol|weiblich|Zeichen
🚵‍♂️|Fahrrad|Mountainbiker|Mountainbiker(in)|Mountainbikerin|Mountainbiking|Person|Rad|Radfahren|Radfahrer|Radfahrerin|Sport|Tour de France Mann|Männersymbol|Symbol|Zeichen
🚵‍♀️|Fahrrad|Mountainbiker|Mountainbiker(in)|Mountainbikerin|Mountainbiking|Person|Rad|Radfahren|Radfahrer|Radfahrerin|Sport|Tour de France Frau|Frauensymbol|weiblich|Zeichen
🤸‍♂️|Akrobatik|Bodenturnen|Gymnastik|Person|Rad|Rad schlagen|Rad schlagende Person|Radschlag|Sport|Turner|Turnerin Mann|Männersymbol|Symbol|Zeichen
🤸‍♀️|Akrobatik|Bodenturnen|Gymnastik|Person|Rad|Rad schlagen|Rad schlagende Person|Radschlag|Sport|Turner|Turnerin Frau|Frauensymbol|weiblich|Zeichen
🤼‍♂️|Catchen|Catcher|Person|ringen|Ringer|Ringer(in)|Ringkampf|Sport|Sportler|Wrestler|Wrestling Mann|Männersymbol|Symbol|Zeichen
🤼‍♀️|Catchen|Catcher|Person|ringen|Ringer|Ringer(in)|Ringkampf|Sport|Sportler|Wrestler|Wrestling Frau|Frauensymbol|weiblich|Zeichen
🤽‍♂️|Person|Schwimmsport|Sport|Sportler|Sportlerin|Wasser|Wasserball|Wasserballspieler|Wasserballspieler(in)|Wasserballspielerin|Wassersport Mann|Männersymbol|Symbol|Zeichen
🤽‍♀️|Person|Schwimmsport|Sport|Sportler|Sportlerin|Wasser|Wasserball|Wasserballspieler|Wasserballspieler(in)|Wasserballspielerin|Wassersport Frau|Frauensymbol|weiblich|Zeichen
🤾‍♂️|Handball|Handballer|Handballerin|Handballspieler|Handballspieler(in)|Handballspielerin|Person|schleudern|Sport|Sportler|werfen Mann|Männersymbol|Symbol|Zeichen
🤾‍♀️|Handball|Handballer|Handballerin|Handballspieler|Handballspieler(in)|Handballspielerin|Person|schleudern|Sport|Sportler|werfen Frau|Frauensymbol|weiblich|Zeichen
🤹‍♂️|Artist|Artistin|geschickt|Jongleur|Jongleur(in)|Jongleurin|Jongleuse|jonglieren|Multitasking|Person|Zirkus Mann|Männersymbol|Symbol|Zeichen
🤹‍♀️|Artist|Artistin|geschickt|Jongleur|Jongleur(in)|Jongleurin|Jongleuse|jonglieren|Multitasking|Person|Zirkus Frau|Frauensymbol|weiblich|Zeichen
🧘‍♂️|burmesischer Sitz|Frau|Lotussitz|Meditation|Person|Person im Lotossitz|Person in Lotussitz|Schneidersitz|Yoga|Zen Mann|Männersymbol|Symbol|Zeichen
🧘‍♀️|burmesischer Sitz|Frau|Lotussitz|Meditation|Person|Person im Lotossitz|Person in Lotussitz|Schneidersitz|Yoga|Zen Frau|Frauensymbol|weiblich|Zeichen
🎪|Unterhaltung|Zelt|Zirkus|Zirkuszelt
🛹|Board|Brett|Räder|Skateboard|Skateboard fahren|skaten|Skater
🎗️|Gedenkschleife|Schleife
🎟️|Billet|Eintrittskarte|Eintrittskarten|Ticket
🎫|Konzert|Ticket|Unterhaltung
🎖️|Militärorden|Orden
🏆|Bundesliga|Champion|gewinnen|Pokal|Preis|Sieger|Sport|Trophäe
🏅|Gewinn|Goldmedaille|Medaille|Sportmedaille
🥇|Erster|Gewinn|Goldmedaille|Medaille 1. Platz
🥈|Medaille 2. Platz|Silbermedaille|Zweiter
🥉|Bronzemedaille|Dritter|Medaille 3. Platz
⚽|Ball|Bundesliga|Fußball|Messi
⚾|Ball|Baseball
🥎|Ball|Baseball|Handschuh|Softball|Sport|Unterarm|werfen
🏀|Ball|Basketball|Korb|Sport
🏐|Ball|Sport|Volleyball
🏈|American Football|Amerika|Ball|Football|Sport|Super Bowl
🏉|Ball|Rugby|Rugbyball|Sport
🎾|Ball|Sport|Tennis|Tennisball
🥏|Disc|Disk|fliegende Untertasse|Frisbee|Scheibe|Ultimate
🎳|Bowling|Bowlingkugel|Kugel|Spiel
🏏|Ball|Cricket|Kricket|Schläger
🏑|Feldhockey|Hockey|Schläger
🏒|Eishockey|Eishockey-Schläger und Puck|Hockey|Puck|Schläger
🥍|Ball|Lacrosse|Schläger|Sport|Stick|Stock|Tor
🏓|Ball|Ping Pong|Schläger|Spiel|Sport|Tischtennis
🏸|Badminton|Federball|Schläger
🪃|Aborigines|Australien|Boomerang|Bumerang|Schleuder|Waffe|werfen
🥅|Fußball|Netz|Sport|Tor
⛳|Golffahne|Golfplatz
🪁|Drachen|fliegen|hochfliegen|steigen|Wind
🛝|Rutschbahn|Rutsche|spielen|Spielplatz|Spielplatzrutsche|Vergnügungspark
🏹|Bogen|Pfeil|Pfeil und Bogen
🎣|Angel mit Fisch|Angeln|Entspannung
🤿 |schnorcheln|schwimmen|Sport|Sporttauchen|tauchen|Tauchmaske
🥊|Boxen|Boxhandschuh|Handschuh|Sport
🥋|Judo|Kampfkunst|Kampfsport|Kampfsportanzug|Karate|Taekwondo
🎽|Laufen|Laufshirt|Laufshirt mit Schärpe|Schärpe|Sport
🛼|Rollen|Rollerskate|Rollschuh|Rollschuh laufen|Schuh|Sport
🛷|Rodel|Rodeln|Schlitten|Schnee
⛸️|Eislauf|Schlittschuh
🥌|Curlingstein|Spiel|Sport|Stein
🎿|Ski|Ski und Stöcke
🎯|Dart|Darts|Pfeil|Spiel|Volltreffer|Zielscheibe
🎱|8-Ball|Billard|Billardkugel|Kugel|schwarz|Spiel
🎮|Gamepad|Gaming|Unterhaltung|Videospiel
🎰|Glücksspiel|Spiel|Spielautomat
🎲|Casino|Spiel|Spielwürfel|Unterhaltung|Würfel|würfeln|Zufall
🧩|Bestandteile|Hinweise|Hobby|passen|puzzeln|Puzzle|Puzzlestück|Puzzleteil|Puzzleteile|Spiel|Teile|zusammenpassen|zusammensetzen
♟️|Bauer Schach|Schach
🎭|Kunst|Masken|Theater|Unterhaltung
🎨|Farben|Kunst|Künstler|Mischpalette|Palette
🎼|Musik|Noten|Notenschlüssel|Partitur|Violinschlüssel
🎤|Karaoke|Mikrofon|Singen|Unterhaltung
🎧|Kopfhörer|Musik|Unterhaltung
🎷|Instrument|Musik|Musikinstrument|Saxofon
🎸|Gitarre|Instrument|Musik|Musikinstrument
🎹|Instrument|Klaviatur|Klavier|Musik|Musikinstrument|Piano|Tastatur|Tasten
🎺|Instrument|Musik|Musikinstrument|Trompete
🎻|Geige|Instrument|Musik|Musikinstrument|Violine
🥁|Drumsticks|Instrument|Musik|Schlägel|Sticks|Trommel|Trommelstöcke
🎬|Film|Filmklappe|Klappe|Unterhaltung
💌|Brief|Herz|Liebe|Liebesbrief|Post|Siegel
🕳️|Loch|schwarz
💣|Bombe|Comic|Dynamit|Explodieren
🛀|Bad|baden|badende Person|Badewanne|Badezimmer|Dusche|entspannen
🛌|Bett|gute Nacht|Heia|im Bett liegende Person|Im Bett liegende Person|müde|Nachtruhe|schlaf schön|schlafen|zzz
🏺|Amphore|Gefäß|kochen|Krug|Sternzeichen|Tierkreis|trinken|Vase|Wassermann
🗺️|Karte|Landkarte|reisen|Welt|Weltkarte
🧭|Himmelsrichtung|Kompass|magnetisch|Navigation|Orientierung|Richtung|Windrose
🧱|bauen|Grenze|Klinker|Mauer|Mauerwerk|Mörtel|Wand|Ziegel|Ziegelstein|Ziegelsteine|zugemauert
💈|Barbershop-Säule|Friseur|Herrenfriseur|Säule
🛢️|Fass|Öl|Ölfass
🛎️|Klingel|Rezeptionsklingel
⌛|Prozess|Sanduhr|Vorgang läuft|Zeit
⏳|laufende Sanduhr|Laufende Sanduhr|Prozess|Sanduhr|Vorgang läuft
⌚|Armbanduhr|Uhr|Zeit
⏰|Uhr|Uhrzeit|Wecker|Zeit
⏱️|Stoppuhr|Uhr|Zeit
⏲️|Timer|Uhr|Zeitschaltuhr
🕰️|Kaminuhr|tick tack|Uhr
🌡️|Temperatur|Thermometer|Wetter
🧨|Dynamit|Explosion|explosiv|Feuer|Feuerwerk|Feuerwerkskörper|Funken|Knall|knallen|Knaller|Kracher|Silvester|sprengen|Sprengstoff|Zündstoff
🎈|Ballon|Feier|Geburtstag|Luftballon
🎉|Böller|Feier|juhu|Knaller|Konfetti|Konfettibombe|Party|super|yay
🎊|Feier|Konfetti|Konfettiball|Party
🎎|japanische Puppen|Japanische Puppen|Puppenfest Japan
🎏|Feier|Karpfen|traditionelle japanische Windsäcke|Traditionelle japanische Windsäcke|Windsäcke
🎐|Bimmel|Feier|Glocke|japanisches Windspiel|Japanisches Windspiel|Wind
🪩|Disco|Discokugel|Lichtreflexe|Party|Spiegel|Spiegelkugel|Tanz|tanzen
🧧|Geld|Geschenk|Glück|Hong Bao|Hongbao|roter Umschlag
🎀|Feier|Geschenk|pink|rosa|Schleife
🎁|Feier|Geburtstag|Geschenk|Schachtel|Schleife|Überraschung|verpackt|Weihnachten
🔮|Kristallkugel|Wahrsager|Zukunft
🧿|Amulett|blau|böser Blick|Glasperle|Glücksbringer|Kügelchen|Nazar|Nazar-Amulett|Perle|Talisman
🪬|Amulett|Auge in offener Hand|Fatima|Glückssymbol|Hamsa|Hand|jüdisch|Maria|muslimisch|Schutz
🕹️|Gaming|Joystick|Videospiel
🧸|Bär|Kuscheltier|Plüschteddy|Plüschtier|Spielwaren|Spielzeug|Stoffbär|Stofftier|Teddy|Teddybär
🖼️|Bild|Gemälde|gerahmtes Bild|Kunst|malen|Rahmen|zeichnen|Zeichnung
🛍️|einkaufen|Einkaufen|Einkaufstüten|shoppen|Shopping|Tasche|Tüte
📿|beten|Gebet|Gebetskette|Kette|Religion|Rosenkranz
💎|Diamant|Edelstein
📯|Brief|E-Mail|Post|Posthorn
🎙️|Mikrofon|Studiomikrofon
🎚️|Musik|Schieberegler
🎛️|Bedienknöpfe|Drehregler|Knöpfe|Stellknöpfe
📻|Musik|Radio
📱|Handy|iPhone|Mobiltelefon|Smartphone|telefonieren
📲|Anruf|Anrufen|Handy|iPhone|Kommunikation|Mobiltelefon|Mobiltelefon mit Pfeil|Pfeil|WhatsApp
☎️|Anruf|anrufen|Festnetz|Telefon
📞|anrufen|Hörer|Kommunikation|Telefon|Telefonhörer
📟|Kommunikation|Pager|Piepser
📠|Fax|Faxgerät|Kommunikation
🔋|Akku|Batterie
🪫|Akku|Akku fast leer|Akku leer|aufladen|Batterie|Batterie fast leer|Batterie leer|Elektronik|Ladestand|niedriger Akkustand|schwache Batterie|schwacher Akku
🔌|Netzstecker|Stecker|Stromstecker
💻|Bildschirm|Computer|Computermonitor|Laptop|Monitor|Notebook|PC
🖥️|Bildschirm|Computer|Desktop|Desktopcomputer|iMac|Monitor
🖨️|Computer|Drucker
⌨️|Computer|Keyboard|Tastatur
🖱️|Computer|Computermaus|Maus
🖲️|Computer|Trackball
💽|MD|Minidisc|Minidisk
💾|Datenträger|Diskette
💿|Blu-Ray|CD|DVD
📀|blu-ray|CD|computer|DVD
🧮|Abaki|Abakus|Abakusse|Berechnung|Kalkulation|Mathe|Mathematik|Rechenhilfe|Rechenrahmen|Rechenschieber|Rechnen|zählen|Zählrahmen
🎥|Film|Filmkamera|Kino|Unterhaltung
🎞️|Film|Filmband|Filmstreifen|Kino
📽️|Filmprojektor|Kino|Unterhaltung
📺|Fernsehen|Fernseher|Film|TV
📷|Fotoapparat|Fotos|Kamera
📸|Blitz|Fotoapparat|Fotoapparat mit Blitz
📹|filmen|Videokamera|Videos
📼|vhs|Video|Videokassette
🔍|Lupe nach links|Suche|Vergrößerungsglas
🔎|Lupe|Lupe nach rechts|Suche|Vergrößerungsglas
🕯️|Kerze|Licht
💡|Glühbirne|hell|Idee|Lampe|Licht
🔦|Lampe|Licht|Taschenlampe
🏮|Izakaya|Japanische Laterne|japanisches Lokal|rote Papierlaterne
📔|Einband|Notizbuch|Notizbuch mit dekorativem Einband
📕|Buch|geschlossen|geschlossenes Buch|Geschlossenes Buch
📖|Bibliothek|blättern|Buch|geöffnet|lernen|lesen|offen|offenes Buch|Offenes Buch|Seite
📗|Buch|grün|grünes Buch|Grünes Buch|lesen
📘|blau|blaues Buch|Blaues Buch|Buch
📙|Buch|orangefarben|orangefarbenes Buch|Orangefarbenes Buch
📚|Bücher|Bücherstapel|Fantasie|lesen|Roman
📓|Notizbuch|Notizen
📃|Dokument|Papier|Seite|teilweise eingerolltes Blatt|Teilweise eingerolltes Blatt
📜|Papier|Schriftrolle
📄|Dokument|Papier|Seite|Vorderseite eines Blattes
📰|Medien|Nachrichten|Presse|Zeitung
🗞️|Zeitung|zusammengerollt|zusammengerollte Zeitung|Zusammengerollte Zeitung
📑|Notizen|Pagemarker
🔖|Etikett|Lesen|Lesezeichen
🏷️|Etikett|Label|Marke
💰|Geld|Geldsack|Moneten|reich|Sack
💴|Geld|Geldschein|Yen|Yen-Banknote
💵|Dollar|Dollar-Banknote|Geld|Geldschein|Währung
💶|Euro|Euro-Banknote|Euroschein|Geld|Geldschein
💷|Geld|Geldschein|Pfund|Pfund-Banknote
💸|Bank|Euro|Geld|Geldschein mit Flügeln|Knete|Moneten
💳|Bankkarte|EC-Karte|Geldkarte|Guthaben|Karte|Kreditkarte
🪪|Ausweis|Dokument|Führerschein|Karte|Pass|Personalausweis|Plakette|Reisepass
🧾|Abrechnung|Aufstellung|Beleg|Blatt|Buchhalter|Buchhaltung|Quittung|Rechnung|Rechnungswesen|Schriftstück
✉️|Brief|Briefumschlag|E-Mail
📧|Brief|E-Mail|E-Mail-Symbol|Post
📨|E-Mail|eingehender Briefumschlag|empfangen|Umschlag
📩|E-Mail|gesendet|Umschlag mit Pfeil
📤|Ablage|E-Mail|Postausgang
📥|Ablage|E-Mail|Posteingang
📦|Päckchen|Paket
📫|Briefkasten|E-Mail|geschlossen|geschlossener Briefkasten mit Post|Geschlossener Briefkasten mit Post|Post
📪|Briefkasten|geschlossen|geschlossener Briefkasten ohne Post|Geschlossener Briefkasten ohne Post|keine E-Mail|keine Post|Post
📬|Briefkasten|E-Mail|offen|offener Briefkasten mit Post|Offener Briefkasten mit Post|Post
📭|Briefkasten|keine E-Mail|keine Post|offen|offener Briefkasten ohne Post|Post
📮|Brief|Briefkasten|Post
🗳️|Urne|Urne mit Wahlzettel|Wahlen|Wahlzettel
✏️|Bleistift|Stift
✒️|Federhalter|Füller|schwarz|schwarzer Federhalter|Schwarzer Federhalter|Stift
🖋️|Füller|Füllfedehalter|Füllfederhalter|Füllhalter|schreiben|Stift
🖊️|Kugelschreiber|Stift
🖌️|Kunst|malen|Pinsel
🖍️|Buntstift|Filzstift|Wachsmalstift
📝|Bleistift|Kurzmitteilung|Nachricht|Notiz|Papier|Papier und Bleistift|Schreibblock|schreiben
📁|Akten|Büro|Dokument|geschlossen|Ordner
📂|Dokument|geöffneter Ordner|Geöffneter Ordner|offen|Ordner
🗂️|Akten|Büro|Büroausstattung|Büromaterial|Karteibahnen|Karteikarten|Karteireiter
📅|Datum|Kalender|Kalenderblatt
📆|Abreißkalender|Datum|Kalender|Termin
🗒️|Block|Notiz|Notizblock|Papier
🗓️|Kalender|Spiralkalender
📇|Rotationskartei|Visitenkarten
📈|Aufwärtstrend|Diagramm|Kurve|steigend
📉|Abwärtstrend|Diagramm|fallend|Kurve
📊|Balken|Balkendiagramm|Diagramm
📋|Clipboard|Clpboard|Klemmbrett|Zwischenablage
📌|anpinnen|Reißzwecke
📍|anpinnen|Reißzwecke|rund|runde Reißzwecke|Stecknadel
📎|Büroklammer
🖇️|Büroklammer|Büroklammern|verhakt|verhakte Büroklammern|Verhakte Büroklammern
📏|Lineal
📐|dreieckiges Lineal|Dreieckiges Lineal|Geodreieck|Lineal
✂️|Schere|schneiden|schnipp
🗃️|Büroausstattung|Büromaterial|Karteikasten
🗄️|Ablage|Aktenschrank|Archiv|Schublade
🗑️|Abfalleimer|Papierkorb
🔒|Datenschutz|geschlossen|geschlossenes Schloss|Geschlossenes Schloss|Schloss|Sicherheit
🔓|nicht gesichert|offen|offenes Schloss|Offenes Schloss|Schloss
🔏|Datenschutz|privat|Schloss mit Füller|Sicherheit
🔐|Datenschutz|privat|Schloss mit Schlüssel|Sicherheit
🔑|Passwort|schließen|Schlüssel
🗝️|alt|alter Schlüssel|Alter Schlüssel|Schloss|Schlüssel
🔨|Hammer|Werkzeug
⛏️|Pickel|Werkzeug
⚒️|Arbeiter|Hammer|Hammer und Pickel|Pickel|Werkzeug
🛠️|Hammer|Hammer und Schraubenschlüssel|Schraubenschlüssel|Werkzeug
🔪|Küchenmesser|Messer|schneiden
🗡️|Dolch|Schwert|Waffe
⚔️|gekreuzt|gekreuzte Schwerter|Gekreuzte Schwerter|Schwerter|Waffe
🔫|Pistole|Revolver|Waffe|Wasserpistole
🛡️|Schild|Schutzschild
🔧|Schraubenschlüssel|Werkzeug
🔩|Mutter und Schraube|Schraube
⚙️|Werkzeug|Zahnrad
🗜️|Schraubzwinge|Werkzeug
⚖️|Gerechtigkeit|Gewicht|Waage|Werkzeug|wiegen
🔗|Kettenglieder|Linksymbol|verknüpfen|Verknüpfung|Verknüpfungssymbol|zwei Ringe
⛓️|Eisen|Kette|Ketten
🧰|Box|Handkasten|Kasten|Kiste|Mechaniker|rote Kiste|Werkzeug|Werkzeugkasten|Werkzeugkiste|Werkzeugkoffer
🧲|Anziehung|Anziehungskraft|Hufeisen|Magnet|magnetisch|Pole|positiv negativ|U-Form
⚗️|Destillierapparat|Werkzeug
🧪|Chemie|Chemikalie|Chemiker|Experiment|Labor|Reagenzglas|Substanz|Versuche|Wissenschaft
🧫|Bakterien|Bakterienkultur|Biologe|Biologie|Biologin|Kultur|Labor|Petrischale|Pipette|Probe
🧬|Biologe|Biologie|Biologin|DNA|DNS|Evolution|Gen|Genetik|Genmanipulation|Leben
🔬|Labor|Mikroskop|untersuchen|Wissenschaft
🩻|durchleuchten|Knochen|Medizin|Radiologie|Rippen|Röntgen|Röntgenbild|Röntgenstrahlen|Skelett
🔭|Himmel|Teleskop
📡|Antenne|Sat-Schüssel|Satellitenschüssel|Satschüssel|Schüssel
💉|Arzt|impfen|Impfung|Injektion|Kanüle|Nadel|Spritze
💊|Arznei|Arzt|Kapsel|Medizin|Pille|Tabletten
🚪|Eingang|geschlossen|Tür
🛏️|Bett|Hotel|schlafen|Übernachtung
🛋️|Couch|Lampe|Sofa|Sofa und Lampe
🚽|Klo|Toilette|WC
🚿|Dusche|Duschkopf
🛁|Bad|Badewanne|Badezimmer|Dusche
🧴|Creme|Feuchtigkeitscreme|Feuchtigkeitsmilch|Haarwaschmittel|Körpercreme|Lotion|Nachtcreme|Shampoo|Sonnencreme
🧷|Punk|Sicherheitsnadel|Windel
🧹|Besen|fegen|Fegen|Hexe|Hexenbesen|kehren|Kehren|reinigen|sauber machen|säubern
🧺|Bauernhof|Korb|Landwirtschaft|Picknick|Tragekorb|Wäsche|Wäschekorb
🧻|Hygiene|Klopapier|Küchenrolle|Papierrolle|Papiertücher|Toilette|Toilettenpapier|WC|WC-Papier
🧼|baden|Baden|putzen|reinigen|Riegel|sauber|sauber machen|säubern|Schaum|schäumen|Seife|Seifenschale|Seifenstück
🧽|absorbieren|aufsaugen|löchrig|porös|putzen|Putzmittel|reinigen|sauber machen|Schaum|schäumen|Schwamm
🧯|Feuer|Feuerlöscher|löschen
🚬|Kippe|Rauchen|Rauchersymbol|Zigarette
⚰️|Beerdigung|Sarg|Tod|tot|Vampir
⚱️|Beerdigung|Tod|tot|Urne
🚰|Trinkwasser|Wasser|Wasserhahn
💘|Herz|Herz mit Pfeil|Liebe|Pfeil
💝|Herz|Hochzeitstag|Jahrestag|Küsschen|Küsse|Liebe|Schleife|Valentinstag|xoxo
💖|Aufregung|funkeln|Gefühl|glitzern|Herz|Liebe|Morgen|Nacht|rosa|xoxo
💗|Aufregung|Gefühl|Herz|Herzschlag|Küsschen|Küsse|Liebe|nervös|Nervosität|Puls|wachsen|xoxo
💓|Gefühl|Herz|Herzschlag|Liebe|Puls|pulsieren|schlagen
💞|Emotion|Gefühl|Herz|Herzen|Hochzeitstag|Jahrestag|kreisen|Liebe|süß
💕|Date|Gefühl|Herz|Herzen|Hochzeitstag|Jahrestag|Küsschen|Küsse|Liebe|Rendezvous|xoxo|zwei
💟|Deko|Emotion|Gefühl|Herz|Herzdekoration|Liebe|lila|violett|weiß
❣️|Ausrufezeichen|Herz|Herz als Ausrufezeichen|Satzzeichen
💔|allein|gebrochen|Gefühl|Herz|Herzschmerz|Liebeskummer|Schmerz|traurig|Trennung|zerbrochen
❤️‍🔥|emotion|Herz|Feuer|feurig|Liebe|rot
❤️|Herz|rotes Herz
🧡|Herz|Liebe|orange
💛|Gefühl|gelb|Herz|herzlich|Liebe
💚|Gefühl|grün|Herz|Liebe|romantisch
💙|blau|Gefühl|Herz|Liebe|romantisch
💜|beste|Gefühl|hdl|Herz|Liebe|lila|lilafarben|violett
🖤|böse|Herz|schwarz|schwarzes Herz
💯|100|100 Punkte|Punktestand|volle Punktzahl
💢|Ärger|Comic|Wut
💬|Comic|Dialog|Gespräch|Sprechblase|Sprechblase mit drei Punkten|Unterhaltung
👁️‍🗨️|Auge|Blick|Körper|Körperteil|schauen|sehen Dialog|reden|Sprechblase links|sprechen|Unterhaltung
🗯️|Sprechblase|Sprechblase für wütende Aussage rechts|wütend
💭|Comic|Gedankenblase|Nachdenken
💤|Buchstaben|Comic|gähn|langweilig|müde|Nickerchen|öde|Schlaf|Schlafen|Schnarchen|ZZZ
♨️|Dampf|dampfend|heiß|heiße Quelle|heiße Quellen|Quelle|Quellen
🛑|achteckig|Schild|Stopp|Stoppschild
🕛|0 Uhr|12|12
🕧|00
🕐|01
🕜|1 Uhr 30|1
🕑|2|2
🕝|2
🕒|3|3
🕞|3
🕓|4|4
🕟|04
🕔|05
🕠|05
🕕|6|6
🕡|6
🕖|7|7
🕢|7
🕗|8|8
🕣|8
🕘|9|9
🕤|9
🕙|10|10
🕥|10
🕚|11|11
🕦|11
🌀|Spirale|Wirbel|Wirbelsturm
♠️|Karten|Kartenspiel|Pik
♥️|Herz|Kartenspiel
♦️|Karo|Kartenspiel
♣️|Kartenspiel|Kreuz
🃏|Joker|Jokerkarte|Spielkarte
🀄|Mahjong|Mahjong-Stein|roter Drache|Spiel
🎴|Blume|Blumenkarte|Hanafuda|Japan|japanische Blumenkarte|Japanische Blumenkarte|Karte
🔇|durchgestrichener Lautsprecher|Durchgestrichener Lautsprecher|leise|psst|stumm|stummgeschaltet
🔈|eingeschaltet|Lautsprecher mit geringer Lautstärke|Ton an
🔉|Lautsprecher mit einer Schallwelle|Lautsprecher mit mittlerer Lautstärke|leise|mittellaut|Ton
🔊|Dezibel|laut|Lautsprecher mit drei Schallwellen|Lautsprecher mit hoher Lautstärke|Musik|Schallwellen
📢|Lautsprecher|Megafon|Schallendes Megafon
📣|Jubel|Lautsprecher|Megafon
🔔|ding dong|Glocke|Klingeling|Ton eingeschaltet
🔕|durchgestrichene Glocke|Durchgestrichene Glocke|Glocke|kein ton|leise|Ton ausgeschaltet
🎵|Lied|Melodie|Musik|Musiknote|Note
🎶|Musik|Musiknoten|Noten
🏧|ATM|Geldautomat|Symbol „Geldautomat“
🚮|Abfall|Müll|Mülleimer|Sauberkeit|Symbol „Papierkorb“|wegschmeißen|wegwerfen
♿|barrierefrei|behindertengerecht|Rollstuhl|Symbol „Rollstuhl“
🩼|Behinderung|Beinverletzung|Fußverletzung|Gehhilfe|Gehstütze|Hilfe|Krücke|Schmerzen|Stock|verletzt|Verletzung
🚹|Herren|Herrentoilette|WC
🚺|Damen|Damentoilette|WC
🚻|Toilette|Toiletten|WC
🚼|Baby|Symbol „Baby“|Wickelraum
🚾|Toilette|WC
⚠️|Achtung|Dreieck|Vorsicht|Warnschild|Warnung
🚸|Kinder|Kinder überqueren die Straße|Kinder-queren-die-Straße-Schild|Straßenschild|Vorsicht
⛔|Einbahnstrasse|kein Zutritt|keine Durchfahrt|verboten|Zutritt verboten|Zutritt-verboten-Schild
🚫|kein zutritt|Kein-Zutritt-Zeichen|Verboten|Verbotszeichen
🚳|Fahhrad|Fahrrad-verboten-Schild|Fahrräder verboten|Radfahren verboten|verboten
🚭|Rauchen verboten|Rauchverbot|Zigarette
🚯|Abfall|Müll|Müll-verboten-Zeichen|verboten
🚱|kein Trinkwasser|Kein Trinkwasser|verboten|verschmutzt|Wasser
🚷|Fußgänger verboten|Fußgänger-verboten-Schild|verboten
🔞|Erwachsene|Minderjährige verboten|Mindestalter|nicht jugendfrei|Zeichen mit durchgestrichener 18
☢️|radioaktiv|Radioaktiv
☣️|Biogefährdung|Zeichen
⬆️|aufwärts|Aufwärtspfeil|nach oben|Norden|Pfeil|Pfeil nach oben
↗️|nach rechts oben|Nordosten|Pfeil|Pfeil nach rechts oben
➡️|nach rechts|Osten|Pfeil|Pfeil nach rechts|rechts|Rechtspfeil
↘️|nach rechts unten|Pfeil|Pfeil nach rechts unten|Südosten
⬇️|abwärts|Abwärtspfeil|nach unten|Pfeil|Pfeil nach unten|Süden
↙️|nach links unten|Pfeil|Pfeil nach links unten
⬅️|Linkspfeil|nach links|Pfeil|Pfeil nach links|Westen
↖️|nach links oben|Nordwesten|Pfeil|Pfeil nach links oben
↕️|entgegengesetzt|nach oben und unten|Pfeil|Pfeil nach oben und unten
↔️|entgegengesetzt|nach links und rechts|Pfeil|Pfeil nach links und rechts
↩️|geschwungen|geschwungener Pfeil nach links|Geschwungener Pfeil nach links|links|nach links|Pfeil
↪️|geschwungen|nach rechts|Pfeil|rechts|umdrehen
⤴️|geschwungen|nach oben|oben|Pfeil
⤵️|geschwungen|nach unten|Pfeil|unten
🔃|im Uhrzeigersinn|kreisförmige Pfeile im Uhrzeigersinn|Kreisförmige Pfeile im Uhrzeigersinn|Pfeile
🔄|gegen den Uhrzeigersinn|kreisförmige Pfeile gegen den Uhrzeigersinn|Kreisförmige Pfeile gegen den Uhrzeigersinn|Pfeile|Pfeile gegen den Uhrzeigersinn
🔙|BACK-Pfeil|links|Pfeil|zurück
🔚|END-Pfeil|Ende-Zeichen|links|Pfeil
🔛|anschalten|Ein-Zeichen|einschaltem|ON!-Pfeil|Pfeil|rechts und links
🔜|Bald-Zeichen|Pfeil|rechts|SOON-Pfeil
🔝|Pfeil nach oben|TOP-Pfeil|Top-Zeichen
🛐|Kultstätte|Religion|religiöse Stätte
⚛️|Atheist|Atom|Atomzeichen
🕉️|Hinduismus|om|Religion
✡️|Davidstern|jüdisch|Religion
☸️|Buddhismus|Dharma|Dharma-Rad
☯️|Daoismus|Religion|Yang|Yin|Yin und Yang
✝️|Christentum|Kreuz|lateinisch|Religion|römisch
☦️|Christentum|Kreuz|orthodox|Religion
☪️|Hilal|Islam|Muslim|Religion|Stern
☮️|Friedensbewegung|Friedenssymbol|Friedenszeichen
🕎|Leuchter|Menora|Religion
🔯|Hexagramm mit Punkt|Wahrsager
♈|Sternzeichen|Widder|Widder (Sternzeichen)
♉|Horoskop|Sternzeichen|Stier
♊|Horoskop|Sternzeichen|Zwilling|Zwillinge|Zwillinge (Sternzeichen)
♋|Krebs|Krebs (Sternzeichen)|Sternzeichen
♌|Horoskop|Löwe|Löwe (Sternzeichen)|Sternzeichen
♍|Horoskop|Jungfrau|Jungfrau (Sternzeichen)|Sternzeichen
♎|Horoskop|Sternzeichen|Waage|Waage (Sternzeichen)
♏|Horoskop|Skorpion|Skorpion (Sternzeichen)|Sternzeichen
♐|Schütze|Schütze (Sternzeichen)|Sternzeichen
♑|Steinbock|Steinbock (Sternzeichen)|Sternzeichen
♒|Sternzeichen|Wassermann|Wassermann (Sternzeichen)
♓|Fische|Fische (Sternzeichen)|Horoskop|Sternzeichen
⛎|Schlagenträger|Schlangenträger|Sternbild
🔀|gekreuzt|Pfeile|Richtung|verschlungene Pfeile nach rechts|Verschlungene Pfeile nach rechts|Zufallsmodus
🔁|im Uhrzeigersinn|keycap|Pfeile|tastenkappe|wiederholen|Wiederholen
🔂|dasselbe wiederholen|einmal|im Uhrzeigersinn|noch einmal|Pfeile|Titel wiederholen|wiederholen
▶️|abspielen|Dreieck|Pfeil|rechts|Wiedergabe
⏩|Doppelpfeil|Doppelpfeile nach rechts|überspringen|vorwärts|weiter
◀️|Dreieck|links|Pfeil|zurück
⏪|Doppelpfeil|Doppelpfeile nach links|Dreieck|Pfeil|vorheriger Titel|zurück|Zurückspulen
🔼|aufwärts|Aufwärts-Schaltfläche|nach oben|Pfeil|Schaltfläche
⏫|aufwärts|Doppelpfeil|Doppelpfeile nach oben|doppelt|nach oben|Pfeil
🔽|abwärts|Abwärts-Schaltfläche|nach unten|Pfeil|Schaltfläche
⏬|Doppelpfeil|Doppelpfeile nach unten|doppelt abwärts|nach unten|Pfeil
⏹️|Aufnahme stoppen|keycap|Quadrat|Stopp|Tastenkappe
⏏️|Auswerfen|Auswurf|Auswurftaste|Medien
🎦|Film|Filmkamera|Filmkamera in blauem Quadrat|Kino|Kinosymbol|Unterhaltung
🔅|dimmen|gedimmt|Helligkeit|schwache Helligkeit|Schwache Helligkeit|Taste Dimmen
🔆|heller|Heller-Taste|Helligkeit|starke Helligkeit|Starke Helligkeit
📶|balkenförmige Signalstärkenanzeige|Balkenförmige Signalstärkenanzeige|Empfang|Mobilfunksignal|Mobiltelefon|Signalstärke
📳|Handy|Kommunikation|Mobiltelefon|Symbol für Vibrationsalarm|Vibration|Vibrationsmodus|vibrieren
📴|ausschalten|Handy aus|Mobiltelefon|Mobiltelefon aus
♾️|ewig|grenzenlos|unendlich|Unendlichkeit
♻️|grüne Punkt|grüner Punkt|Recycling|Recycling-Symbol
🔱|Anker|Dreizack|Poseidon|Triton
📛|Namensschild|Schild
🔰|Anfänger|japanisches Anfänger-Zeichen|Japanisches Anfänger-Zeichen|japanisches Symbol
⭕|großer Kreis|Großer Kreis|hohler roter Kreis|Kreis|o|rot
✅|abgehakt|erledigt|weißes Häkchen|Weißes Häkchen
☑️|✓|abgehaktes Kästchen|Abstimmungsfeld|Abstimmungsfeld mit Häkchen|ankreuz|Feld|Häkchen|Kästchen|Kästchen mit Häkchen|Wahlurne
✔️|abhaken|erledigt|fertig|Häkchen|Haken|kräftiges Häkchen
❌|abbrechen|durchgestrichen|Kreuzzeichen|mal|Multiplikation|multiplizieren|Rotes Kreuz|x
❎|angekreuztes Feld|angekreuztes Kästchen|Feld|Kreuz|Kreuzsymbol im Quadrat|Quadrat|X
➕|+|addieren|mathe|Plus|Pluszeichen
➖|-|−|Mathe|Minus|Minuszeichen
➗|÷|Division|Divisionszeichen|geteilt|geteilt durch|Geteiltzeichen|Mathe
✖️|×|abbrechen|mal|Multiplikation|Multiplikationszeichen|multiplizieren|x
🟰|gleich|Gleichheit|Gleichheitszeichen|Gleichheitszeichen extrafett|ist gleich|Mathematik|Vergleichszeichen
➰|Schleife
➿|blau|Doppelschleife|Rechteck|Schleife
〽️|japanisch|Teilalternationszeichen|Zeichensetzung
✳️|*|achtzackig|achtzackiger Stern|grün|Quadrat|Stern
✴️|*|achtstrahliger Stern|Stern
❇️|*|Funkeln|grün|Quadrat
‼️|Ausrufezeichen|doppelt|doppeltes Ausrufezeichen|Doppeltes Ausrufezeichen|muss|rot|Satzzeichen
⁉️|Ausrufe- und Fragezeichen|Ausrufezeichen|Fragezeichen|rot|Satzzeichen
❓|Frage|Fragezeichen|rot|rotes Fragezeichen|Rotes Fragezeichen|Satzzeichen|warum|wieso
❔|Frage|Fragezeichen|Satzzeichen|warum|weiß|weißes Fragezeichen
❕|Ausrufezeichen|muss|Satzzeichen|weiß|weißes Ausrufezeichen
❗|!|Ausrufezeichen|rot|Satzzeichen
©️|C|Copyright
®️|Markenzeichen|R|Registered-Trademark
™️|Markenzeichen|TM|Trademark
#️⃣|Keycap Number Sign
0️⃣|Keycap Digit Zero
1️⃣|Keycap Digit One
2️⃣|Keycap Digit Two
3️⃣|Keycap Digit Three
4️⃣|Keycap Digit Four
5️⃣|Keycap Digit Five
6️⃣|Keycap Digit Six
7️⃣|Keycap Digit Seven
8️⃣|Keycap Digit Eight
9️⃣|Keycap Digit Nine
🔟|Keycap: 10
🔠|abcd|Buchstaben|Eingabe|Eingabesymbol|Großbuchstaben|großschreiben|lateinisch
🔡|Eingabesymbol lateinische Kleinbuchstaben|Kleinbuchstaben|lateinische Kleinbuchstaben
🔢|1234|Eingabe|Eingabesymbol|Symbol|Zahlen|Ziffern
🔣|&|%|♪|〒|Eingabe|Eingabesymbol|keycap|Sonderzeichen|Symbol|Tastenkappe
🔤|abc|Alphabet|Buchstaben|Eingabe|Eingabesymbol|lateinisch|Symbol
🅰️|a|Blut|Blutgruppe|Großbuchstabe|negativ|positiv
🆎|ab|Blut|Blutgruppe|Großbuchstaben AB in rotem Quadrat|negativ|positiv
🅱️|b|Blut|Blutgruppe|Großbuchstabe|negativ|positiv
🆑|CL|Großbuchstaben CL in rotem Quadrat
🆒|Cool|Wort „Cool“ in blauem Quadrat
🆓|Free|Wort „Free“ in blauem Quadrat
ℹ️|Buchstabe „i“ in blauem Quadrat|i|Information
🆔|Großbuchstaben ID in lila Quadrat|ID
Ⓜ️|Buchstabe|eingekreist|Großbuchstabe|Kreis|M
🆕|Neu|New|Wort „New“ in blauem Quadrat
🆖|Großbuchstaben NG in blauem Quadrat|NG
🅾️|0|Blut|Blutgruppe|Großbuchstabe|negativ|O|positiv
🆗|Großbuchstaben|keycap|OK|okay|Taste|Tastenkappe
🅿️|Großbuchstabe|P|parken|Parkplatz|Taste
🆘|Hilfe|SOS|SOS-Zeichen
🆙|Keycap|Taste|Tastenkappe|UP|UP!
🆚|gegen|Taste|versus|VS
🈁|„koko“|japanisches Schriftzeichen|Schriftzeichen „koko“
🈂️|„sa“|japanisches Schriftzeichen|Schriftzeichen „sa“
🈷️|japanisch|monatlich|Monatsbetrag|Mond|Schriftzeichen|Taste
🈶|berechnen|existieren|japanisch|nicht gratis|Schriftzeichen|Taste
🈯|Finger|japanisches Schriftzeichen|reserviert|Schriftzeichen für „Finger“|Schriftzeichen für „reserviert“
🉐|japanisches Schriftzeichen|Schnäppchen|Schriftzeichen für „Schnäppchen“|Schriftzeichen für „Vorteil“|Vorteil
🈹|japanisches Schriftzeichen|Rabatt|Schriftzeichen für „Rabatt“|Schriftzeichen für „teilen“|teilen
🈚|gratis|japanisches Schriftzeichen|Schriftzeichen für „gratis“|Schriftzeichen für „Verhandlung“|Verhandlung
🈲|japanisches Schriftzeichen|Kanji|Schriftzeichen für „verbieten“|verbieten
🉑|akzeptieren|japanisch|Schriftzeichen
🈸|anwenden|chinesisches Schriftzeichen|japanisches Schriftzeichen|Schriftzeichen für „anwenden“
🈴|bestanden|bestehen|chinesisches Schriftzeichen|japanisches Schriftzeichen|Schriftzeichen für „Note zum Bestehen“|Schriftzeichen für „zusammen“|zusammen
🈳|chinesisches Schriftzeichen|japanisches Schriftzeichen|leer|Schriftzeichen für „leer“|Schriftzeichen für „Zimmer frei“|Zimmer frei
㊗️|chinesisches Schriftzeichen|Gratulation|japanisches Schriftzeichen|Schriftzeichen für „Gratulation“
㊙️|chinesisches Schriftzeichen|Geheimnis|japanisches Schriftzeichen|Japanisches Schriftzeichen|Schriftzeichen für „Geheimnis“
🈺|Betrieb|chinesisches Schriftzeichen|geöffnet|japanisches Schriftzeichen|Schriftzeichen für „Betrieb“|Schriftzeichen für „Geöffnet“
🈵|belegt|besetzt|chinesisches Schriftzeichen|Fülle|japanisches Schriftzeichen|Kanji|kein Zimmer frei|Schriftzeichen für „Fülle“|Schriftzeichen für „Kein Zimmer frei“
🔴|Ball|Großer roter Kreis|Kreis|Punkt|rot|roter Punkt
🔵|Ball|blau|blauer Punkt|Großer blauer Kreis|Kreis|Punkt
⚫|Ball|Großer schwarzer Kreis|Kreis|Punkt|rund|schwarz|schwarzer Punkt
⚪|Ball|Großer weißer Kreis|Kreis|Punkt|weiß|weißer Punkt
⬛|großes schwarzes Quadrat|Großes schwarzes Quadrat|Quadrat|schwarz
⬜|großes weißes Quadrat|Großes weißes Quadrat|Quadrat|weiß
◼️|mittelgroßes schwarzes Quadrat|Mittelgroßes schwarzes Quadrat|Quadrat|schwarz
◻️|mittelgroßes weißes Quadrat|Quadrat|weiß
◾|mittelkleines schwarzes Quadrat|Mittelkleines schwarzes Quadrat|Quadrat|schwarz
◽|geometrisch|mittelkleines weißes Quadrat|Mittelkleines weißes Quadrat|Quadrat|weiß
▪️|kleines schwarzes Quadrat|Kleines schwarzes Quadrat|Punkt|Quadrat|schwarz
▫️|kleines weißes Quadrat|Kleines weißes Quadrat|Quadrat|weiß
🔶|große orangefarbene Raute|Große orangefarbene Raute|orangefarben|Raute
🔷|blau|große blaue Raute|Große blaue Raute|Raute
🔸|kleine orangefarbene Raute|Kleine orangefarbene Raute|orangefarben|Raute
🔹|blau|kleine blaue Raute|Kleine blaue Raute|Raute
🔺|aufwärts|Dreieck|rot|rotes Dreieck mit der Spitze nach oben|Rotes Dreieck mit Spitze oben
🔻|abwärts|Dreieck|rot|rotes Dreieck mit der Spitze nach unten
💠|Diamant|mit Punkt|Rautenform|Rautenform mit Punkt
🔳|Quadrat|quadratisch|Schaltfläche|weiß|weiße quadratische Schaltfläche|Weiße quadratische Schaltfläche
🔲|quadratisch|Schaltfläche|schwarz|schwarze quadratische Schaltfläche|Schwarze quadratische Schaltfläche
🏁|Flagge|formel 1|karierte Flagge|nascar|Rennen|Sport|Zielflagge
🚩|Dreiecksflagge|Flagge|rot|Standortflagge|Wimpel
🎌|Japan|japanische Flaggen|überkreuzte Flaggen|Überkreuzte Flaggen
🏴|Fahne|schwarze Fahne|schwarze Flagge|wehen|Wehende schwarze Fahne
🏳️|Fahne|wehen|Wehende weiße Fahne|weiße Fahne|weiße Flagge
🏳️‍🌈|Fahne|wehen|Wehende weiße Fahne|weiße Fahne|weiße Flagge Regenbogen|Wetter
🏳️‍⚧️|Fahne|wehen|Wehende weiße Fahne|weiße Fahne|weiße Flagge Symbol für Transgender|Transgender|Transgender-Symbol
🏴‍☠️|Fahne|schwarze Fahne|schwarze Flagge|wehen|Wehende schwarze Fahne gekreuzt|Gesicht|Knochen|Piratenflagge|Schädel|Tod|tot|Totenkopf
🇦🇨|Flag: Ascension Island
🇦🇩|Flag: Andorra
🇦🇪|Flag: United Arab Emirates
🇦🇫|Flag: Afghanistan
🇦🇬|Flag: Antigua & Barbuda
🇦🇮|Flag: Anguilla
🇦🇱|Flag: Albania
🇦🇲|Flag: Armenia
🇦🇴|Flag: Angola
🇦🇶|Flag: Antarctica
🇦🇷|Flag: Argentina
🇦🇸|Flag: American Samoa
🇦🇹|Flag: Austria
🇦🇺|Flag: Australia
🇦🇼|Flag: Aruba
🇦🇽|Flag: Åland Islands
🇦🇿|Flag: Azerbaijan
🇧🇦|Flag: Bosnia & Herzegovina
🇧🇧|Flag: Barbados
🇧🇩|Flag: Bangladesh
🇧🇪|Flag: Belgium
🇧🇫|Flag: Burkina Faso
🇧🇬|Flag: Bulgaria
🇧🇭|Flag: Bahrain
🇧🇮|Flag: Burundi
🇧🇯|Flag: Benin
🇧🇱|Flag: St. Barthélemy
🇧🇲|Flag: Bermuda
🇧🇳|Flag: Brunei
🇧🇴|Flag: Bolivia
🇧🇶|Flag: Caribbean Netherlands
🇧🇷|Flag: Brazil
🇧🇸|Flag: Bahamas
🇧🇹|Flag: Bhutan
🇧🇻|Flag: Bouvet Island
🇧🇼|Flag: Botswana
🇧🇾|Flag: Belarus
🇧🇿|Flag: Belize
🇨🇦|Flag: Canada
🇨🇨|Flag: Cocos (Keeling) Islands
🇨🇩|Flag: Congo - Kinshasa
🇨🇫|Flag: Central African Republic
🇨🇬|Flag: Congo - Brazzaville
🇨🇭|Flag: Switzerland
🇨🇮|Flag: Côte d’Ivoire
🇨🇰|Flag: Cook Islands
🇨🇱|Flag: Chile
🇨🇲|Flag: Cameroon
🇨🇳|Flag: China
🇨🇴|Flag: Colombia
🇨🇵|Flag: Clipperton Island
🇨🇷|Flag: Costa Rica
🇨🇺|Flag: Cuba
🇨🇻|Flag: Cape Verde
🇨🇼|Flag: Curaçao
🇨🇽|Flag: Christmas Island
🇨🇾|Flag: Cyprus
🇨🇿|Flag: Czechia
🇩🇪|Flag: Germany
🇩🇬|Flag: Diego Garcia
🇩🇯|Flag: Djibouti
🇩🇰|Flag: Denmark
🇩🇲|Flag: Dominica
🇩🇴|Flag: Dominican Republic
🇩🇿|Flag: Algeria
🇪🇦|Flag: Ceuta & Melilla
🇪🇨|Flag: Ecuador
🇪🇪|Flag: Estonia
🇪🇬|Flag: Egypt
🇪🇭|Flag: Western Sahara
🇪🇷|Flag: Eritrea
🇪🇸|Flag: Spain
🇪🇹|Flag: Ethiopia
🇪🇺|Flag: European Union
🇫🇮|Flag: Finland
🇫🇯|Flag: Fiji
🇫🇰|Flag: Falkland Islands
🇫🇲|Flag: Micronesia
🇫🇴|Flag: Faroe Islands
🇫🇷|Flag: France
🇬🇦|Flag: Gabon
🇬🇧|Flag: United Kingdom
🇬🇩|Flag: Grenada
🇬🇪|Flag: Georgia
🇬🇫|Flag: French Guiana
🇬🇬|Flag: Guernsey
🇬🇭|Flag: Ghana
🇬🇮|Flag: Gibraltar
🇬🇱|Flag: Greenland
🇬🇲|Flag: Gambia
🇬🇳|Flag: Guinea
🇬🇵|Flag: Guadeloupe
🇬🇶|Flag: Equatorial Guinea
🇬🇷|Flag: Greece
🇬🇸|Flag: South Georgia & South Sandwich Islands
🇬🇹|Flag: Guatemala
🇬🇺|Flag: Guam
🇬🇼|Flag: Guinea-Bissau
🇬🇾|Flag: Guyana
🇭🇰|Flag: Hong Kong SAR China
🇭🇲|Flag: Heard & McDonald Islands
🇭🇳|Flag: Honduras
🇭🇷|Flag: Croatia
🇭🇹|Flag: Haiti
🇭🇺|Flag: Hungary
🇮🇨|Flag: Canary Islands
🇮🇩|Flag: Indonesia
🇮🇪|Flag: Ireland
🇮🇱|Flag: Israel
🇮🇲|Flag: Isle of Man
🇮🇳|Flag: India
🇮🇴|Flag: British Indian Ocean Territory
🇮🇶|Flag: Iraq
🇮🇷|Flag: Iran
🇮🇸|Flag: Iceland
🇮🇹|Flag: Italy
🇯🇪|Flag: Jersey
🇯🇲|Flag: Jamaica
🇯🇴|Flag: Jordan
🇯🇵|Flag: Japan
🇰🇪|Flag: Kenya
🇰🇬|Flag: Kyrgyzstan
🇰🇭|Flag: Cambodia
🇰🇮|Flag: Kiribati
🇰🇲|Flag: Comoros
🇰🇳|Flag: St. Kitts & Nevis
🇰🇵|Flag: North Korea
🇰🇷|Flag: South Korea
🇰🇼|Flag: Kuwait
🇰🇾|Flag: Cayman Islands
🇰🇿|Flag: Kazakhstan
🇱🇦|Flag: Laos
🇱🇧|Flag: Lebanon
🇱🇨|Flag: St. Lucia
🇱🇮|Flag: Liechtenstein
🇱🇰|Flag: Sri Lanka
🇱🇷|Flag: Liberia
🇱🇸|Flag: Lesotho
🇱🇹|Flag: Lithuania
🇱🇺|Flag: Luxembourg
🇱🇻|Flag: Latvia
🇱🇾|Flag: Libya
🇲🇦|Flag: Morocco
🇲🇨|Flag: Monaco
🇲🇩|Flag: Moldova
🇲🇪|Flag: Montenegro
🇲🇫|Flag: St. Martin
🇲🇬|Flag: Madagascar
🇲🇭|Flag: Marshall Islands
🇲🇰|Flag: North Macedonia
🇲🇱|Flag: Mali
🇲🇲|Flag: Myanmar (Burma)
🇲🇳|Flag: Mongolia
🇲🇴|Flag: Macau Sar China
🇲🇵|Flag: Northern Mariana Islands
🇲🇶|Flag: Martinique
🇲🇷|Flag: Mauritania
🇲🇸|Flag: Montserrat
🇲🇹|Flag: Malta
🇲🇺|Flag: Mauritius
🇲🇻|Flag: Maldives
🇲🇼|Flag: Malawi
🇲🇽|Flag: Mexico
🇲🇾|Flag: Malaysia
🇲🇿|Flag: Mozambique
🇳🇦|Flag: Namibia
🇳🇨|Flag: New Caledonia
🇳🇪|Flag: Niger
🇳🇫|Flag: Norfolk Island
🇳🇬|Flag: Nigeria
🇳🇮|Flag: Nicaragua
🇳🇱|Flag: Netherlands
🇳🇴|Flag: Norway
🇳🇵|Flag: Nepal
🇳🇷|Flag: Nauru
🇳🇺|Flag: Niue
🇳🇿|Flag: New Zealand
🇴🇲|Flag: Oman
🇵🇦|Flag: Panama
🇵🇪|Flag: Peru
🇵🇫|Flag: French Polynesia
🇵🇬|Flag: Papua New Guinea
🇵🇭|Flag: Philippines
🇵🇰|Flag: Pakistan
🇵🇱|Flag: Poland
🇵🇲|Flag: St. Pierre & Miquelon
🇵🇳|Flag: Pitcairn Islands
🇵🇷|Flag: Puerto Rico
🇵🇸|Flag: Palestinian Territories
🇵🇹|Flag: Portugal
🇵🇼|Flag: Palau
🇵🇾|Flag: Paraguay
🇶🇦|Flag: Qatar
🇷🇪|Flag: Réunion
🇷🇴|Flag: Romania
🇷🇸|Flag: Serbia
🇷🇺|Flag: Russia
🇷🇼|Flag: Rwanda
🇸🇦|Flag: Saudi Arabia
🇸🇧|Flag: Solomon Islands
🇸🇨|Flag: Seychelles
🇸🇩|Flag: Sudan
🇸🇪|Flag: Sweden
🇸🇬|Flag: Singapore
🇸🇭|Flag: St. Helena
🇸🇮|Flag: Slovenia
🇸🇯|Flag: Svalbard & Jan Mayen
🇸🇰|Flag: Slovakia
🇸🇱|Flag: Sierra Leone
🇸🇲|Flag: San Marino
🇸🇳|Flag: Senegal
🇸🇴|Flag: Somalia
🇸🇷|Flag: Suriname
🇸🇸|Flag: South Sudan
🇸🇹|Flag: São Tomé & Príncipe
🇸🇻|Flag: El Salvador
🇸🇽|Flag: Sint Maarten
🇸🇾|Flag: Syria
🇸🇿|Flag: Swaziland
🇹🇦|Flag: Tristan Da Cunha
🇹🇨|Flag: Turks & Caicos Islands
🇹🇩|Flag: Chad
🇹🇫|Flag: French Southern Territories
🇹🇬|Flag: Togo
🇹🇭|Flag: Thailand
🇹🇯|Flag: Tajikistan
🇹🇰|Flag: Tokelau
🇹🇱|Flag: Timor-Leste
🇹🇲|Flag: Turkmenistan
🇹🇳|Flag: Tunisia
🇹🇴|Flag: Tonga
🇹🇷|Flag: Turkey
🇹🇹|Flag: Trinidad & Tobago
🇹🇻|Flag: Tuvalu
🇹🇼|Flag: Taiwan
🇹🇿|Flag: Tanzania
🇺🇦|Flag: Ukraine
🇺🇬|Flag: Uganda
🇺🇲|Flag: U.S. Outlying Islands
🇺🇳|Flag: United Nations
🇺🇸|Flag: United States
🇺🇾|Flag: Uruguay
🇺🇿|Flag: Uzbekistan
🇻🇦|Flag: Vatican City
🇻🇨|Flag: St. Vincent & Grenadines
🇻🇪|Flag: Venezuela
🇻🇬|Flag: British Virgin Islands
🇻🇮|Flag: U.S. Virgin Islands
🇻🇳|Flag: Vietnam
🇻🇺|Flag: Vanuatu
🇼🇫|Flag: Wallis & Futuna
🇼🇸|Flag: Samoa
🇽🇰|Flag: Kosovo
🇾🇪|Flag: Yemen
🇾🇹|Flag: Mayotte
🇿🇦|Flag: South Africa
🇿🇲|Flag: Zambia
🇿🇼|Flag: Zimbabwe
''',
  'en': r'''
😀|cheerful|cheery|face|grin|grinning|happy|laugh|nice|smile|smiling|teeth
😃|awesome|big|eyes|face|grin|grinning|happy|mouth|open|smile|smiling|teeth|yay
😄|eye|eyes|face|grin|grinning|happy|laugh|lol|mouth|open|smile|smiling
😁|beaming|eye|eyes|face|grin|grinning|happy|nice|smile|smiling|teeth
😆|closed|eyes|face|grinning|haha|hahaha|happy|laugh|lol|mouth|open|rofl|smile|smiling|squinting
😅|cold|dejected|excited|face|grinning|mouth|nervous|open|smile|smiling|stress|stressed|sweat
🤣|crying|face|floor|funny|haha|happy|hehe|hilarious|joy|laugh|lmao|lol|rofl|roflmao|rolling|tear
😂|crying|face|feels|funny|haha|happy|hehe|hilarious|joy|laugh|lmao|lol|rofl|roflmao|tear
🙂|face|happy|slightly|smile|smiling
🙃|face|hehe|smile|upside-down
😉|face|flirt|heartbreaker|sexy|slide|tease|wink|winking|winks
😊|blush|eye|eyes|face|glad|satisfied|smile|smiling
😇|angel|angelic|angels|blessed|face|fairy|fairytale|fantasy|halo|happy|innocent|peaceful|smile|smiling|spirit|tale
🥰|3|adore|crush|face|heart|hearts|ily|love|romance|smile|smiling|you
😍|143|bae|eye|face|feels|heart-eyes|hearts|ily|kisses|love|romance|romantic|smile|xoxo
🤩|excited|eyes|face|grinning|smile|star|star-struck|starry-eyed|wow
😘|adorbs|bae|blowing|face|flirt|heart|ily|kiss|love|lover|miss|muah|romantic|smooch|xoxo|you
😗|143|date|dating|face|flirt|ily|kiss|love|smooch|smooches|xoxo|you
☺️|face|happy|outlined|relaxed|smile|smiling
😚|143|bae|blush|closed|date|dating|eye|eyes|face|flirt|ily|kisses|kissing|smooches|xoxo
😙|143|closed|date|dating|eye|eyes|face|flirt|ily|kiss|kisses|kissing|love|night|smile|smiling
😋|delicious|eat|face|food|full|hungry|savor|smile|smiling|tasty|um|yum|yummy
😛|awesome|cool|face|nice|party|stuck-out|sweet|tongue
😜|crazy|epic|eye|face|funny|joke|loopy|nutty|party|stuck-out|tongue|wacky|weirdo|wink|winking|yolo
🤪|crazy|eye|eyes|face|goofy|large|small|zany
😝|closed|eye|eyes|face|gross|horrible|omg|squinting|stuck-out|taste|tongue|whatever|yolo
🤑|face|money|money-mouth|mouth|paid
🤗|face|hands|hug|hugging|open|smiling
🫣|captivated|embarrass|eye|face|hide|hiding|peek|peeking|peep|scared|shy|stare
🤭|face|giggle|giggling|hand|mouth|oops|realization|secret|shock|sudden|surprise|whoops
🫢|amazement|awe|disbelief|embarrass|eyes|face|gasp|hand|mouth|omg|open|over|quiet|scared|shock|surprise
🫡|face|good|luck|ma’am|OK|respect|salute|saluting|sir|troops|yes
🤫|face|quiet|shh|shush|shushing
🫠|disappear|dissolve|embarrassed|face|haha|heat|hot|liquid|lol|melt|melting|sarcasm|sarcastic
🤔|chin|consider|face|hmm|ponder|pondering|thinking|wondering
🤐|face|keep|mouth|quiet|secret|shut|zip|zipper|zipper-mouth
🤨|disapproval|disbelief|distrust|emoji|eyebrow|face|hmm|mild|raised|skeptic|skeptical|skepticism|surprise|what
😐|awkward|blank|deadpan|expressionless|face|fine|jealous|meh|neutral|oh|shade|straight|unamused|unhappy|unimpressed|whatever
🫤|confused|confusion|diagonal|disappointed|doubt|doubtful|face|frustrated|frustration|meh|mouth|skeptical|unsure|whatever|wtv
😑|awkward|dead|expressionless|face|fine|inexpressive|jealous|meh|not|oh|omg|straight|uh|unhappy|unimpressed|whatever
😶|awkward|blank|expressionless|face|mouth|mouthless|mute|quiet|secret|silence|silent|speechless
🫥|depressed|disappear|dotted|face|hidden|hide|introvert|invisible|line|meh|whatever|wtv
😏|boss|dapper|face|flirt|homie|kidding|leer|shade|slick|sly|smirk|smug|snicker|suave|suspicious|swag
😒|...|bored|face|fine|jealous|jel|jelly|pissed|smh|ugh|uhh|unamused|unhappy|weird|whatever
🙄|eyeroll|eyes|face|rolling|shade|ugh|whatever
😬|awk|awkward|dentist|face|grimace|grimacing|grinning|smile|smiling
🤥|face|liar|lie|lying|pinocchio
😌|calm|face|peace|relief|relieved|zen
😔|awful|bored|dejected|died|disappointed|face|losing|lost|pensive|sad|sucks
🥹|admiration|aww|back|cry|embarrassed|face|feelings|grateful|gratitude|holding|joy|please|proud|resist|sad|tears
😪|crying|face|good|night|sad|sleep|sleeping|sleepy|tired
🤤|drooling|face
😴|bed|bedtime|face|good|goodnight|nap|night|sleep|sleeping|tired|whatever|yawn|zzz
😷|cold|dentist|dermatologist|doctor|dr|face|germs|mask|medical|medicine|sick
🤒|face|ill|sick|thermometer
🤕|bandage|face|head-bandage|hurt|injury|ouch
🤢|face|gross|nasty|nauseated|sick|vomit
🤮|barf|ew|face|gross|puke|sick|spew|throw|up|vomit|vomiting
🤧|face|fever|flu|gesundheit|sick|sneeze|sneezing
🥵|dying|face|feverish|heat|hot|panting|red-faced|stroke|sweating|tongue
🥶|blue|blue-faced|cold|face|freezing|frostbite|icicles|subzero|teeth
🥴|dizzy|drunk|eyes|face|intoxicated|mouth|tipsy|uneven|wavy|woozy
😵|crossed-out|dead|dizzy|eyes|face|feels|knocked|out|sick|tired
😵‍💫|confused|dizzy|eyes|face|hypnotized|omg|smiley|spiral|trouble|whoa|woah|woozy
🤯|blown|explode|exploding|head|mind|mindblown|no|shocked|way
🤠|cowboy|cowgirl|face|hat
🥳|bday|birthday|celebrate|celebration|excited|face|happy|hat|hooray|horn|party|partying
😎|awesome|beach|bright|bro|chilling|cool|face|rad|relaxed|shades|slay|smile|style|sunglasses|swag|win
🤓|brainy|clever|expert|face|geek|gifted|glasses|intelligent|nerd|smart
🧐|classy|face|fancy|monocle|rich|stuffy|wealthy
😕|befuddled|confused|confusing|dunno|face|frown|hm|meh|not|sad|sorry|sure
😟|anxious|butterflies|face|nerves|nervous|sad|stress|stressed|surprised|worried|worry
🙁|face|frown|frowning|sad|slightly
☹️|face|frown|frowning|sad
😮|believe|face|forgot|mouth|omg|open|shocked|surprised|sympathy|unbelievable|unreal|whoa|wow|you
😯|epic|face|hushed|omg|stunned|surprised|whoa|woah
😲|astonished|cost|face|no|omg|shocked|totally|way
😳|amazed|awkward|crazy|dazed|dead|disbelief|embarrassed|face|flushed|geez|heat|hot|impressed|jeez|what|wow
🥺|begging|big|eyes|face|mercy|not|pleading|please|pretty|puppy|sad|why
😦|caught|face|frown|frowning|guard|mouth|open|scared|scary|surprise|what|wow
😧|anguished|face|forgot|scared|scary|stressed|surprise|unhappy|what|wow
😨|afraid|anxious|blame|face|fear|fearful|scared|worried
😰|anxious|blue|cold|eek|face|mouth|nervous|open|rushed|scared|sweat|yikes
😥|anxious|call|close|complicated|disappointed|face|not|relieved|sad|sweat|time|whew
😢|awful|cry|crying|face|feels|miss|sad|tear|triste|unhappy
😭|bawling|cry|crying|face|loudly|sad|sob|tear|tears|unhappy
😱|epic|face|fear|fearful|munch|scared|scream|screamer|screaming|shocked|surprised|woah
😖|annoyed|confounded|confused|cringe|distraught|face|feels|frustrated|mad|sad
😣|concentrate|concentration|face|focus|headache|persevere|persevering
😞|awful|blame|dejected|disappointed|face|fail|losing|sad|unhappy
😓|close|cold|downcast|face|feels|headache|nervous|sad|scared|sweat|yikes
😩|crying|face|fail|feels|hungry|mad|nooo|sad|sleepy|tired|unhappy|weary
😫|cost|face|feels|nap|sad|sneeze|tired
😤|anger|angry|face|feels|fume|fuming|furious|fury|mad|nose|steam|triumph|unhappy|won
😡|anger|angry|enraged|face|feels|mad|maddening|pouting|rage|red|shade|unhappy|upset
😠|anger|angry|blame|face|feels|frustrated|mad|maddening|rage|shade|unhappy|upset
🤬|censor|cursing|cussing|face|mad|mouth|pissed|swearing|symbols
😈|demon|devil|evil|face|fairy|fairytale|fantasy|horns|purple|shade|smile|smiling|tale
👿|angry|demon|devil|evil|face|fairy|fairytale|fantasy|horns|imp|mischievous|purple|shade|tale
💀|body|dead|death|face|fairy|fairytale|i’m|lmao|monster|skull|tale|yolo
☠️|bone|crossbones|dead|death|face|monster|skull
💩|bs|comic|doo|dung|face|fml|monster|pile|poo|poop|smelly|smh|stink|stinks|stinky|turd
🤡|clown|face
👹|creature|devil|face|fairy|fairytale|fantasy|mask|monster|ogre|scary|tale
👺|angry|creature|face|fairy|fairytale|fantasy|goblin|mask|mean|monster|tale
👻|boo|creature|excited|face|fairy|fairytale|fantasy|ghost|halloween|haunting|monster|scary|silly|tale
👽|alien|creature|extraterrestrial|face|fairy|fairytale|fantasy|monster|space|tale|ufo
👾|alien|creature|extraterrestrial|face|fairy|fairytale|fantasy|game|gamer|games|monster|pixelated|space|tale|ufo
🤖|face|monster|robot
🎃|celebration|halloween|jack|jack-o-lantern|lantern|pumpkin
😺|animal|cat|face|grinning|mouth|open|smile|smiling
😸|animal|cat|eye|eyes|face|grin|grinning|smile|smiling
😹|animal|cat|face|joy|laugh|laughing|lol|tear|tears
😻|animal|cat|eye|face|heart|heart-eyes|love|smile|smiling
😼|animal|cat|face|ironic|smile|wry
😽|animal|cat|closed|eye|eyes|face|kiss|kissing
🙀|animal|cat|face|oh|surprised|weary
😿|animal|cat|cry|crying|face|sad|tear
😾|animal|cat|face|pouting
🫶|<3|hands|heart|love|you
👋|bye|cya|g2g|greetings|gtg|hand|hello|hey|hi|later|outtie|ttfn|ttyl|wave|yo|you
🤚|back|backhand|hand|raised
🖐️|finger|fingers|hand|raised|splayed|stop
✋|5|five|hand|high|raised|stop
🖖|finger|hand|hands|salute|Vulcan
👌|awesome|bet|dope|fleek|fosho|got|gotcha|hand|legit|OK|okay|pinch|rad|sure|sweet|three
🤌|fingers|gesture|hand|hold|huh|interrogation|patience|pinched|relax|sarcastic|ugh|what|zip
🤏|amount|bit|fingers|hand|little|pinching|small|sort
🫳|dismiss|down|drop|dropped|hand|palm|pick|shoo|up
🫴|beckon|catch|come|hand|hold|know|lift|me|offer|palm|tell
✌️|hand|peace|v|victory
🫰|<3|crossed|expensive|finger|hand|heart|index|love|money|snap|thumb
🤞|cross|crossed|finger|fingers|hand|luck
🤟|fingers|gesture|hand|ILY|love|love-you|three|you
🤘|finger|hand|horns|rock-on|sign
🤙|call|hand|hang|loose|me|Shaka
👈|backhand|finger|hand|index|left|point|pointing
👉|backhand|finger|hand|index|point|pointing|right
👆|backhand|finger|hand|index|point|pointing|up
🖕|finger|hand|middle
👇|backhand|down|finger|hand|index|point|pointing
☝️|finger|hand|index|point|pointing|this|up
👍|+1|good|hand|like|thumb|up|yes
👎|-1|bad|dislike|down|good|hand|no|nope|thumb|thumbs
✊|clenched|fist|hand|punch|raised|solidarity
👊|absolutely|agree|boom|bro|bruh|bump|clenched|correct|fist|hand|knuckle|oncoming|pound|punch|rock|ttyl
🤛|fist|left-facing|leftwards
🤜|fist|right-facing|rightwards
🫲|hand|handshake|hold|left|leftward|leftwards|reach|shake
🫱|hand|handshake|hold|reach|right|rightward|rightwards|shake
👏|applause|approval|awesome|clap|congrats|congratulations|excited|good|great|hand|homie|job|nice|prayed|well|yay
🙌|celebration|gesture|hand|hands|hooray|praise|raised|raising
👐|hand|hands|hug|jazz|open|swerve
🤲|cupped|dua|hands|palms|pray|prayer|together|up|wish
🤝|agreement|deal|hand|handshake|meeting|shake
🙏|appreciate|ask|beg|blessed|bow|cmon|five|folded|gesture|hand|high|please|pray|thanks|thx
🫵|at|finger|hand|index|pointing|poke|viewer|you
✍️|hand|write|writing
💅|bored|care|cosmetics|done|makeup|manicure|nail|polish|whatever
🤳|camera|phone|selfie
💪|arm|beast|bench|biceps|bodybuilder|bro|curls|flex|gains|gym|jacked|muscle|press|ripped|strong|weightlift
🦵|bent|foot|kick|knee|leg|limb
🦶|ankle|feet|foot|kick|stomp
👂|body|ear|ears|hear|hearing|listen|listening|sound
👃|body|nose|noses|nosey|odor|smell|smells
🧠|brain|intelligent|smart
🦴|bone|bones|dog|skeleton|wishbone
👀|body|eye|eyes|face|googly|look|looking|omg|peep|see|seeing
👁️|1|body|eye|one
💋|dating|emotion|heart|kiss|kissing|lips|mark|romance|sexy
👄|beauty|body|kiss|kissing|lips|lipstick|mouth
🫦|anxious|bite|biting|fear|flirt|flirting|kiss|lip|lipstick|nervous|sexy|uncomfortable|worried|worry
🦷|dentist|pearly|teeth|tooth|white
👅|body|lick|slurp|tongue
👶|babies|baby|children|goo|infant|newborn|pregnant|young
🧒|bright-eyed|child|grandchild|kid|young|younger
👦|boy|bright-eyed|child|grandson|kid|son|young|younger
👧|bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
🧑|adult|person
👨|adult|bro|man
🧔|beard|bearded|person|whiskers
👱|blond|blond-haired|human|person
👨‍🦰|adult|bro|man ginger|hair|red|redhead
👨‍🦱|adult|bro|man afro|curly|hair|ringlets
👨‍🦳|adult|bro|man gray|hair|old|white
👨‍🦲|adult|bro|man bald|chemotherapy|hair|hairless|no|shaven
👩|adult|lady|woman
👱‍♀️|blond|blond-haired|human|person female|sign|woman
👩‍🦰|adult|lady|woman ginger|hair|red|redhead
👩‍🦱|adult|lady|woman afro|curly|hair|ringlets
👩‍🦳|adult|lady|woman gray|hair|old|white
👩‍🦲|adult|lady|woman bald|chemotherapy|hair|hairless|no|shaven
🧓|adult|elderly|grandparent|old|person|wise
👴|adult|bald|elderly|gramps|grandfather|grandpa|man|old|wise
👵|adult|elderly|grandma|grandmother|granny|lady|old|wise|woman
🙍‍♂️|annoyed|disappointed|disgruntled|disturbed|frown|frowning|frustrated|gesture|irritated|person|upset male|man|sign
🙍‍♀️|annoyed|disappointed|disgruntled|disturbed|frown|frowning|frustrated|gesture|irritated|person|upset female|sign|woman
🙎‍♂️|disappointed|downtrodden|frown|grimace|person|pouting|scowl|sulk|upset|whine male|man|sign
🙎‍♀️|disappointed|downtrodden|frown|grimace|person|pouting|scowl|sulk|upset|whine female|sign|woman
🙅‍♂️|forbidden|gesture|hand|NO|not|person|prohibit male|man|sign
🙅‍♀️|forbidden|gesture|hand|NO|not|person|prohibit female|sign|woman
🙆‍♂️|exercise|gesture|gesturing|hand|OK|omg|person male|man|sign
🙆‍♀️|exercise|gesture|gesturing|hand|OK|omg|person female|sign|woman
💁‍♂️|fetch|flick|flip|gossip|hand|person|sarcasm|sarcastic|sassy|seriously|tipping|whatever male|man|sign
💁‍♀️|fetch|flick|flip|gossip|hand|person|sarcasm|sarcastic|sassy|seriously|tipping|whatever female|sign|woman
🙋‍♂️|gesture|hand|here|know|me|person|pick|question|raise|raising male|man|sign
🙋‍♀️|gesture|hand|here|know|me|person|pick|question|raise|raising female|sign|woman
🙇‍♂️|apology|ask|beg|bow|bowing|favor|forgive|gesture|meditate|meditation|person|pity|regret|sorry male|man|sign
🙇‍♀️|apology|ask|beg|bow|bowing|favor|forgive|gesture|meditate|meditation|person|pity|regret|sorry female|sign|woman
🤦‍♂️|again|bewilder|disbelief|exasperation|facepalm|no|not|oh|omg|person|shock|smh male|man|sign
🤦‍♀️|again|bewilder|disbelief|exasperation|facepalm|no|not|oh|omg|person|shock|smh female|sign|woman
🤷‍♂️|doubt|dunno|guess|idk|ignorance|indifference|knows|maybe|person|shrug|shrugging|whatever|who male|man|sign
🤷‍♀️|doubt|dunno|guess|idk|ignorance|indifference|knows|maybe|person|shrug|shrugging|whatever|who female|sign|woman
👨‍⚕️|adult|bro|man aesculapius|medical|medicine|staff|symbol
👩‍⚕️|adult|lady|woman aesculapius|medical|medicine|staff|symbol
👨‍🎓|graduate|man|student
👩‍🎓|graduate|student|woman
👨‍🏫|instructor|lecturer|man|professor|teacher
👩‍🏫|instructor|lecturer|professor|teacher|woman
👨‍⚖️|adult|bro|man balance|justice|Libra|scale|scales|tool|weight|zodiac
👩‍⚖️|adult|lady|woman balance|justice|Libra|scale|scales|tool|weight|zodiac
👨‍🌾|farmer|gardener|man|rancher
👩‍🌾|farmer|gardener|rancher|woman
👨‍🍳|chef|cook|man
👩‍🍳|chef|cook|woman
👨‍🔧|electrician|man|mechanic|plumber|tradesperson
👩‍🔧|electrician|mechanic|plumber|tradesperson|woman
👨‍🏭|assembly|factory|industrial|man|worker
👩‍🏭|assembly|factory|industrial|woman|worker
👨‍💼|architect|business|man|manager|office|white-collar|worker
👩‍💼|architect|business|manager|office|white-collar|woman|worker
👨‍🔬|biologist|chemist|engineer|man|mathematician|physicist|scientist
👩‍🔬|biologist|chemist|engineer|mathematician|physicist|scientist|woman
👨‍💻|coder|computer|developer|inventor|man|software|technologist
👩‍💻|coder|computer|developer|inventor|software|technologist|woman
👨‍🎤|actor|entertainer|man|rock|rockstar|singer|star
👩‍🎤|actor|entertainer|rock|rockstar|singer|star|woman
👨‍🎨|artist|man|palette
👩‍🎨|artist|palette|woman
👨‍✈️|adult|bro|man aeroplane|airplane|fly|flying|jet|plane|travel
👩‍✈️|adult|lady|woman aeroplane|airplane|fly|flying|jet|plane|travel
👨‍🚀|astronaut|man|rocket|space
👩‍🚀|astronaut|rocket|space|woman
👨‍🚒|fire|firefighter|firetruck|man
👩‍🚒|fire|firefighter|firetruck|woman
👮‍♂️|apprehend|arrest|citation|cop|law|officer|over|police|pulled|undercover male|man|sign
👮‍♀️|apprehend|arrest|citation|cop|law|officer|over|police|pulled|undercover female|sign|woman
🕵️‍♂️|detective|sleuth|spy male|man|sign
🕵️‍♀️|detective|sleuth|spy female|sign|woman
💂‍♂️|buckingham|guard|helmet|london|palace male|man|sign
💂‍♀️|buckingham|guard|helmet|london|palace female|sign|woman
👷‍♂️|build|construction|fix|hardhat|hat|man|person|rebuild|remodel|repair|work|worker male|man|sign
👷‍♀️|build|construction|fix|hardhat|hat|man|person|rebuild|remodel|repair|work|worker female|sign|woman
🤴|crown|fairy|fairytale|fantasy|king|prince|royal|royalty|tale
👸|crown|fairy|fairytale|fantasy|princess|queen|royal|royalty|tale
👳‍♂️|person|turban|wearing male|man|sign
👳‍♀️|person|turban|wearing female|sign|woman
👲|cap|Chinese|gua|guapi|hat|mao|person|pi|skullcap
🧕|bandana|head|headscarf|hijab|kerchief|mantilla|tichel|woman
🤵|formal|person|tuxedo|wedding
👰|person|veil|wedding
🤰|pregnant|woman
🤱|baby|breast|breast-feeding|feeding|mom|mother|nursing|woman
👼|angel|baby|church|face|fairy|fairytale|fantasy|tale
🎅|celebration|Christmas|claus|fairy|fantasy|father|holiday|merry|santa|tale|xmas
🤶|celebration|Christmas|claus|fairy|fantasy|holiday|merry|mother|Mrs|santa|tale|xmas
🦸‍♂️|good|hero|superhero|superpower male|man|sign
🦸‍♀️|good|hero|superhero|superpower female|sign|woman
🦹‍♂️|bad|criminal|evil|superpower|supervillain|villain male|man|sign
🦹‍♀️|bad|criminal|evil|superpower|supervillain|villain female|sign|woman
🧙‍♂️|fantasy|mage|magic|play|sorcerer|sorceress|sorcery|spell|summon|witch|wizard male|man|sign
🧙‍♀️|fantasy|mage|magic|play|sorcerer|sorceress|sorcery|spell|summon|witch|wizard female|sign|woman
🧚‍♂️|fairy|fairytale|fantasy|myth|person|pixie|tale|wings male|man|sign
🧚‍♀️|fairy|fairytale|fantasy|myth|person|pixie|tale|wings female|sign|woman
🧛‍♂️|blood|Dracula|fangs|halloween|scary|supernatural|teeth|undead|vampire male|man|sign
🧛‍♀️|blood|Dracula|fangs|halloween|scary|supernatural|teeth|undead|vampire female|sign|woman
🧜‍♂️|creature|fairytale|folklore|merperson|ocean|sea|siren|trident male|man|sign
🧜‍♀️|creature|fairytale|folklore|merperson|ocean|sea|siren|trident female|sign|woman
🧝‍♂️|elf|elves|enchantment|fantasy|folklore|magic|magical|myth male|man|sign
🧝‍♀️|elf|elves|enchantment|fantasy|folklore|magic|magical|myth female|sign|woman
🧞‍♂️|djinn|fantasy|genie|jinn|lamp|myth|rub|wishes male|man|sign
🧞‍♀️|djinn|fantasy|genie|jinn|lamp|myth|rub|wishes female|sign|woman
🧟‍♂️|apocalypse|dead|halloween|horror|scary|undead|walking|zombie male|man|sign
🧟‍♀️|apocalypse|dead|halloween|horror|scary|undead|walking|zombie female|sign|woman
💆‍♂️|face|getting|headache|massage|person|relax|relaxing|salon|soothe|spa|tension|therapy|treatment male|man|sign
💆‍♀️|face|getting|headache|massage|person|relax|relaxing|salon|soothe|spa|tension|therapy|treatment female|sign|woman
💇‍♂️|barber|beauty|chop|cosmetology|cut|groom|hair|haircut|parlor|person|shears|style male|man|sign
💇‍♀️|barber|beauty|chop|cosmetology|cut|groom|hair|haircut|parlor|person|shears|style female|sign|woman
🚶‍♂️|amble|gait|hike|man|pace|pedestrian|person|stride|stroll|walk|walking male|man|sign
🚶‍♀️|amble|gait|hike|man|pace|pedestrian|person|stride|stroll|walk|walking female|sign|woman
🏃‍♂️|fast|hurry|marathon|move|person|quick|race|racing|run|rush|speed male|man|sign
🏃‍♀️|fast|hurry|marathon|move|person|quick|race|racing|run|rush|speed female|sign|woman
🕺|dance|dancer|dancing|elegant|festive|flair|flamenco|groove|let’s|man|salsa|tango
💃|dance|dancer|dancing|elegant|festive|flair|flamenco|groove|let’s|salsa|tango|woman
🕴️|business|levitating|person|suit
👯‍♂️|bestie|bff|bunny|counterpart|dancer|double|ear|identical|pair|party|partying|people|soulmate|twin|twinsies male|man|sign
👯‍♀️|bestie|bff|bunny|counterpart|dancer|double|ear|identical|pair|party|partying|people|soulmate|twin|twinsies female|sign|woman
🧖‍♂️|day|luxurious|pamper|person|relax|room|sauna|spa|steam|steambath|unwind male|man|sign
🧖‍♀️|day|luxurious|pamper|person|relax|room|sauna|spa|steam|steambath|unwind female|sign|woman
🧘|cross|legged|legs|lotus|meditation|peace|person|position|relax|serenity|yoga|yogi|zen
👭|bae|bestie|bff|couple|dating|flirt|friends|girls|hand|hold|sisters|twins|women
👫|bae|bestie|bff|couple|dating|flirt|friends|hand|hold|man|twins|woman
👬|bae|bestie|bff|boys|brothers|couple|dating|flirt|friends|hand|hold|men|twins
💏|anniversary|babe|bae|couple|date|dating|heart|kiss|love|mwah|person|romance|together|xoxo
👨‍❤️‍💋‍👨|adult|bro|man emotion|heart|love|red dating|emotion|heart|kiss|kissing|lips|mark|romance|sexy adult|bro|man
👩‍❤️‍💋‍👩|adult|lady|woman emotion|heart|love|red dating|emotion|heart|kiss|kissing|lips|mark|romance|sexy adult|lady|woman
💑|anniversary|babe|bae|couple|dating|heart|kiss|love|person|relationship|romance|together|you
👨‍❤️‍👨|adult|bro|man emotion|heart|love|red adult|bro|man
👩‍❤️‍👩|adult|lady|woman emotion|heart|love|red adult|lady|woman
👪|child|family
👨‍👩‍👦|adult|bro|man adult|lady|woman boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👩‍👧|adult|bro|man adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👨‍👩‍👧‍👦|adult|bro|man adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👩‍👦‍👦|adult|bro|man adult|lady|woman boy|bright-eyed|child|grandson|kid|son|young|younger boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👩‍👧‍👧|adult|bro|man adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👨‍👨‍👦|adult|bro|man adult|bro|man boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👨‍👧|adult|bro|man adult|bro|man bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👨‍👨‍👧‍👦|adult|bro|man adult|bro|man bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👨‍👦‍👦|adult|bro|man adult|bro|man boy|bright-eyed|child|grandson|kid|son|young|younger boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👨‍👧‍👧|adult|bro|man adult|bro|man bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👩‍👩‍👦|adult|lady|woman adult|lady|woman boy|bright-eyed|child|grandson|kid|son|young|younger
👩‍👩‍👧|adult|lady|woman adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👩‍👩‍👧‍👦|adult|lady|woman adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac boy|bright-eyed|child|grandson|kid|son|young|younger
👩‍👩‍👦‍👦|adult|lady|woman adult|lady|woman boy|bright-eyed|child|grandson|kid|son|young|younger boy|bright-eyed|child|grandson|kid|son|young|younger
👩‍👩‍👧‍👧|adult|lady|woman adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👨‍👦|adult|bro|man boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👦‍👦|adult|bro|man boy|bright-eyed|child|grandson|kid|son|young|younger boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👧|adult|bro|man bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👨‍👧‍👦|adult|bro|man bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac boy|bright-eyed|child|grandson|kid|son|young|younger
👨‍👧‍👧|adult|bro|man bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👩‍👦|adult|lady|woman boy|bright-eyed|child|grandson|kid|son|young|younger
👩‍👦‍👦|adult|lady|woman boy|bright-eyed|child|grandson|kid|son|young|younger boy|bright-eyed|child|grandson|kid|son|young|younger
👩‍👧|adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
👩‍👧‍👦|adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac boy|bright-eyed|child|grandson|kid|son|young|younger
👩‍👧‍👧|adult|lady|woman bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac bright-eyed|child|daughter|girl|granddaughter|kid|Virgo|young|younger|zodiac
🗣️|face|head|silhouette|speak|speaking
👤|bust|mysterious|shadow|silhouette
👥|bff|bust|busts|everyone|friend|friends|people|silhouette
🫂|comfort|embrace|farewell|friendship|goodbye|hello|hug|hugging|love|people|thanks
👣|barefoot|clothing|footprint|footprints|omw|print|walk
🧳|bag|luggage|packing|roller|suitcase|travel
🌂|closed|clothing|rain|umbrella
☂️|clothing|rain|umbrella
🧵|needle|sewing|spool|string|thread
🧶|ball|crochet|knit|yarn
👓|clothing|eye|eyeglasses|eyewear|glasses
🕶️|dark|eye|eyewear|glasses|sunglasses
🥽|dive|eye|goggles|protection|scuba|swimming|welding
🥼|clothes|coat|doctor|dr|experiment|jacket|lab|scientist|white
👔|clothing|employed|necktie|serious|shirt|tie
👕|blue|casual|clothes|clothing|collar|dressed|shirt|shopping|t-shirt|tshirt|weekend
👖|blue|casual|clothes|clothing|denim|dressed|jeans|pants|shopping|trousers|weekend
🧣|bundle|cold|neck|scarf|up
🧤|gloves|hand
🧥|brr|bundle|coat|cold|jacket|up
🧦|socks|stocking
👗|clothes|clothing|dress|dressed|fancy|shopping
👘|clothing|comfortable|kimono
👙|bathing|beach|bikini|clothing|pool|suit|swim
👚|blouse|clothes|clothing|collar|dress|dressed|lady|shirt|shopping|woman|woman’s
👛|clothes|clothing|coin|dress|fancy|handbag|purse|shopping
👜|bag|clothes|clothing|dress|handbag|lady|purse|shopping
👝|bag|clothes|clothing|clutch|dress|handbag|pouch|purse
🎒|backpack|backpacking|bag|bookbag|education|rucksack|satchel|school
👞|brown|clothes|clothing|feet|foot|kick|man|man’s|shoe|shoes|shopping
👟|athletic|clothes|clothing|fast|kick|running|shoe|shoes|shopping|sneaker|tennis
🥾|backpacking|boot|brown|camping|hiking|outdoors|shoe
🥿|ballet|comfy|flat|flats|shoe|slip-on|slipper
👠|clothes|clothing|dress|fashion|heel|heels|high-heeled|shoe|shoes|shopping|stiletto|woman
👡|clothing|sandal|shoe|woman|woman’s
👢|boot|clothes|clothing|dress|shoe|shoes|shopping|woman|woman’s
👑|clothing|crown|family|king|medieval|queen|royal|royalty|win
👒|clothes|clothing|garden|hat|hats|party|woman|woman’s
🎩|clothes|clothing|fancy|formal|hat|magic|top|tophat
🎓|cap|celebration|clothing|education|graduation|hat|scholar
🧢|baseball|bent|billed|cap|dad|hat
⛑️|aid|cross|face|hat|helmet|rescue|worker’s
💄|cosmetics|date|lipstick|makeup
💍|diamond|engaged|engagement|married|ring|romance|shiny|sparkling|wedding
💼|briefcase|office
🐶|adorbs|animal|dog|face|pet|puppies|puppy
🐱|animal|cat|face|kitten|kitty|pet
🐭|animal|face|mouse
🐹|animal|face|hamster|pet
🐰|animal|bunny|face|pet|rabbit
🦊|animal|face|fox
🐻|animal|bear|face|grizzly|growl|honey
🐼|animal|bamboo|face|panda
🐨|animal|australia|bear|down|face|koala|marsupial|under
🐯|animal|big|cat|face|predator|tiger
🦁|alpha|animal|face|Leo|lion|mane|order|rawr|roar|safari|strong|zodiac
🐮|animal|cow|face|farm|milk|moo
🐷|animal|bacon|face|farm|pig|pork
🐽|animal|face|farm|nose|pig|smell|snout
🐸|animal|face|frog
🐵|animal|banana|face|monkey
🙈|embarrassed|evil|face|forbidden|forgot|gesture|hide|monkey|no|omg|prohibited|scared|secret|smh|watch
🙉|animal|ears|evil|face|forbidden|gesture|hear|listen|monkey|no|not|prohibited|secret|shh|tmi
🙊|animal|evil|face|forbidden|gesture|monkey|no|not|oops|prohibited|quiet|secret|speak|stealth
🐒|animal|banana|monkey
💥|bomb|boom|collide|collision|comic|explode
💫|comic|dizzy|shining|shooting|star|stars
💦|comic|drip|droplet|droplets|drops|splashing|squirt|sweat|water|wet|work|workout
💨|away|cloud|comic|dash|dashing|fart|fast|go|gone|gotta|running|smoke
🦍|animal|gorilla
🐕|animal|animals|dog|dogs|pet
🐩|animal|dog|fluffy|poodle
🐺|animal|face|wolf
🦝|animal|curious|raccoon|sly
🐈|animal|animals|cat|cats|kitten|pet
🐅|animal|big|cat|predator|tiger|zoo
🐆|animal|big|cat|leopard|predator|zoo
🐴|animal|dressage|equine|face|farm|horse|horses
🐎|animal|equestrian|farm|horse|racehorse|racing
🦄|face|unicorn
🦓|animal|stripe|zebra
🐂|animal|animals|bull|farm|ox|Taurus|zodiac
🐃|animal|buffalo|water|zoo
🐄|animal|animals|cow|farm|milk|moo
🐖|animal|bacon|farm|pig|pork|sow
🐗|animal|boar|pig
🐏|animal|Aries|horns|male|ram|sheep|zodiac|zoo
🐑|animal|baa|ewe|farm|female|fluffy|lamb|sheep|wool
🐐|animal|Capricorn|farm|goat|milk|zodiac
🐪|animal|camel|desert|dromedary|hump|one
🐫|animal|bactrian|camel|desert|hump|two|two-hump
🦙|alpaca|animal|guanaco|llama|vicuña|wool
🦒|animal|giraffe|spots
🐘|animal|elephant
🦏|animal|rhinoceros
🦛|animal|hippo|hippopotamus
🐁|animal|animals|mouse
🐀|animal|rat
🐇|animal|bunny|pet|rabbit
🐿️|animal|chipmunk|squirrel
🦔|animal|hedgehog|spiny
🦇|animal|bat|vampire
🦘|animal|joey|jump|kangaroo|marsupial
🦡|animal|badger|honey|pester
🐾|feet|paw|paws|print|prints
🦃|bird|gobble|thanksgiving|turkey
🐔|animal|bird|chicken|ornithology
🐓|animal|bird|ornithology|rooster
🐣|animal|baby|bird|chick|egg|hatching
🐤|animal|baby|bird|chick|ornithology
🐥|animal|baby|bird|chick|front-facing|newborn|ornithology
🐦|animal|bird|ornithology
🐧|animal|antarctica|bird|ornithology|penguin
🕊️|bird|dove|fly|ornithology|peace
🦅|animal|bird|eagle|ornithology
🦆|animal|bird|duck|ornithology
🦢|animal|bird|cygnet|duckling|ornithology|swan|ugly
🦉|animal|bird|ornithology|owl|wise
🦚|animal|bird|colorful|ornithology|ostentatious|peacock|peahen|pretty|proud
🦜|animal|bird|ornithology|parrot|pirate|talk
🐊|animal|crocodile|zoo
🐢|animal|terrapin|tortoise|turtle
🦎|animal|lizard|reptile
🐍|animal|bearer|Ophiuchus|serpent|snake|zodiac
🐲|animal|dragon|face|fairy|fairytale|tale
🐉|animal|dragon|fairy|fairytale|knights|tale
🦕|brachiosaurus|brontosaurus|dinosaur|diplodocus|sauropod
🦖|dinosaur|Rex|T|T-Rex|Tyrannosaurus
🧌|fairy|fantasy|monster|tale|troll|trolling
🐳|animal|beach|face|ocean|spouting|whale
🐋|animal|beach|ocean|whale
🐬|animal|beach|dolphin|flipper|ocean
🐟|animal|dinner|fish|fishes|fishing|Pisces|zodiac
🐠|animal|fish|fishes|tropical
🐡|animal|blowfish|fish
🦈|animal|fish|shark
🐙|animal|creature|ocean|octopus
🪹|branch|empty|home|nest|nesting
🪺|bird|branch|egg|eggs|nest|nesting
🐚|animal|beach|conch|sea|shell|spiral
🪸|change|climate|coral|ocean|reef|sea
🐌|animal|escargot|garden|nature|slug|snail
🦋|butterfly|insect|pretty
🐛|animal|bug|garden|insect
🐜|animal|ant|garden|insect
🐝|animal|bee|bumblebee|honey|honeybee|insect|nature|spring
🐞|animal|beetle|garden|insect|lady|ladybird|ladybug|nature
🦗|animal|bug|cricket|grasshopper|insect|Orthoptera
🕷️|animal|insect|spider
🕸️|spider|web
🦂|Scorpio|scorpion|Scorpius|zodiac
🦟|bite|disease|fever|insect|malaria|mosquito|pest|virus
🦠|amoeba|bacteria|microbe|science|virus
💐|anniversary|birthday|bouquet|date|flower|love|plant|romance
🌸|blossom|cherry|flower|plant|spring|springtime
💮|flower|white
🏵️|plant|rosette
🪷|beauty|Buddhism|calm|flower|Hinduism|lotus|peace|purity|serenity
🌹|beauty|elegant|flower|love|plant|red|rose|valentine
🥀|dying|flower|wilted
🌺|flower|hibiscus|plant
🌻|flower|outdoors|plant|sun|sunflower
🌼|blossom|buttercup|dandelion|flower|plant
🌷|blossom|flower|growth|plant|tulip
🌱|plant|sapling|seedling|sprout|young
🌲|christmas|evergreen|forest|pine|tree
🌳|deciduous|forest|green|habitat|shedding|tree
🌴|beach|palm|plant|tree|tropical
🌵|cactus|desert|drought|nature|plant
🌾|ear|grain|grains|plant|rice|sheaf
🌿|herb|leaf|plant
☘️|irish|plant|shamrock
🍀|4|clover|four|four-leaf|irish|leaf|lucky|plant
🍁|falling|leaf|maple
🍂|autumn|fall|fallen|falling|leaf
🍃|blow|flutter|fluttering|leaf|wind
🍄|fungus|mushroom|toadstool
🌰|almond|chestnut|plant
🦀|Cancer|crab|zodiac
🦞|animal|bisque|claws|lobster|seafood
🦐|food|shellfish|shrimp|small
🦑|animal|food|mollusk|squid
🌍|Africa|earth|Europe|Europe-Africa|globe|showing|world
🌎|Americas|earth|globe|showing|world
🌏|Asia|Asia-Australia|Australia|earth|globe|showing|world
🌐|earth|globe|internet|meridians|web|world|worldwide
🌑|dark|moon|new|space
🌒|crescent|dreams|moon|space|waxing
🌓|first|moon|quarter|space
🌔|gibbous|moon|space|waxing
🌕|full|moon|space
🌖|gibbous|moon|space|waning
🌗|last|moon|quarter|space
🌘|crescent|moon|space|waning
🌙|crescent|moon|ramadan|space
🌚|face|moon|new|space
🌛|face|first|moon|quarter|space
🌜|dreams|face|last|moon|quarter
☀️|bright|rays|space|sun|sunny|weather
🌝|bright|face|full|moon
🌞|beach|bright|day|face|heat|shine|sun|sunny|sunshine|weather
⭐|astronomy|medium|star|stars|white
🌟|glittery|glow|glowing|night|shining|sparkle|star|win
🌠|falling|night|shooting|space|star
☁️|cloud|weather
⛅|behind|cloud|cloudy|sun|weather
⛈️|cloud|lightning|rain|thunder|thunderstorm
🌤️|behind|cloud|sun|weather
🌥️|behind|cloud|sun|weather
🌦️|behind|cloud|rain|sun|weather
🌧️|cloud|rain|weather
🌨️|cloud|cold|snow|weather
🌩️|cloud|lightning|weather
🌪️|cloud|tornado|weather|whirlwind
🌫️|cloud|fog|weather
🌬️|blow|cloud|face|wind
🌈|gay|genderqueer|glbt|glbtq|lesbian|lgbt|lgbtq|lgbtqia|nature|pride|queer|rain|rainbow|trans|transgender|weather
☔|clothing|drop|drops|rain|umbrella|weather
⚡|danger|electric|electricity|high|lightning|nature|thunder|thunderbolt|voltage|zap
❄️|cold|snow|snowflake|weather
☃️|cold|man|snow|snowman
⛄|cold|man|snow|snowman
☄️|comet|space
🔥|af|burn|fire|flame|hot|lit|litaf|tool
💧|cold|comic|drop|droplet|nature|sad|sweat|tear|water|weather
🫧|bubble|bubbles|burp|clean|floating|pearl|soap|underwater
🌊|nature|ocean|surf|surfer|surfing|water|wave
🎄|celebration|Christmas|tree
✨|*|magic|sparkle|sparkles|star
🎋|banner|celebration|Japanese|tanabata|tree
🎍|bamboo|celebration|decoration|Japanese|pine|plant
🍇|Dionysus|fruit|grape|grapes
🍈|cantaloupe|fruit|melon
🍉|fruit|watermelon
🍊|c|citrus|fruit|nectarine|orange|tangerine|vitamin
🍋|citrus|fruit|lemon|sour
🍌|banana|fruit|potassium
🍍|colada|fruit|pina|pineapple|tropical
🥭|food|fruit|mango|tropical
🍎|apple|diet|food|fruit|health|red|ripe
🍏|apple|fruit|green
🍐|fruit|pear
🍑|fruit|peach
🍒|berries|cherries|cherry|fruit|red
🍓|berry|fruit|strawberry
🥝|food|fruit|kiwi
🍅|food|fruit|tomato|vegetable
🥥|coconut|colada|palm|piña
🥑|avocado|food|fruit
🍆|aubergine|eggplant|vegetable
🥔|food|potato|vegetable
🥕|carrot|food|vegetable
🌽|corn|crops|ear|farm|maize|maze
🌶️|hot|pepper
🥒|cucumber|food|pickle|vegetable
🥬|bok|burgers|cabbage|choy|green|kale|leafy|lettuce|salad
🥦|broccoli|cabbage|wild
🥜|food|nut|peanut|peanuts|vegetable
🫘|beans|food|kidney|legume|small
🍞|bread|carbs|food|grain|loaf|restaurant|toast|wheat
🥐|bread|breakfast|crescent|croissant|food|french|roll
🥖|baguette|bread|food|french
🥨|convoluted|pretzel|twisted
🥯|bagel|bakery|bread|breakfast|schmear
🥞|breakfast|crêpe|food|hotcake|pancake|pancakes
🧀|cheese|wedge
🍖|bone|meat
🍗|bone|chicken|drumstick|hungry|leg|poultry|turkey
🥩|chop|cut|lambchop|meat|porkchop|red|steak
🥓|bacon|breakfast|food|meat
🍔|burger|eat|fast|food|hamburger|hungry
🍟|fast|food|french|fries
🍕|cheese|food|hungry|pepperoni|pizza|slice
🌭|dog|frankfurter|hot|hotdog|sausage
🥪|bread|sandwich
🌮|mexican|taco
🌯|burrito|mexican|wrap
🥙|falafel|flatbread|food|gyro|kebab|stuffed
🍳|breakfast|cooking|easy|egg|fry|frying|over|pan|restaurant|side|sunny|up
🥘|casserole|food|paella|pan|shallow
🍲|food|pot|soup|stew
🥣|bowl|breakfast|cereal|congee|oatmeal|porridge|spoon
🥗|food|green|salad
🍿|corn|movie|pop|popcorn
🧂|condiment|flavor|mad|salt|salty|shaker|taste|upset
🥫|can|canned|food
🫙|condiment|container|empty|jar|nothing|sauce|store
🍱|bento|box|food
🍘|cracker|food|rice
🍙|ball|food|Japanese|rice
🍚|cooked|food|rice
🍛|curry|food|rice
🍜|bowl|chopsticks|food|noodle|pho|ramen|soup|steaming
🍝|food|meatballs|pasta|restaurant|spaghetti
🍠|food|potato|roasted|sweet
🍢|food|kebab|oden|restaurant|seafood|skewer|stick
🍣|food|sushi
🍤|fried|prawn|shrimp|tempura
🍥|cake|fish|food|pastry|restaurant|swirl
🥮|autumn|cake|festival|moon|yuèbǐng
🍡|dango|dessert|Japanese|skewer|stick|sweet
🥟|dumpling|empanada|gyōza|jiaozi|pierogi|potsticker
🥠|cookie|fortune|prophecy
🥡|box|chopsticks|delivery|food|oyster|pail|takeout
🍦|cream|dessert|food|ice|icecream|restaurant|serve|soft|sweet
🍧|dessert|ice|restaurant|shaved|sweet
🍨|cream|dessert|food|ice|restaurant|sweet
🍩|breakfast|dessert|donut|doughnut|food|sweet
🍪|chip|chocolate|cookie|dessert|sweet
🎂|bday|birthday|cake|celebration|dessert|happy|pastry|sweet
🍰|cake|dessert|pastry|shortcake|slice|sweet
🧁|bakery|cupcake|dessert|sprinkles|sugar|sweet|treat
🥧|apple|filling|fruit|meat|pastry|pie|pumpkin|slice
🍫|bar|candy|chocolate|dessert|halloween|sweet|tooth
🍬|candy|cavities|dessert|halloween|restaurant|sweet|tooth|wrapper
🍭|candy|dessert|food|lollipop|restaurant|sweet
🍮|custard|dessert|pudding|sweet
🍯|barrel|bear|food|honey|honeypot|jar|pot|sweet
🍼|babies|baby|birth|born|bottle|drink|infant|milk|newborn
🥛|drink|glass|milk
🫗|accident|drink|empty|glass|liquid|oops|pour|pouring|spill|water
☕|beverage|cafe|caffeine|chai|coffee|drink|hot|morning|steaming|tea
🍵|beverage|cup|drink|handle|oolong|tea|teacup
🧉|drink|mate
🍶|bar|beverage|bottle|cup|drink|restaurant|sake
🍾|bar|bottle|cork|drink|popping
🍷|alcohol|bar|beverage|booze|club|drink|drinking|drinks|glass|restaurant|wine
🍸|alcohol|bar|booze|club|cocktail|drink|drinking|drinks|glass|mad|martini|men
🍹|alcohol|bar|booze|club|cocktail|drink|drinking|drinks|drunk|mai|party|tai|tropical|tropics
🍺|alcohol|ale|bar|beer|booze|drink|drinking|drinks|mug|octoberfest|oktoberfest|pint|stein|summer
🍻|alcohol|bar|beer|booze|bottoms|cheers|clink|clinking|drinking|drinks|mugs
🥂|celebrate|clink|clinking|drink|glass|glasses
🥃|glass|liquor|scotch|shot|tumbler|whiskey|whisky
🥤|cup|drink|juice|malt|soda|soft|straw|water
🥢|chopsticks|hashi|jeotgarak|kuaizi
🍽️|cooking|dinner|eat|fork|knife|plate
🍴|breakfast|breaky|cooking|cutlery|delicious|dinner|eat|feed|food|fork|hungry|knife|lunch|restaurant|yum|yummy
🥄|eat|spoon|tableware
🗾|Japan|map
🏔️|cold|mountain|snow|snow-capped
⛰️|mountain
🌋|eruption|mountain|nature|volcano
🗻|fuji|mount|mountain|nature
🏕️|camping
🏖️|beach|umbrella
🏜️|desert
🏝️|desert|island
🏞️|national|park
🏟️|stadium
🏛️|building|classical
🏗️|building|construction|crane
🏘️|house|houses
🏚️|derelict|home|house
🏠|building|country|heart|home|house|ranch|settle|simple|suburban|suburbia|where
🏡|building|country|garden|heart|home|house|ranch|settle|simple|suburban|suburbia|where
🏢|building|city|cubical|job|office
🏣|building|Japanese|office|post
🏤|building|European|office|post
🏥|building|doctor|hospital|medicine
🏦|bank|building
🏨|building|hotel
🏩|building|hotel|love
🏪|24|building|convenience|hours|store
🏫|building|school
🏬|building|department|store
🏭|building|factory
🏯|building|castle|Japanese
🏰|building|castle|European
💒|chapel|hitched|nuptials|romance|wedding
🗼|Tokyo|tower
🗽|liberty|Liberty|new|ny|nyc|statue|Statue|york
⛪|bless|chapel|Christian|church|cross|religion
🕌|islam|masjid|mosque|Muslim|religion
🕍|Jew|Jewish|judaism|religion|synagogue|temple
⛩️|religion|shinto|shrine
🕋|hajj|islam|kaaba|Muslim|religion|umrah
⛲|fountain
⛺|camping|tent
🌁|fog|foggy
🌃|night|star|stars
🏙️|city|cityscape
🌄|morning|mountains|over|sun|sunrise
🌅|morning|nature|sun|sunrise
🌆|at|building|city|cityscape|dusk|evening|landscape|sun|sunset
🌇|building|dusk|sun|sunset
🌉|at|bridge|night
🎠|carousel|entertainment|horse
🎡|amusement|ferris|park|theme|wheel
🎢|amusement|coaster|park|roller|theme
🚂|caboose|engine|locomotive|railway|steam|train|trains|travel
🚃|car|electric|railway|train|tram|travel|trolleybus
🚄|high-speed|railway|shinkansen|speed|train
🚅|bullet|high-speed|nose|railway|shinkansen|speed|train|travel
🚆|arrived|choo|railway|train
🚇|metro|subway|travel
🚈|arrived|light|monorail|rail|railway
🚉|railway|station|train
🚊|tram|trolleybus
🚝|monorail|vehicle
🚞|car|mountain|railway|trip
🚋|bus|car|tram|trolley|trolleybus
🚌|bus|school|vehicle
🚍|bus|cars|oncoming
🚎|bus|tram|trolley|trolleybus
🚐|bus|drive|minibus|van|vehicle
🚑|ambulance|emergency|vehicle
🚒|engine|fire|truck
🚓|5–0|car|cops|patrol|police
🚔|car|oncoming|police
🚕|cab|cabbie|car|drive|taxi|vehicle|yellow
🚖|cab|cabbie|cars|drove|hail|oncoming|taxi|yellow
🚗|automobile|car|driving|vehicle
🚘|automobile|car|cars|drove|oncoming|vehicle
🚚|car|delivery|drive|truck|vehicle
🚛|articulated|car|drive|lorry|move|semi|truck|vehicle
🚜|tractor|vehicle
🏎️|car|racing|zoom
🏍️|motorcycle|racing
🛵|motor|scooter
🚲|bicycle|bike|class|cycle|cycling|cyclist|gang|ride|spin|spinning
🛴|kick|scooter
🚏|bus|busstop|stop
🛤️|railway|track|train
⛽|diesel|fuel|fuelpump|gas|gasoline|pump|station
🛞|car|circle|tire|turn|vehicle|wheel
🚨|alarm|alert|beacon|car|emergency|light|police|revolving|siren
🚥|horizontal|intersection|light|signal|stop|stoplight|traffic
🚦|drove|intersection|light|signal|stop|stoplight|traffic|vertical
🚧|barrier|construction
⚓|anchor|ship|tool
⛵|boat|resort|sailboat|sailing|sea|yacht
🚤|billionaire|boat|lake|luxury|millionaire|speedboat|summer|travel
🛳️|passenger|ship
⛴️|boat|ferry|passenger
🛥️|boat|motor|motorboat
🚢|boat|passenger|ship|travel
🛟|buoy|float|life|lifesaver|preserver|rescue|ring|safety|save|saver|swim
✈️|aeroplane|airplane|fly|flying|jet|plane|travel
🛩️|aeroplane|airplane|plane|small
🛫|aeroplane|airplane|check-in|departure|departures|plane
🛬|aeroplane|airplane|arrival|arrivals|arriving|landing|plane
💺|chair|seat
🚁|copter|helicopter|roflcopter|travel|vehicle
🚟|railway|suspension
🚠|cable|cableway|gondola|lift|mountain|ski
🚡|aerial|cable|car|gondola|ropeway|tramway
🛰️|satellite|space
🚀|launch|rocket|rockets|space|travel
🛸|aliens|extra|flying|saucer|terrestrial|UFO
🌌|milky|space|way
⛱️|ground|rain|sun|umbrella
🎆|boom|celebration|entertainment|fireworks|yolo
🎇|boom|celebration|fireworks|sparkle|sparkler
🎑|celebration|ceremony|moon|viewing
🗿|face|moai|moyai|statue|stoneface|travel
🛂|control|passport
🛃|customs|packing
🛄|arrived|baggage|bags|case|checked|claim|journey|packing|plane|ready|travel|trip
🛅|baggage|case|left|locker|luggage
🧗‍♂️|climb|climber|climbing|mountain|person|rock|scale|up male|man|sign
🧗‍♀️|climb|climber|climbing|mountain|person|rock|scale|up female|sign|woman
🏇|horse|jockey|racehorse|racing|riding|sport
⛷️|ski|skier|snow
🏂|ski|snow|snowboard|snowboarder|sport
🏌️‍♂️|ball|birdie|caddy|driving|golf|golfing|green|person|pga|putt|range|tee male|man|sign
🏌️‍♀️|ball|birdie|caddy|driving|golf|golfing|green|person|pga|putt|range|tee female|sign|woman
🏄‍♂️|beach|ocean|person|sport|surf|surfer|surfing|swell|waves male|man|sign
🏄‍♀️|beach|ocean|person|sport|surf|surfer|surfing|swell|waves female|sign|woman
🚣‍♂️|boat|canoe|cruise|fishing|lake|oar|paddle|person|raft|river|row|rowboat|rowing male|man|sign
🚣‍♀️|boat|canoe|cruise|fishing|lake|oar|paddle|person|raft|river|row|rowboat|rowing female|sign|woman
🏊‍♂️|freestyle|person|sport|swim|swimmer|swimming|triathlon male|man|sign
🏊‍♀️|freestyle|person|sport|swim|swimmer|swimming|triathlon female|sign|woman
⛹️‍♂️|athletic|ball|basketball|bouncing|championship|dribble|net|person|player|throw male|man|sign
⛹️‍♀️|athletic|ball|basketball|bouncing|championship|dribble|net|person|player|throw female|sign|woman
🏋️‍♂️|barbell|bodybuilder|deadlift|lifter|lifting|person|powerlifting|weight|weightlifter|weights|workout male|man|sign
🏋️‍♀️|barbell|bodybuilder|deadlift|lifter|lifting|person|powerlifting|weight|weightlifter|weights|workout female|sign|woman
🚴‍♂️|bicycle|bicyclist|bike|biking|cycle|cyclist|person|riding|sport male|man|sign
🚴‍♀️|bicycle|bicyclist|bike|biking|cycle|cyclist|person|riding|sport female|sign|woman
🚵‍♂️|bicycle|bicyclist|bike|biking|cycle|cyclist|mountain|person|riding|sport male|man|sign
🚵‍♀️|bicycle|bicyclist|bike|biking|cycle|cyclist|mountain|person|riding|sport female|sign|woman
🤸‍♂️|active|cartwheel|cartwheeling|excited|flip|gymnastics|happy|person|somersault male|man|sign
🤸‍♀️|active|cartwheel|cartwheeling|excited|flip|gymnastics|happy|person|somersault female|sign|woman
🤼‍♂️|combat|duel|grapple|people|ring|tournament|wrestle|wrestling male|man|sign
🤼‍♀️|combat|duel|grapple|people|ring|tournament|wrestle|wrestling female|sign|woman
🤽‍♂️|person|playing|polo|sport|swimming|water|waterpolo male|man|sign
🤽‍♀️|person|playing|polo|sport|swimming|water|waterpolo female|sign|woman
🤾‍♂️|athletics|ball|catch|chuck|handball|hurl|lob|person|pitch|playing|sport|throw|toss male|man|sign
🤾‍♀️|athletics|ball|catch|chuck|handball|hurl|lob|person|pitch|playing|sport|throw|toss female|sign|woman
🤹‍♂️|act|balance|balancing|handle|juggle|juggling|manage|multitask|person|skill male|man|sign
🤹‍♀️|act|balance|balancing|handle|juggle|juggling|manage|multitask|person|skill female|sign|woman
🧘‍♂️|cross|legged|legs|lotus|meditation|peace|person|position|relax|serenity|yoga|yogi|zen male|man|sign
🧘‍♀️|cross|legged|legs|lotus|meditation|peace|person|position|relax|serenity|yoga|yogi|zen female|sign|woman
🎪|circus|tent
🛹|board|skate|skateboard|skater|wheels
🎗️|celebration|reminder|ribbon
🎟️|admission|ticket|tickets
🎫|admission|stub|ticket
🎖️|award|celebration|medal|military
🏆|champion|champs|prize|slay|sport|trophy|victory|win|winning
🏅|award|gold|medal|sports|winner
🥇|1st|first|gold|medal|place
🥈|2nd|medal|place|second|silver
🥉|3rd|bronze|medal|place|third
⚽|ball|football|futbol|soccer|sport
⚾|ball|baseball|sport
🥎|ball|glove|softball|sports|underarm
🏀|ball|basketball|hoop|sport
🏐|ball|game|volleyball
🏈|american|ball|bowl|football|sport|super
🏉|ball|football|rugby|sport
🎾|ball|racquet|sport|tennis
🥏|disc|flying|ultimate
🎳|ball|bowling|game|sport|strike
🏏|ball|bat|cricket|game
🏑|ball|field|game|hockey|stick
🏒|game|hockey|ice|puck|stick
🥍|ball|goal|lacrosse|sports|stick
🏓|ball|bat|game|paddle|ping|pingpong|pong|table|tennis
🏸|badminton|birdie|game|racquet|shuttlecock
🪃|boomerang|rebound|repercussion|weapon
🥅|goal|net
⛳|flag|golf|hole|sport
🪁|fly|kite|soar
🛝|amusement|park|play|playground|playing|slide|sliding|theme
🏹|archer|archery|arrow|bow|Sagittarius|tool|weapon|zodiac
🎣|entertainment|fish|fishing|pole|sport
🤿 |diving|mask|scuba|snorkeling
🥊|boxing|glove
🥋|arts|judo|karate|martial|taekwondo|uniform
🎽|athletics|running|sash|shirt
🛼|blades|roller|skate|skates|sport
🛷|luge|sled|sledge|sleigh|snow|toboggan
⛸️|ice|skate|skating
🥌|curling|game|rock|stone
🎿|ski|skis|snow|sport
🎯|bull|bullseye|dart|direct|entertainment|game|hit|target
🎱|8|8ball|ball|billiard|eight|game|pool
🎮|controller|entertainment|game|video
🎰|casino|gamble|gambling|game|machine|slot|slots
🎲|dice|die|entertainment|game
🧩|clue|interlocking|jigsaw|piece|puzzle
♟️|chess|dupe|expendable|pawn
🎭|actor|actress|art|arts|entertainment|mask|performing|theater|theatre|thespian
🎨|art|artist|artsy|arty|colorful|creative|entertainment|museum|painter|painting|palette
🎼|music|musical|note|score
🎤|karaoke|mic|microphone|music|sing|sound
🎧|earbud|headphone|sound
🎷|instrument|music|sax|saxophone
🎸|guitar|instrument|music|strat
🎹|instrument|keyboard|music|musical|piano
🎺|instrument|music|trumpet
🎻|instrument|music|violin
🥁|drum|drumsticks|music
🎬|action|board|clapper|movie
💌|heart|letter|love|mail|romance|valentine
🕳️|hole
💣|bomb|boom|comic|dangerous|explosion|hot
🛀|bath|bathtub|person|taking|tub
🛌|bed|bedtime|good|goodnight|hotel|nap|night|person|sleep|tired|zzz
🏺|amphora|Aquarius|cooking|drink|jug|tool|weapon|zodiac
🗺️|map|world
🧭|compass|direction|magnetic|navigation|orienteering
🧱|brick|bricks|clay|mortar|wall
💈|barber|cut|fresh|haircut|pole|shave
🛢️|drum|oil
🛎️|bell|bellhop|hotel
⌛|done|hourglass|sand|time|timer
⏳|done|flowing|hourglass|hours|not|sand|timer|waiting|yolo
⌚|clock|time|watch
⏰|alarm|clock|hours|hrs|late|time|waiting
⏱️|clock|stopwatch|time
⏲️|clock|timer
🕰️|clock|mantelpiece|time
🌡️|thermometer|weather
🧨|dynamite|explosive|fire|firecracker|fireworks|light|pop|popping|spark
🎈|balloon|birthday|celebrate|celebration
🎉|awesome|birthday|celebrate|celebration|excited|hooray|party|popper|tada|woohoo
🎊|ball|celebrate|celebration|confetti|party|woohoo
🎎|celebration|doll|dolls|festival|Japanese
🎏|carp|celebration|streamer
🎐|bell|celebration|chime|wind
🪩|ball|dance|disco|glitter|mirror|party
🧧|envelope|gift|good|hóngbāo|lai|luck|money|red|see
🎀|celebration|ribbon
🎁|birthday|bow|box|celebration|christmas|gift|present|surprise|wrapped
🔮|ball|crystal|fairy|fairytale|fantasy|fortune|future|magic|tale|tool
🧿|amulet|bead|blue|charm|evil-eye|nazar|talisman
🪬|amulet|Fatima|fortune|guide|hamsa|hand|Mary|Miriam|palm|protect|protection
🕹️|game|joystick|video|videogame
🧸|bear|plaything|plush|stuffed|teddy|toy
🖼️|art|frame|framed|museum|painting|picture
🛍️|bag|bags|hotel|shopping
📿|beads|clothing|necklace|prayer|religion
💎|diamond|engagement|gem|jewel|money|romance|stone|wedding
📯|horn|post|postal
🎙️|mic|microphone|music|studio
🎚️|level|music|slider
🎛️|control|knobs|music
📻|entertainment|radio|tbt|video
📱|cell|communication|mobile|phone|telephone
📲|arrow|build|call|cell|communication|mobile|phone|receive|telephone
☎️|phone|telephone
📞|communication|phone|receiver|telephone|voip
📟|communication|pager
📠|communication|fax|machine
🔋|battery
🪫|battery|drained|electronic|energy|low|power
🔌|electric|electricity|plug
💻|computer|laptop|office|pc|personal
🖥️|computer|desktop|monitor
🖨️|computer|printer
⌨️|computer|keyboard
🖱️|computer|mouse
🖲️|computer|trackball
💽|computer|disk|minidisk|optical
💾|computer|disk|floppy
💿|blu-ray|CD|computer|disk|dvd|optical
📀|Blu-ray|cd|computer|disk|DVD|optical
🧮|abacus|calculation|calculator
🎥|bollywood|camera|cinema|film|hollywood|movie|record
🎞️|cinema|film|frames|movie
📽️|cinema|film|movie|projector|video
📺|television|tv|video
📷|camera|photo|selfie|snap|tbt|trip|video
📸|camera|flash|video
📹|camcorder|camera|tbt|video
📼|old|school|tape|vcr|vhs|video|videocassette
🔍|glass|lab|left|left-pointing|magnifying|science|search|tilted|tool
🔎|contact|glass|lab|magnifying|right|right-pointing|science|search|tilted|tool
🕯️|candle|light
💡|bulb|comic|electric|idea|light
🔦|electric|flashlight|light|tool|torch
🏮|bar|lantern|light|paper|red|restaurant
📔|book|cover|decorated|decorative|education|notebook|school|writing
📕|book|closed|education
📖|book|education|fantasy|knowledge|library|novels|open|reading
📗|book|education|fantasy|green|library|reading
📘|blue|book|education|fantasy|library|reading
📙|book|education|fantasy|library|orange|reading
📚|book|books|education|fantasy|knowledge|library|novels|reading|school|study
📓|notebook
📃|curl|document|page|paper
📜|paper|scroll
📄|document|facing|page|paper|up
📰|communication|news|newspaper|paper
🗞️|news|newspaper|paper|rolled|rolled-up
📑|bookmark|mark|marker|tabs
🔖|bookmark|mark
🏷️|label|tag
💰|bag|bank|bet|billion|cash|cost|dollar|gold|million|money|moneybag|paid|paying|pot|rich|win
💴|bank|banknote|bill|currency|money|note|yen
💵|bank|banknote|bill|currency|dollar|money|note
💶|100|bank|banknote|bill|currency|euro|money|note|rich
💷|bank|banknote|bill|billion|cash|currency|money|note|pound|pounds
💸|bank|banknote|bill|billion|cash|dollar|fly|million|money|note|pay|wings
💳|bank|card|cash|charge|credit|money|pay
🪪|card|credentials|document|ID|identification|license|security
🧾|accounting|bookkeeping|evidence|invoice|proof|receipt
✉️|e-mail|email|envelope|letter
📧|e-mail|email|letter|mail
📨|delivering|e-mail|email|envelope|incoming|letter|mail|receive|sent
📩|arrow|communication|down|e-mail|email|envelope|letter|mail|outgoing|send|sent
📤|box|email|letter|mail|outbox|sent|tray
📥|box|email|inbox|letter|mail|receive|tray|zero
📦|box|communication|delivery|package|parcel|shipping
📫|closed|communication|flag|mail|mailbox|postbox|raised
📪|closed|flag|lowered|mail|mailbox|postbox
📬|flag|mail|mailbox|open|postbox|raised
📭|flag|lowered|mail|mailbox|open|postbox
📮|mail|mailbox|postbox
🗳️|ballot|box
✏️|pencil
✒️|black|nib|pen
🖋️|fountain|pen
🖊️|ballpoint|pen
🖌️|paintbrush|painting
🖍️|crayon
📝|communication|media|memo|notes|pencil
📁|file|folder
📂|file|folder|open
🗂️|card|dividers|index
📅|calendar|date
📆|calendar|tear-off
🗒️|note|notepad|pad|spiral
🗓️|calendar|pad|spiral
📇|card|index|old|rolodex|school
📈|chart|data|graph|growth|increasing|right|trend|up|upward
📉|chart|data|decreasing|down|downward|graph|negative|trend
📊|bar|chart|data|graph
📋|clipboard|do|list|notes
📌|collage|pin|pushpin
📍|location|map|pin|pushpin|round
📎|paperclip
🖇️|link|linked|paperclip|paperclips
📏|angle|edge|math|ruler|straight|straightedge
📐|angle|math|rule|ruler|set|slide|triangle|triangular
✂️|cut|cutting|paper|scissors|tool
🗃️|box|card|file
🗄️|cabinet|file|filing|paper
🗑️|can|garbage|trash|waste|wastebasket
🔒|closed|lock|locked|private
🔓|cracked|lock|open|unlock|unlocked
🔏|ink|lock|locked|nib|pen|privacy
🔐|bike|closed|key|lock|locked|secure
🔑|key|keys|lock|major|password|unlock
🗝️|clue|key|lock|old
🔨|hammer|home|improvement|repairs|tool
⛏️|hammer|mining|pick|tool
⚒️|hammer|pick|tool
🛠️|hammer|spanner|tool|wrench
🔪|chef|cooking|hocho|kitchen|knife|tool|weapon
🗡️|dagger|knife|weapon
⚔️|crossed|swords|weapon
🔫|gun|handgun|pistol|revolver|tool|water|weapon
🛡️|shield|weapon
🔧|home|improvement|spanner|tool|wrench
🔩|bolt|home|improvement|nut|tool
⚙️|cog|cogwheel|gear|tool
🗜️|clamp|compress|tool|vice
⚖️|balance|justice|Libra|scale|scales|tool|weight|zodiac
🔗|link|links
⛓️|chain|chains
🧰|box|chest|mechanic|red|tool|toolbox
🧲|attraction|horseshoe|magnet|magnetic|negative|positive|shape|u
⚗️|alembic|chemistry|tool
🧪|chemist|chemistry|experiment|lab|science|test|tube
🧫|bacteria|biologist|biology|culture|dish|lab|petri
🧬|biologist|dna|evolution|gene|genetics|life
🔬|experiment|lab|microscope|science|tool
🩻|bones|doctor|medical|skeleton|skull|x-ray|xray
🔭|contact|extraterrestrial|science|telescope|tool
📡|aliens|antenna|contact|dish|satellite|science
💉|doctor|flu|medicine|needle|shot|sick|syringe|tool|vaccination
💊|doctor|drugs|medicated|medicine|pill|pills|sick|vitamin
🚪|back|closet|door|front
🛏️|bed|hotel|sleep
🛋️|couch|hotel|lamp
🚽|bathroom|toilet
🚿|shower|water
🛁|bath|bathtub
🧴|bottle|lotion|moisturizer|shampoo|sunscreen
🧷|diaper|pin|punk|rock|safety
🧹|broom|cleaning|sweeping|witch
🧺|basket|farming|laundry|picnic
🧻|paper|roll|toilet|towels
🧼|bar|bathing|clean|cleaning|lather|soap|soapdish
🧽|absorbing|cleaning|porous|soak|sponge
🧯|extinguish|extinguisher|fire|quench
🚬|cigarette|smoking
⚰️|coffin|dead|death|vampire
⚱️|ashes|death|funeral|urn
🚰|drinking|potable|water
💘|143|adorbs|arrow|cupid|date|emotion|heart|ily|love|romance|valentine
💝|143|anniversary|emotion|heart|ily|kisses|ribbon|valentine|xoxo
💖|143|emotion|excited|good|heart|ily|kisses|morning|night|sparkle|sparkling|xoxo
💗|143|emotion|excited|growing|heart|heartpulse|ily|kisses|muah|nervous|pulse|xoxo
💓|143|beating|cardio|emotion|heart|heartbeat|ily|love|pulsating|pulse
💞|143|adorbs|anniversary|emotion|heart|hearts|revolving
💕|143|anniversary|date|dating|emotion|heart|hearts|ily|kisses|love|loving|two|xoxo
💟|143|decoration|emotion|heart|hearth|purple|white
❣️|exclamation|heart|heavy|mark|punctuation
💔|break|broken|crushed|emotion|heart|heartbroken|lonely|sad
❤️‍🔥|emotion|heart|fire|fiery|love|red
❤️|emotion|heart|love|red
🧡|143|heart|orange
💛|143|cardiac|emotion|heart|ily|love|yellow
💚|143|emotion|green|heart|ily|love|romantic
💙|143|blue|emotion|heart|ily|love|romance
💜|143|bestest|emotion|heart|ily|love|purple
🖤|black|evil|heart|wicked
💯|100|a+|agree|clearly|definitely|faithful|fleek|full|hundred|keep|perfect|point|score|TRUE|truth|yup
💢|anger|angry|comic|mad|symbol|upset
💬|balloon|bubble|comic|dialog|message|sms|speech|talk|text|typing
👁️‍🗨️|1|body|eye|one balloon|bubble|dialog|left|speech
🗯️|anger|angry|balloon|bubble|mad|right
💭|balloon|bubble|cartoon|cloud|comic|daydream|decisions|dream|idea|invent|invention|realize|think|thoughts|wonder
💤|comic|good|goodnight|night|sleep|sleeping|sleepy|tired|zzz
♨️|hot|hotsprings|springs|steaming
🛑|octagonal|sign|stop
🕛|12|12
🕧|12|12
🕐|1|1
🕜|1|1
🕑|2|2
🕝|2|2
🕒|3|3
🕞|3|3
🕓|4|4
🕟|30|4|4
🕔|5|5
🕠|30|5|5
🕕|6|6
🕡|30|6|6
🕖|0|7|7
🕢|30|7|7
🕗|8|8
🕣|30|8|8
🕘|9|9
🕤|30|9|9
🕙|0|10|10
🕥|10|10
🕚|11|11
🕦|11|11
🌀|cyclone|dizzy|hurricane|twister|typhoon|weather
♠️|card|game|spade|suit
♥️|card|emotion|game|heart|hearts|suit
♦️|card|diamond|game|suit
♣️|card|club|clubs|game|suit
🃏|card|game|joker|wildcard
🀄|dragon|game|mahjong|red
🎴|card|cards|flower|game|Japanese|playing
🔇|mute|muted|quiet|silent|sound|speaker
🔈|low|soft|sound|speaker|volume
🔉|medium|sound|speaker|volume
🔊|high|loud|music|sound|speaker|volume
📢|address|communication|loud|loudspeaker|public|sound
📣|cheering|megaphone|sound
🔔|bell|break|church|sound
🔕|bell|forbidden|mute|no|not|prohibited|quiet|silent|slash|sound
🎵|music|musical|note|sound
🎶|music|musical|note|notes|sound
🏧|ATM|automated|bank|cash|money|sign|teller
🚮|bin|litter|litterbin|sign
♿|access|handicap|symbol|wheelchair
🩼|aid|cane|crutch|disability|help|hurt|injured|mobility|stick
🚹|bathroom|lavatory|man|men’s|restroom|room|toilet|WC
🚺|bathroom|lavatory|restroom|room|toilet|WC|woman|women’s
🚻|bathroom|lavatory|restroom|toilet|WC
🚼|baby|changing|symbol
🚾|bathroom|closet|lavatory|restroom|toilet|water|WC
⚠️|caution|warning
🚸|child|children|crossing|pedestrian|traffic
⛔|do|entry|fail|forbidden|no|not|pass|prohibited|traffic
🚫|entry|forbidden|no|not|prohibited|smoke
🚳|bicycle|bicycles|bike|forbidden|no|not|prohibited
🚭|forbidden|no|not|prohibited|smoke|smoking
🚯|forbidden|litter|littering|no|not|prohibited
🚱|dry|non-drinking|non-potable|prohibited|water
🚷|forbidden|no|not|pedestrian|pedestrians|prohibited
🔞|18|age|eighteen|forbidden|no|not|one|prohibited|restriction|underage
☢️|radioactive|sign
☣️|biohazard|sign
⬆️|arrow|cardinal|direction|north|up
↗️|arrow|direction|intercardinal|northeast|up-right
➡️|arrow|cardinal|direction|east|right
↘️|arrow|direction|down-right|intercardinal|southeast
⬇️|arrow|cardinal|direction|down|south
↙️|arrow|direction|down-left|intercardinal|southwest
⬅️|arrow|cardinal|direction|left|west
↖️|arrow|direction|intercardinal|northwest|up-left
↕️|arrow|up-down
↔️|arrow|left-right
↩️|arrow|curving|left|right
↪️|arrow|curving|left|right
⤴️|arrow|curving|right|up
⤵️|arrow|curving|down|right
🔃|arrow|arrows|clockwise|refresh|reload|vertical
🔄|again|anticlockwise|arrow|arrows|button|counterclockwise|deja|refresh|rewindershins|vu
🔙|arrow|BACK
🔚|arrow|END
🔛|arrow|mark|ON!
🔜|arrow|brb|omw|SOON
🔝|arrow|homie|TOP|up
🛐|place|pray|religion|worship
⚛️|atheist|atom|symbol
🕉️|Hindu|om|religion
✡️|David|Jew|Jewish|judaism|religion|star
☸️|Buddhist|dharma|religion|wheel
☯️|difficult|lives|religion|tao|taoist|total|yang|yin|yinyang
✝️|christ|Christian|cross|latin|religion
☦️|Christian|cross|orthodox|religion
☪️|crescent|islam|Muslim|ramadan|religion|star
☮️|healing|peace|peaceful|symbol
🕎|candelabrum|candlestick|hanukkah|jewish|judaism|menorah|religion
🔯|dotted|fortune|jewish|judaism|six-pointed|star
♈|Aries|horoscope|ram|zodiac
♉|bull|horoscope|ox|Taurus|zodiac
♊|Gemini|horoscope|twins|zodiac
♋|Cancer|crab|horoscope|zodiac
♌|horoscope|Leo|lion|zodiac
♍|horoscope|Virgo|zodiac
♎|balance|horoscope|justice|Libra|scales|zodiac
♏|horoscope|Scorpio|scorpion|Scorpius|zodiac
♐|archer|horoscope|Sagittarius|zodiac
♑|Capricorn|goat|horoscope|zodiac
♒|Aquarius|bearer|horoscope|water|zodiac
♓|fish|horoscope|Pisces|zodiac
⛎|bearer|Ophiuchus|serpent|snake|zodiac
🔀|arrow|button|crossed|shuffle|tracks
🔁|arrow|button|clockwise|repeat
🔂|arrow|button|clockwise|once|repeat|single
▶️|arrow|button|play|right|triangle
⏩|arrow|button|double|fast|fast-forward|forward
◀️|arrow|button|left|reverse|triangle
⏪|arrow|button|double|fast|reverse|rewind
🔼|arrow|button|red|up|upwards
⏫|arrow|button|double|fast|up
🔽|arrow|button|down|downwards|red
⏬|arrow|button|double|down|fast
⏹️|button|square|stop
⏏️|button|eject
🎦|camera|cinema|film|movie
🔅|brightness|button|dim|low
🔆|bright|brightness|button|light
📶|antenna|bar|bars|cell|communication|mobile|phone|signal|telephone
📳|cell|communication|mobile|mode|phone|telephone|vibration
📴|cell|mobile|off|phone|telephone
♾️|forever|infinity|unbounded|universal
♻️|recycle|recycling|symbol
🔱|anchor|emblem|poseidon|ship|tool|trident
📛|badge|name
🔰|beginner|chevron|green|Japanese|leaf|symbol|tool|yellow
⭕|circle|heavy|hollow|large|o|red
✅|✓|button|check|checked|checkmark|complete|completed|done|fixed|mark|tick
☑️|✓|ballot|box|check|checked|done|off|tick
✔️|✓|check|checked|checkmark|done|heavy|mark|tick
❌|×|cancel|cross|mark|multiplication|multiply|x
❎|×|button|cross|mark|multiplication|multiply|square|x
➕|+|plus
➖|-|−|heavy|math|minus|sign
➗|÷|divide|division|heavy|math|sign
✖️|×|cancel|multiplication|multiply|sign|x
🟰|answer|equal|equality|equals|heavy|math|sign
➰|curl|curly|loop
➿|curl|curly|double|loop
〽️|alternation|mark|part
✳️|*|asterisk|eight-spoked
✴️|*|eight-pointed|star
❇️|*|sparkle
‼️|!|!!|bangbang|double|exclamation|mark|punctuation
⁉️|!|!?|?|exclamation|interrobang|mark|punctuation|question
❓|?|mark|punctuation|question|red
❔|?|mark|outlined|punctuation|question|white
❕|!|exclamation|mark|outlined|punctuation|white
❗|!|exclamation|mark|punctuation|red
©️|C|copyright
®️|R|registered
™️|mark|TM|trade|trademark
#️⃣|Keycap Number Sign
0️⃣|Keycap Digit Zero
1️⃣|Keycap Digit One
2️⃣|Keycap Digit Two
3️⃣|Keycap Digit Three
4️⃣|Keycap Digit Four
5️⃣|Keycap Digit Five
6️⃣|Keycap Digit Six
7️⃣|Keycap Digit Seven
8️⃣|Keycap Digit Eight
9️⃣|Keycap Digit Nine
🔟|Keycap: 10
🔠|ABCD|input|latin|letters|uppercase
🔡|abcd|input|latin|letters|lowercase
🔢|1234|input|numbers
🔣|&|%|♪|〒|input|symbols
🔤|abc|alphabet|input|latin|letters
🅰️|blood|button|type
🆎|AB|blood|button|type
🅱️|B|blood|button|type
🆑|button|CL
🆒|button|COOL
🆓|button|FREE
ℹ️|I|information
🆔|button|ID|identity
Ⓜ️|circle|circled|M
🆕|button|NEW
🆖|button|NG
🅾️|blood|button|O|type
🆗|button|OK|okay
🅿️|button|P|parking
🆘|button|help|SOS
🆙|button|mark|UP|UP!
🆚|button|versus|VS
🈁|button|here|Japanese|katakana
🈂️|button|charge|Japanese|katakana|service
🈷️|amount|button|ideograph|Japanese|monthly
🈶|button|charge|free|ideograph|Japanese|not
🈯|button|ideograph|Japanese|reserved
🉐|bargain|button|ideograph|Japanese
🈹|button|discount|ideograph|Japanese
🈚|button|charge|free|ideograph|Japanese
🈲|button|ideograph|Japanese|prohibited
🉑|acceptable|button|ideograph|Japanese
🈸|application|button|ideograph|Japanese
🈴|button|grade|ideograph|Japanese|passing
🈳|button|ideograph|Japanese|vacancy
㊗️|button|congratulations|ideograph|Japanese
㊙️|button|ideograph|Japanese|secret
🈺|business|button|ideograph|Japanese|open
🈵|button|ideograph|Japanese|no|vacancy
🔴|circle|geometric|red
🔵|blue|circle|geometric
⚫|black|circle|geometric
⚪|circle|geometric|white
⬛|black|geometric|large|square
⬜|geometric|large|square|white
◼️|black|geometric|medium|square
◻️|geometric|medium|square|white
◾|black|geometric|medium-small|square
◽|geometric|medium-small|square|white
▪️|black|geometric|small|square
▫️|geometric|small|square|white
🔶|diamond|geometric|large|orange
🔷|blue|diamond|geometric|large
🔸|diamond|geometric|orange|small
🔹|blue|diamond|geometric|small
🔺|geometric|pointed|red|triangle|up
🔻|down|geometric|pointed|red|triangle
💠|comic|diamond|dot|geometric
🔳|button|geometric|outlined|square|white
🔲|black|button|geometric|square
🏁|checkered|chequered|finish|flag|flags|game|race|racing|sport|win
🚩|construction|flag|golf|post|triangular
🎌|celebration|cross|crossed|flags|Japanese
🏴|black|flag|waving
🏳️|flag|waving|white
🏳️‍🌈|flag|waving|white gay|genderqueer|glbt|glbtq|lesbian|lgbt|lgbtq|lgbtqia|nature|pride|queer|rain|rainbow|trans|transgender|weather
🏳️‍⚧️|flag|waving|white symbol|transgender
🏴‍☠️|black|flag|waving bone|crossbones|dead|death|face|monster|skull
🇦🇨|Flag: Ascension Island
🇦🇩|Flag: Andorra
🇦🇪|Flag: United Arab Emirates
🇦🇫|Flag: Afghanistan
🇦🇬|Flag: Antigua & Barbuda
🇦🇮|Flag: Anguilla
🇦🇱|Flag: Albania
🇦🇲|Flag: Armenia
🇦🇴|Flag: Angola
🇦🇶|Flag: Antarctica
🇦🇷|Flag: Argentina
🇦🇸|Flag: American Samoa
🇦🇹|Flag: Austria
🇦🇺|Flag: Australia
🇦🇼|Flag: Aruba
🇦🇽|Flag: Åland Islands
🇦🇿|Flag: Azerbaijan
🇧🇦|Flag: Bosnia & Herzegovina
🇧🇧|Flag: Barbados
🇧🇩|Flag: Bangladesh
🇧🇪|Flag: Belgium
🇧🇫|Flag: Burkina Faso
🇧🇬|Flag: Bulgaria
🇧🇭|Flag: Bahrain
🇧🇮|Flag: Burundi
🇧🇯|Flag: Benin
🇧🇱|Flag: St. Barthélemy
🇧🇲|Flag: Bermuda
🇧🇳|Flag: Brunei
🇧🇴|Flag: Bolivia
🇧🇶|Flag: Caribbean Netherlands
🇧🇷|Flag: Brazil
🇧🇸|Flag: Bahamas
🇧🇹|Flag: Bhutan
🇧🇻|Flag: Bouvet Island
🇧🇼|Flag: Botswana
🇧🇾|Flag: Belarus
🇧🇿|Flag: Belize
🇨🇦|Flag: Canada
🇨🇨|Flag: Cocos (Keeling) Islands
🇨🇩|Flag: Congo - Kinshasa
🇨🇫|Flag: Central African Republic
🇨🇬|Flag: Congo - Brazzaville
🇨🇭|Flag: Switzerland
🇨🇮|Flag: Côte d’Ivoire
🇨🇰|Flag: Cook Islands
🇨🇱|Flag: Chile
🇨🇲|Flag: Cameroon
🇨🇳|Flag: China
🇨🇴|Flag: Colombia
🇨🇵|Flag: Clipperton Island
🇨🇷|Flag: Costa Rica
🇨🇺|Flag: Cuba
🇨🇻|Flag: Cape Verde
🇨🇼|Flag: Curaçao
🇨🇽|Flag: Christmas Island
🇨🇾|Flag: Cyprus
🇨🇿|Flag: Czechia
🇩🇪|Flag: Germany
🇩🇬|Flag: Diego Garcia
🇩🇯|Flag: Djibouti
🇩🇰|Flag: Denmark
🇩🇲|Flag: Dominica
🇩🇴|Flag: Dominican Republic
🇩🇿|Flag: Algeria
🇪🇦|Flag: Ceuta & Melilla
🇪🇨|Flag: Ecuador
🇪🇪|Flag: Estonia
🇪🇬|Flag: Egypt
🇪🇭|Flag: Western Sahara
🇪🇷|Flag: Eritrea
🇪🇸|Flag: Spain
🇪🇹|Flag: Ethiopia
🇪🇺|Flag: European Union
🇫🇮|Flag: Finland
🇫🇯|Flag: Fiji
🇫🇰|Flag: Falkland Islands
🇫🇲|Flag: Micronesia
🇫🇴|Flag: Faroe Islands
🇫🇷|Flag: France
🇬🇦|Flag: Gabon
🇬🇧|Flag: United Kingdom
🇬🇩|Flag: Grenada
🇬🇪|Flag: Georgia
🇬🇫|Flag: French Guiana
🇬🇬|Flag: Guernsey
🇬🇭|Flag: Ghana
🇬🇮|Flag: Gibraltar
🇬🇱|Flag: Greenland
🇬🇲|Flag: Gambia
🇬🇳|Flag: Guinea
🇬🇵|Flag: Guadeloupe
🇬🇶|Flag: Equatorial Guinea
🇬🇷|Flag: Greece
🇬🇸|Flag: South Georgia & South Sandwich Islands
🇬🇹|Flag: Guatemala
🇬🇺|Flag: Guam
🇬🇼|Flag: Guinea-Bissau
🇬🇾|Flag: Guyana
🇭🇰|Flag: Hong Kong SAR China
🇭🇲|Flag: Heard & McDonald Islands
🇭🇳|Flag: Honduras
🇭🇷|Flag: Croatia
🇭🇹|Flag: Haiti
🇭🇺|Flag: Hungary
🇮🇨|Flag: Canary Islands
🇮🇩|Flag: Indonesia
🇮🇪|Flag: Ireland
🇮🇱|Flag: Israel
🇮🇲|Flag: Isle of Man
🇮🇳|Flag: India
🇮🇴|Flag: British Indian Ocean Territory
🇮🇶|Flag: Iraq
🇮🇷|Flag: Iran
🇮🇸|Flag: Iceland
🇮🇹|Flag: Italy
🇯🇪|Flag: Jersey
🇯🇲|Flag: Jamaica
🇯🇴|Flag: Jordan
🇯🇵|Flag: Japan
🇰🇪|Flag: Kenya
🇰🇬|Flag: Kyrgyzstan
🇰🇭|Flag: Cambodia
🇰🇮|Flag: Kiribati
🇰🇲|Flag: Comoros
🇰🇳|Flag: St. Kitts & Nevis
🇰🇵|Flag: North Korea
🇰🇷|Flag: South Korea
🇰🇼|Flag: Kuwait
🇰🇾|Flag: Cayman Islands
🇰🇿|Flag: Kazakhstan
🇱🇦|Flag: Laos
🇱🇧|Flag: Lebanon
🇱🇨|Flag: St. Lucia
🇱🇮|Flag: Liechtenstein
🇱🇰|Flag: Sri Lanka
🇱🇷|Flag: Liberia
🇱🇸|Flag: Lesotho
🇱🇹|Flag: Lithuania
🇱🇺|Flag: Luxembourg
🇱🇻|Flag: Latvia
🇱🇾|Flag: Libya
🇲🇦|Flag: Morocco
🇲🇨|Flag: Monaco
🇲🇩|Flag: Moldova
🇲🇪|Flag: Montenegro
🇲🇫|Flag: St. Martin
🇲🇬|Flag: Madagascar
🇲🇭|Flag: Marshall Islands
🇲🇰|Flag: North Macedonia
🇲🇱|Flag: Mali
🇲🇲|Flag: Myanmar (Burma)
🇲🇳|Flag: Mongolia
🇲🇴|Flag: Macau Sar China
🇲🇵|Flag: Northern Mariana Islands
🇲🇶|Flag: Martinique
🇲🇷|Flag: Mauritania
🇲🇸|Flag: Montserrat
🇲🇹|Flag: Malta
🇲🇺|Flag: Mauritius
🇲🇻|Flag: Maldives
🇲🇼|Flag: Malawi
🇲🇽|Flag: Mexico
🇲🇾|Flag: Malaysia
🇲🇿|Flag: Mozambique
🇳🇦|Flag: Namibia
🇳🇨|Flag: New Caledonia
🇳🇪|Flag: Niger
🇳🇫|Flag: Norfolk Island
🇳🇬|Flag: Nigeria
🇳🇮|Flag: Nicaragua
🇳🇱|Flag: Netherlands
🇳🇴|Flag: Norway
🇳🇵|Flag: Nepal
🇳🇷|Flag: Nauru
🇳🇺|Flag: Niue
🇳🇿|Flag: New Zealand
🇴🇲|Flag: Oman
🇵🇦|Flag: Panama
🇵🇪|Flag: Peru
🇵🇫|Flag: French Polynesia
🇵🇬|Flag: Papua New Guinea
🇵🇭|Flag: Philippines
🇵🇰|Flag: Pakistan
🇵🇱|Flag: Poland
🇵🇲|Flag: St. Pierre & Miquelon
🇵🇳|Flag: Pitcairn Islands
🇵🇷|Flag: Puerto Rico
🇵🇸|Flag: Palestinian Territories
🇵🇹|Flag: Portugal
🇵🇼|Flag: Palau
🇵🇾|Flag: Paraguay
🇶🇦|Flag: Qatar
🇷🇪|Flag: Réunion
🇷🇴|Flag: Romania
🇷🇸|Flag: Serbia
🇷🇺|Flag: Russia
🇷🇼|Flag: Rwanda
🇸🇦|Flag: Saudi Arabia
🇸🇧|Flag: Solomon Islands
🇸🇨|Flag: Seychelles
🇸🇩|Flag: Sudan
🇸🇪|Flag: Sweden
🇸🇬|Flag: Singapore
🇸🇭|Flag: St. Helena
🇸🇮|Flag: Slovenia
🇸🇯|Flag: Svalbard & Jan Mayen
🇸🇰|Flag: Slovakia
🇸🇱|Flag: Sierra Leone
🇸🇲|Flag: San Marino
🇸🇳|Flag: Senegal
🇸🇴|Flag: Somalia
🇸🇷|Flag: Suriname
🇸🇸|Flag: South Sudan
🇸🇹|Flag: São Tomé & Príncipe
🇸🇻|Flag: El Salvador
🇸🇽|Flag: Sint Maarten
🇸🇾|Flag: Syria
🇸🇿|Flag: Swaziland
🇹🇦|Flag: Tristan Da Cunha
🇹🇨|Flag: Turks & Caicos Islands
🇹🇩|Flag: Chad
🇹🇫|Flag: French Southern Territories
🇹🇬|Flag: Togo
🇹🇭|Flag: Thailand
🇹🇯|Flag: Tajikistan
🇹🇰|Flag: Tokelau
🇹🇱|Flag: Timor-Leste
🇹🇲|Flag: Turkmenistan
🇹🇳|Flag: Tunisia
🇹🇴|Flag: Tonga
🇹🇷|Flag: Turkey
🇹🇹|Flag: Trinidad & Tobago
🇹🇻|Flag: Tuvalu
🇹🇼|Flag: Taiwan
🇹🇿|Flag: Tanzania
🇺🇦|Flag: Ukraine
🇺🇬|Flag: Uganda
🇺🇲|Flag: U.S. Outlying Islands
🇺🇳|Flag: United Nations
🇺🇸|Flag: United States
🇺🇾|Flag: Uruguay
🇺🇿|Flag: Uzbekistan
🇻🇦|Flag: Vatican City
🇻🇨|Flag: St. Vincent & Grenadines
🇻🇪|Flag: Venezuela
🇻🇬|Flag: British Virgin Islands
🇻🇮|Flag: U.S. Virgin Islands
🇻🇳|Flag: Vietnam
🇻🇺|Flag: Vanuatu
🇼🇫|Flag: Wallis & Futuna
🇼🇸|Flag: Samoa
🇽🇰|Flag: Kosovo
🇾🇪|Flag: Yemen
🇾🇹|Flag: Mayotte
🇿🇦|Flag: South Africa
🇿🇲|Flag: Zambia
🇿🇼|Flag: Zimbabwe
''',
  'es': r'''
😀|cara|cara sonriendo|divertido|feliz|sonrisa
😃|cara|cara sonriendo con ojos grandes|divertido|risa|sonriendo
😄|abierta|cara|cara sonriendo con ojos sonrientes|ojo|sonrisa
😁|cara|cara radiante con ojos sonrientes|ojo|risa|sonrisa
😆|abierta|boca|cara|cara sonriendo con los ojos cerrados|risa
😅|cara|cara sonriendo con sudor frío|frío|risa|sudor
🤣|cara|cara revolviéndose de la risa|carcajada|ojos cerrados|risa
😂|cara|cara llorando de risa|felicidad|lágrima|risa
🙂|cara|cara sonriendo ligeramente|sonrisa
🙃|cara|cara al revés|revés
😉|cara|cara guiñando el ojo|guiño
😊|cara|cara feliz con ojos sonrientes|ojo|rubor|sonrisa
😇|ángel|cara|cara sonriendo con aureola|halo|sonrisa
🥰|adorar|amor|cara sonriendo con corazones|corazones|enamorada|enamorado
😍|amor|cara|cara sonriendo con ojos de corazón|corazón|sonrisa
🤩|cara|cara sonriendo con estrellas|estrellas|sonrisa
😘|beso|cara|cara lanzando un beso
😗|beso|cara|cara besando
☺️|cara|cara sonriente|contorno|relajado|sonrisa
😚|beso|cara|cara besando con los ojos cerrados|cerrado|ojo
😙|beso|cara|cara besando con ojos sonrientes|ojo|sonrisa
😋|cara|cara saboreando comida|delicioso|hambre|rico
😛|cara|cara sacando la lengua|lengua
😜|cara|cara sacando la lengua y guiñando un ojo|guiño|lengua|ojo
🤪|cara de loco|grande|ojo|pequeño
😝|cara|cara con ojos cerrados y lengua fuera|lengua|ojo|sabor
🤑|boca|cara|cara con lengua de dinero|dinero
🤗|abrazo|cara|cara con manos abrazando|sonrisa
🫣|cara tapada con ojo espiando|espiar|fascinado|mirar|vistazo
🤭|cara con mano sobre la boca|ostras|uy|vaya
🫢|alucinar|asombro|cara con ojos abiertos y boca tapada|increíble|sorpresa|vergüenza
🫡|cara saludando|ejército|orden|saludo|sí|sol|vale
🤫|callado|cara pidiendo silencio|silencio
🫠|calor|cara derritiéndose|derretido|derretirse|desaparecer|fundirse|líquido
🤔|cara|cara pensativa|duda|pensando
🤐|boca|cara|cara con la boca cerrada con cremallera|cremallera
🤨|cara con ceja alzada|desconfiado|escéptico
😐|cara|inexpresivo|neutral
🫤|cara con boca diagonal|decepción|decepcionado|escéptico|inseguro|jo|vaya
😑|cara|cara sin expresión|inexpresión|inexpresiva|inexpresivo
😶|boca|callado|cara|cara sin boca|silencio
🫥|cara con línea de puntos|depresivo|deprimido|desaparecer|esconderse|introvertido|invisible
😏|cara|cara sonriendo con superioridad|listillo|superioridad
😒|cara|cara de desaprobación|insatisfacción|rechazo
🙄|cara|cara con ojos en blanco|frustración|ojos|vueltos
😬|cara|cara haciendo una mueca|mueca
🤥|cara|cara de mentiroso|mentiroso|nariz|pinocho
😌|aliviado|cara|cara de alivio
😔|alicaído|cara|cara desanimada|desanimado|pensativo
🥹|cara aguantándose las lágrimas|emoción|emocionado|llorar|orgulloso|resistir|triste
😪|cara|cara de sueño|dormir|sueño
🤤|baba|babeando|cara
😴|cara|cara durmiendo|dormido|sueño|zzz
😷|cara|cara con mascarilla médica|enfermo|malo|máscara
🤒|cara|cara con termómetro|enfermo|malo|termómetro
🤕|cara|cara con la cabeza vendada|dolor|herida|venda
🤢|cara|cara de náuseas|náuseas|vomitar
🤮|cara vomitando|enfermo|malo|vomitar
🤧|cara|cara estornudando|estornudar|estornudo|pañuelo
🥵|calor|cara con calor|cara roja|fiebre|golpe de calor|sudor
🥶|cara con frío|cara congelada|congelado|frío|helado
🥴|atontado|cara de grogui|entonado|grogui|intoxicado|mareado
😵|cara|cara mareada|mareo
😵‍💫|cara con ojos en espiral|espiral|hipnotizado|indispuesto|mareado|mareo|problema
🤯|cabeza|cabeza explotando|explosión
🤠|cara|cara con sombrero de vaquero|sombrero|vaquera|vaquero
🥳|capirote|cara de fiesta|celebración|fiesta|gorro|matasuegras
😎|cara|cara sonriendo con gafas de sol|gafas|guay|sol
🤓|cara|cara de empollón|empollón|friki|friqui
🧐|aristocrático|cara con monóculo|estirado
😕|cara|cara de confusión|confuso
😟|cara|cara preocupada|preocupación|preocupado
🙁|cara|cara con el ceño ligeramente fruncido|ceño|fruncido
☹️|cara|cara con el ceño fruncido|ceño|fruncido
😮|boca|cara|cara con la boca abierta
😯|alucinado|cara|cara estupefacta|estupefacto|sorprendido
😲|alucinado|asombrado|cara|cara asombrada|pasmado
😳|cara|cara sonrojada|colorado|sonrojado
🥺|cara suplicante|implorar|ojos adorables|piedad|por favor
😦|boca abierta|cara|cara con el ceño fruncido y la boca abierta|ceño fruncido con boca abierta
😧|angustia|angustiado|cara|cara angustiada
😨|asustado|cara|cara asustada|miedo|miedoso
😰|ansiedad|cara|cara con ansiedad y sudor|frío|sudor
😥|aliviado|cara|cara triste pero aliviada|decepcionado|menos mal
😢|cara|cara llorando|lágrima|llorar|triste
😭|cara|cara llorando fuerte|lágrima|llorar|triste
😱|asustado|cara|cara gritando de miedo|miedo|pánico
😖|cara|cara de frustración|frustrado
😣|cara|cara desesperada|desesperación|frustración
😞|cara|cara decepcionada|decepción|decepcionado
😓|cara|cara con sudor frío|frío|sudor
😩|agotado|cansado|cara|cara agotada
😫|cansado|cara|cara cansada
😤|cabreo|cara|cara resoplando|enfado
😡|cabreo|cara|cara cabreada|enfadado|furia
😠|cara|cara enfadada|enfadado|histérico
🤬|cara con símbolos en la boca|maldecir|palabrota|símbolo
😈|cara|cara sonriendo con cuernos|cuernos|demonio|sonrisa
👿|cara|cara enfadada con cuernos|cuernos|demonio|diablo
💀|calavera|cara|cuento|monstruo|muerte
☠️|calavera|calavera y huesos cruzados|cara|huesos|muerte
💩|caca|caca con ojos|cómic|mierda|mojón
🤡|cara|cara de payaso|payaso
👹|cara|cuento|cuernos|demonio japonés oni|sonrisa
👺|cara|cuento|demonio japonés tengu|fantasía|monstruo|tengu
👻|cara|criatura|cuento|fantasma|monstruo
👽|alien|alienígena|cara|criatura|extraterrestre|ovni
👾|alien|cara|criatura|extraterrestre|monstruo alienígena|ovni
🤖|cara|monstruo|robot
🎃|calabaza|calabaza de Halloween|celebración|Halloween|linterna
😺|cara|feliz|gato alegre|gato feliz|gato sonriendo|sonrisa
😸|cara|gato|gato sonriendo con ojos sonrientes|ojos|sonriente|sonrisa
😹|cara|gato|gato llorando de risa|lágrima|risa
😻|cara|corazón|enamorado|gato|gato sonriendo con ojos de corazón
😼|cara|gato|gato haciendo una mueca|irónico|sonrisa
😽|beso|cara|cariñoso|gato|gato besando
🙀|cara|gato|gato asustado|pánico|preocupación|sorpresa
😿|cara|gato|gato llorando|lágrima|pena|triste
😾|cara|enfadado|gato
🫶|amor|manos formando un corazón
👋|agitar|mano|mano saludando|saludar|saludo
🤚|dorso|dorso de la mano|levantado|mano
🖐️|abierta|dedo|mano
✋|choca esos cinco|levantada|mano
🖖|mano|saludo|spock|vulcano
👌|aprobación|mano|ok|señal de aprobación con la mano
🤌|dedos|dedos juntos apuntando hacia arriba|gesto|italia|italiano|mano|sarcasmo
🤏|mano pellizcando|pellizco|poco|poquito
🫳|bajar|descartar|fuera|mano con la palma hacia abajo|no|quita|rechazar
🫴|acércate|dame|mano con la palma hacia arriba|ofrecer|trae|ven
✌️|mano|mano con señal de victoria|señal de victoria|victoria
🫰|amor|caro|chasquido|corazón|dinero|mano con dedo índice y pulgar cruzados
🤞|cruzar|dedos|dedos cruzados|mano|suerte
🤟|gesto de te quiero|mano|quiero
🤘|cuernos|dedo|mano|mano haciendo el signo de cuernos|rock
🤙|llamar|mano|mano haciendo el gesto de llamar|meñique|pulgar
👈|dedo|dorso de mano con índice a la izquierda|índice|izquierda|mano
👉|dedo|derecha|dorso de mano con índice a la derecha|índice|mano
👆|apuntar|arriba|dedo|dorso de mano con índice hacia arriba|mano
🖕|corazón|dedo|dedo corazón hacia arriba|mano|peineta
👇|abajo|apuntar|dedo|dorso de mano con índice hacia abajo|mano
☝️|apuntar|arriba|dedo|dedo índice hacia arriba|mano
👍|arriba|mano|pulgar|pulgar hacia arriba|señal
👎|abajo|mano|pulgar|pulgar hacia abajo|señal
✊|cerrado|mano|puñetazo|puño|puño en alto
👊|puñetazo|puño|puño cerrado
🤛|izquierda|puño|puño hacia la izquierda
🤜|derecha|puño|puño hacia la derecha
🫲|a la izquierda|izquierda|mano|mano hacia la izquierda
🫱|a la derecha|derecha|mano|mano hacia la derecha
👏|aplaudir|manos|manos aplaudiendo|palmas|señal
🙌|celebración|gesto|hurra|mano|manos levantadas celebrando
👐|abiertas|manos
🤲|oración|palmas hacia arriba juntas
🤝|acuerdo|apretón|apretón de manos|manos
🙏|gracias|mano|manos en oración|oración|orar|por favor|rezar
🫵|apuntar|dedo índice apuntándote a ti|ti|tú
✍️|escribir|lápiz|mano|mano escribiendo
💅|cosmética|esmalte|manicura|pintarse las uñas|uñas
🤳|autofoto|cámara|selfi|selfie|teléfono
💪|bíceps|cómic|flexionado|fuerte|músculo
🦵|extremidad|patada|pierna
🦶|patada|pie|pisotón
👂|cuerpo|oreja
👃|cuerpo|nariz
🧠|cerebro|inteligente
🦴|esqueleto|hueso
👀|cara|ojos
👁️|cuerpo|ojo
💋|beso|labios|marca de beso|romance
👄|boca|labios
🫦|ansioso|incómodo|labio mordido|ligar|miedo|nervioso|preocupado
🦷|dentista|diente|molar|muela
👅|cuerpo|lengua
👶|bebé|joven|niño
🧒|crío|género|infante|joven|neutro
👦|joven|niño
👧|chica|joven|niña
🧑|género|neutro|persona adulta
👨|adulto|hombre
🧔|barbas|barbudo|persona|persona con barba
👱|persona adulta rubia|rubia|rubias|rubio|rubios
👨‍🦰|adulto|hombre pelirrojo|pelo|rojizo|rojo
👨‍🦱|adulto|hombre afro|bucle|pelo rizado|rizado|rizo|tirabuzón
👨‍🦳|adulto|hombre blanco|cana|gris|pelo|viejo
👨‍🦲|adulto|hombre afeitado|bola de billar|calvo|quimioterapia|sin pelo
👩|adulta|mujer
👱‍♀️|persona adulta rubia|rubia|rubias|rubio|rubios mujer|signo|signo femenino|símbolo
👩‍🦰|adulta|mujer pelirrojo|pelo|rojizo|rojo
👩‍🦱|adulta|mujer afro|bucle|pelo rizado|rizado|rizo|tirabuzón
👩‍🦳|adulta|mujer blanco|cana|gris|pelo|viejo
👩‍🦲|adulta|mujer afeitado|bola de billar|calvo|quimioterapia|sin pelo
🧓|adulto|género neutro|género no especificado|maduro|mayor|persona mayor
👴|anciano|hombre|mayor
👵|anciana|mayor|mujer
🙍‍♂️|ceño|fruncido|gesto|persona|persona frunciendo el ceño hombre|signo|signo masculino|símbolo
🙍‍♀️|ceño|fruncido|gesto|persona|persona frunciendo el ceño mujer|signo|signo femenino|símbolo
🙎‍♂️|gesto|persona|persona haciendo pucheros|pucheros hombre|signo|signo masculino|símbolo
🙎‍♀️|gesto|persona|persona haciendo pucheros|pucheros mujer|signo|signo femenino|símbolo
🙅‍♂️|gesto|mano|no|persona haciendo el gesto de "no"|prohibido hombre|signo|signo masculino|símbolo
🙅‍♀️|gesto|mano|no|persona haciendo el gesto de "no"|prohibido mujer|signo|signo femenino|símbolo
🙆‍♂️|gesto|mano|OK|persona haciendo el gesto de "de acuerdo"|vale hombre|signo|signo masculino|símbolo
🙆‍♀️|gesto|mano|OK|persona haciendo el gesto de "de acuerdo"|vale mujer|signo|signo femenino|símbolo
💁‍♂️|información|mano|mostrador|persona|persona de mostrador de información hombre|signo|signo masculino|símbolo
💁‍♀️|información|mano|mostrador|persona|persona de mostrador de información mujer|signo|signo femenino|símbolo
🙋‍♂️|feliz|gesto|levantar|mano|persona con la mano levantada hombre|signo|signo masculino|símbolo
🙋‍♀️|feliz|gesto|levantar|mano|persona con la mano levantada mujer|signo|signo femenino|símbolo
🙇‍♂️|disculpa|gesto|perdón|persona haciendo una reverencia|reverencia hombre|signo|signo masculino|símbolo
🙇‍♀️|disculpa|gesto|perdón|persona haciendo una reverencia|reverencia mujer|signo|signo femenino|símbolo
🤦‍♂️|facepalm|frente|incredulidad|mano|persona con la mano en la frente hombre|signo|signo masculino|símbolo
🤦‍♀️|facepalm|frente|incredulidad|mano|persona con la mano en la frente mujer|signo|signo femenino|símbolo
🤷‍♂️|duda|encogerse|hombros|indiferencia|persona encogida de hombros hombre|signo|signo masculino|símbolo
🤷‍♀️|duda|encogerse|hombros|indiferencia|persona encogida de hombros mujer|signo|signo femenino|símbolo
👨‍⚕️|adulto|hombre asclepio|esculapio|medicina|serpiente|símbolo de medicina
👩‍⚕️|adulta|mujer asclepio|esculapio|medicina|serpiente|símbolo de medicina
👨‍🎓|estudiante|graduado|hombre|licenciado|universitario
👩‍🎓|estudiante|graduada|licenciada|mujer|universitaria
👨‍🏫|docente hombre|educador|hombre|instructor|maestro|profesor
👩‍🏫|docente mujer|educadora|instructora|maestra|mujer|profesora
👨‍⚖️|adulto|hombre balanza|justicia|libra|peso|zodiaco
👩‍⚖️|adulta|mujer balanza|justicia|libra|peso|zodiaco
👨‍🌾|agricultor|campo|granjero|hombre|labrador|profesional de la agricultura hombre
👩‍🌾|agricultora|campo|granjera|labradora|mujer|profesional de la agricultura mujer
👨‍🍳|chef|cocinero|hombre|pinche
👩‍🍳|chef|cocinera|mujer|pinche
👨‍🔧|electricista|fontanero|hombre|mecánico|operario|profesional de la mecánica hombre
👩‍🔧|electricista|fontanera|mecánica|mujer|operaria|profesional de la mecánica mujer
👨‍🏭|fábrica|montaje|obrero|operario|profesional industrial hombre|trabajador
👩‍🏭|fábrica|montaje|obrera|operaria|profesional industrial mujer|trabajadora
👨‍💼|director|ejecutivo|empresa|hombre|oficina|oficinista
👩‍💼|directora|ejecutiva|empresa|mujer|oficina|oficinista
👨‍🔬|biólogo|científico|físico|hombre|profesional de la ciencia hombre|químico
👩‍🔬|bióloga|científica|física|mujer|profesional de la ciencia mujer|química
👨‍💻|desarrollador|hombre|informático|profesional de la tecnología hombre|programador|tecnólogo
👩‍💻|desarrolladora|informática|mujer|profesional de la tecnología mujer|programadora|tecnóloga
👨‍🎤|artista|cantante hombre|estrella|hombre|rock
👩‍🎤|artista|cantante mujer|estrella|mujer|rock
👨‍🎨|artista hombre|hombre|paleta|pintor|pinturas
👩‍🎨|artista mujer|mujer|paleta|pintora|pinturas
👨‍✈️|adulto|hombre aeroplano|avión
👩‍✈️|adulta|mujer aeroplano|avión
👨‍🚀|astronauta|cohete|espacio|hombre
👩‍🚀|astronauta|cohete|espacio|mujer
👨‍🚒|apagafuegos|bombero|bombero hombre|camión|manguera
👩‍🚒|apagafuegos|bombera|bombera mujera|camión|manguera
👮‍♂️|agente|agente de policía|personas|policía hombre|signo|signo masculino|símbolo
👮‍♀️|agente|agente de policía|personas|policía mujer|signo|signo femenino|símbolo
🕵️‍♂️|cara|detective|espía hombre|signo|signo masculino|símbolo
🕵️‍♀️|cara|detective|espía mujer|signo|signo femenino|símbolo
💂‍♂️|guardia|guardia real británica hombre|signo|signo masculino|símbolo
💂‍♀️|guardia|guardia real británica mujer|signo|signo femenino|símbolo
👷‍♂️|casco|construcción|obrero|profesional de la construcción|trabajador hombre|signo|signo masculino|símbolo
👷‍♀️|casco|construcción|obrero|profesional de la construcción|trabajador mujer|signo|signo femenino|símbolo
🤴|corona|príncipe
👸|cuento|fantasía|hadas|princesa
👳‍♂️|persona con turbante|turbante hombre|signo|signo masculino|símbolo
👳‍♀️|persona con turbante|turbante mujer|signo|signo femenino|símbolo
👲|gorro|gua|gua pi mao|mao|persona|persona con gorro chino
🧕|hiyab|mujer con hiyab|pañuelo
🤵|esmoquin|novio|persona|persona con esmoquin
👰|boda|novia|persona|persona con velo|velo
🤰|embarazada|mujer
🤱|amamantar|bebé|dar pecho|lactancia materna|pecho
👼|ángel|bebé|cara|cuento
🎅|celebración|claus|cuento|fantasía|feliz|fiestas|Navidad|padre|Papá Noel|santa
🤶|celebración|claus|cuento|fantasía|feliz|fiestas|madre|Mamá Noel|Navidad|santa
🦸‍♂️|bien|héroe|heroína|personaje de superhéroe|superhéroe|superheroína|superpoder hombre|signo|signo masculino|símbolo
🦸‍♀️|bien|héroe|heroína|personaje de superhéroe|superhéroe|superheroína|superpoder mujer|signo|signo femenino|símbolo
🦹‍♂️|mal|personaje de supervillano|superpoder|supervillana|supervillano|villana|villano hombre|signo|signo masculino|símbolo
🦹‍♀️|mal|personaje de supervillano|superpoder|supervillana|supervillano|villana|villano mujer|signo|signo femenino|símbolo
🧙‍♂️|bruja|brujo|hechicera|hechicero|persona maga hombre|signo|signo masculino|símbolo
🧙‍♀️|bruja|brujo|hechicera|hechicero|persona maga mujer|signo|signo femenino|símbolo
🧚‍♂️|campanilla|hada|oberón|puck|titania hombre|signo|signo masculino|símbolo
🧚‍♀️|campanilla|hada|oberón|puck|titania mujer|signo|signo femenino|símbolo
🧛‍♂️|drácula|muerto viviente|no muerto|vampiro hombre|signo|signo masculino|símbolo
🧛‍♀️|drácula|muerto viviente|no muerto|vampiro mujer|signo|signo femenino|símbolo
🧜‍♂️|persona sirena|sirena|tritón hombre|signo|signo masculino|símbolo
🧜‍♀️|persona sirena|sirena|tritón mujer|signo|signo femenino|símbolo
🧝‍♂️|elfo|mágico hombre|signo|signo masculino|símbolo
🧝‍♀️|elfo|mágico mujer|signo|signo femenino|símbolo
🧞‍♂️|genio|lámpara hombre|signo|signo masculino|símbolo
🧞‍♀️|genio|lámpara mujer|signo|signo femenino|símbolo
🧟‍♂️|muerto viviente|no muerto|zombi hombre|signo|signo masculino|símbolo
🧟‍♀️|muerto viviente|no muerto|zombi mujer|signo|signo femenino|símbolo
💆‍♂️|cara|facial|masaje|persona recibiendo masaje|salón hombre|signo|signo masculino|símbolo
💆‍♀️|cara|facial|masaje|persona recibiendo masaje|salón mujer|signo|signo femenino|símbolo
💇‍♂️|belleza|corte|pelo|peluquero|persona cortándose el pelo hombre|signo|signo masculino|símbolo
💇‍♀️|belleza|corte|pelo|peluquero|persona cortándose el pelo mujer|signo|signo femenino|símbolo
🚶‍♂️|andar|caminando|caminar|persona caminando hombre|signo|signo masculino|símbolo
🚶‍♀️|andar|caminando|caminar|persona caminando mujer|signo|signo femenino|símbolo
🏃‍♂️|carrera|deporte|maratón|persona corriendo hombre|signo|signo masculino|símbolo
🏃‍♀️|carrera|deporte|maratón|persona corriendo mujer|signo|signo femenino|símbolo
🕺|bailar|hombre|hombre bailando
💃|bailar|mujer|mujer bailando
🕴️|levitar|negocios|persona|persona trajeada levitando|traje
👯‍♂️|bailar|fiesta|orejas de conejo|personas|personas con orejas de conejo hombre|signo|signo masculino|símbolo
👯‍♀️|bailar|fiesta|orejas de conejo|personas|personas con orejas de conejo mujer|signo|signo femenino|símbolo
🧖‍♂️|persona en una sauna|sauna|vapor hombre|signo|signo masculino|símbolo
🧖‍♀️|persona en una sauna|sauna|vapor mujer|signo|signo femenino|símbolo
🧘|meditación|persona en posición de loto|yoga
👭|lesbianas|mujeres|mujeres de la mano|novias|pareja
👫|hombre|hombre y mujer de la mano|mujer|mujer y hombre de la mano|novios|pareja
👬|gays|hombres|hombres de la mano|novios|pareja
💏|beso|personas|romance
👨‍❤️‍💋‍👨|adulto|hombre corazón|emoción|rojo beso|labios|marca de beso|romance adulto|hombre
👩‍❤️‍💋‍👩|adulta|mujer corazón|emoción|rojo beso|labios|marca de beso|romance adulta|mujer
💑|amor|pareja|pareja enamorada|personas enamoradas
👨‍❤️‍👨|adulto|hombre corazón|emoción|rojo adulto|hombre
👩‍❤️‍👩|adulta|mujer corazón|emoción|rojo adulta|mujer
👪|familia
👨‍👩‍👦|adulto|hombre adulta|mujer joven|niño
👨‍👩‍👧|adulto|hombre adulta|mujer chica|joven|niña
👨‍👩‍👧‍👦|adulto|hombre adulta|mujer chica|joven|niña joven|niño
👨‍👩‍👦‍👦|adulto|hombre adulta|mujer joven|niño joven|niño
👨‍👩‍👧‍👧|adulto|hombre adulta|mujer chica|joven|niña chica|joven|niña
👨‍👨‍👦|adulto|hombre adulto|hombre joven|niño
👨‍👨‍👧|adulto|hombre adulto|hombre chica|joven|niña
👨‍👨‍👧‍👦|adulto|hombre adulto|hombre chica|joven|niña joven|niño
👨‍👨‍👦‍👦|adulto|hombre adulto|hombre joven|niño joven|niño
👨‍👨‍👧‍👧|adulto|hombre adulto|hombre chica|joven|niña chica|joven|niña
👩‍👩‍👦|adulta|mujer adulta|mujer joven|niño
👩‍👩‍👧|adulta|mujer adulta|mujer chica|joven|niña
👩‍👩‍👧‍👦|adulta|mujer adulta|mujer chica|joven|niña joven|niño
👩‍👩‍👦‍👦|adulta|mujer adulta|mujer joven|niño joven|niño
👩‍👩‍👧‍👧|adulta|mujer adulta|mujer chica|joven|niña chica|joven|niña
👨‍👦|adulto|hombre joven|niño
👨‍👦‍👦|adulto|hombre joven|niño joven|niño
👨‍👧|adulto|hombre chica|joven|niña
👨‍👧‍👦|adulto|hombre chica|joven|niña joven|niño
👨‍👧‍👧|adulto|hombre chica|joven|niña chica|joven|niña
👩‍👦|adulta|mujer joven|niño
👩‍👦‍👦|adulta|mujer joven|niño joven|niño
👩‍👧|adulta|mujer chica|joven|niña
👩‍👧‍👦|adulta|mujer chica|joven|niña joven|niño
👩‍👧‍👧|adulta|mujer chica|joven|niña chica|joven|niña
🗣️|cabeza|cabeza parlante|cara|hablar|silueta
👤|busto|silueta|silueta de busto
👥|bustos|dos siluetas de bustos|siluetas
🫂|abrazo|adiós|despedida|gracias|personas abrazándose|saludo
👣|huellas|huellas de pies|pies
🧳|equipaje|maleta|viajar
🌂|accesorios|lluvia|paraguas|paraguas cerrado
☂️|lluvia|paraguas|paraguas abierto
🧵|aguja|carrete|coser|costura|hilo
🧶|bola|croché|ovillo|punto|tejer
👓|accesorios|gafas|ojo|ropa
🕶️|gafas|gafas de sol|ojo|oscuras|sol
🥽|gafas|gafas de protección|nadar|protección ocular|soldar
🥼|bata de laboratorio|científico|doctor|experimento|médico
👔|accesorio|corbata|ropa
👕|camiseta|ropa
👖|pantalones|ropa|vaqueros
🧣|abrigo|bufanda|cuello
🧤|guantes|mano
🧥|abrigo|chaquetón
🧦|calcetines|pies|ropa
👗|mujer|ropa|vestido
👘|japonés|kimono|ropa
👙|baño|bikini|playa|ropa
👚|blusa|camisa|femenina|ropa|ropa de mujer
👛|accesorios|cartera|complementos|monedero
👜|accesorios|bolso|complementos
👝|accesorios|bolso|bolso de mano|cartera|complementos
🎒|colegio|mochila|mochila escolar
👞|calzado|hombre|ropa|zapato|zapato de hombre
👟|calzado|correr|ropa|tenis|zapatilla deportiva
🥾|bota|bota de senderismo|camping|mochilero|senderismo
🥿|bailarina|calzado|zapato
👠|mujer|tacón|zapato|zapato de tacón
👡|calzado|mujer|ropa|sandalia|sandalia de mujer
👢|bota|bota de mujer|calzado|mujer|ropa
👑|accesorios|complementos|corona|reina|rey
👒|accesorio|mujer|ropa|sombrero|sombrero de mujer
🎩|chistera|copa|ropa|sombrero|sombrero de copa
🎓|birrete|celebración|gorro|graduación
🧢|béisbol|gorra|gorra con visera|visera
⛑️|ayuda|cara|casco|casco con una cruz blanca|cruz
💄|barra|cosmética|labios|maquillaje|pintalabios
💍|anillo|diamante
💼|cartera|documentos|maletín
🐶|cara|cara de perro|mascota|perro
🐱|cara|cara de gato|gato|mascota
🐭|cara|cara de ratón|ratón
🐹|cara|hámster|mascota
🐰|cara|cara de conejo|conejo|mascota
🦊|cara|zorro
🐻|cara|oso
🐼|cara|oso panda|panda
🐨|cara|koala|marsupial
🐯|cara|cara de tigre|tigre
🦁|cara|leo|león|zodiaco
🐮|cara|cara de vaca|vaca
🐷|cara|cara de cerdo|cerdo|gorrino
🐽|cara|cerdo|morro|nariz|nariz de cerdo
🐸|cara|rana
🐵|cara|cara de mono|mono
🙈|cara|mal|mono|mono con los ojos tapados|prohibido
🙉|cara|mal|mono|mono con los oídos tapados|prohibido
🙊|cara|mal|mono|mono con la boca tapada|prohibido
🐒|macaco|mono|simio
💥|colisión|cómic
💫|cómic|emoción|estrella|mareo|símbolo de mareo
💦|cómic|emoción|gotas de sudor|sudor
💨|carrera|cómic|correr|humo|salir corriendo
🦍|gorila|primate|simio
🐕|cachorro|perrete|perrito|perro
🐩|caniche|perrito|perro
🐺|cara|lobo
🦝|astuto|curioso|ladino|mapache|maquillaje|ojeras
🐈|gatete|gato|minino
🐅|felino|tigre
🐆|felino|leopardo
🐴|caballo|cara|cara de caballo
🐎|caballo|caballo de carreras|carreras de caballos|ecuestre
🦄|cara|unicornio
🦓|cebra|raya
🐂|buey|cabestro|tauro|zodiaco
🐃|agua|búfalo|búfalo de agua
🐄|bovino|res|vaca
🐖|cerdo|cochino|gorrino|puerco
🐗|cerdo salvaje|jabalí
🐏|aries|carnero|morueco|zodiaco
🐑|borrego|cordero|oveja|ovino
🐐|cabra|capricornio|caprino|chivo|zodiaco
🐪|camello|desierto|dromedario|joroba
🐫|bactriano|camello|desierto|dromedario|jorobas
🦙|alpaca|guanaco|lana|llama|vicuña
🦒|jirafa|manchas
🐘|elefante|paquidermo
🦏|paquidermo|rinoceronte
🦛|hipopótamo|paquidermo
🐁|ratón|roedor
🐀|rata|roedor
🐇|conejito|conejo|gazapo
🐿️|ardilla
🦔|erizo|espinas|púas
🦇|murciélago|vampiro
🦘|canguro|marsupial|saltar|salto
🦡|ratel|tejón|tejón de la miel|tejón melero
🐾|huellas|huellas de pezuñas|pezuñas
🦃|ave|pavo
🐔|ave|gallina|gallinácea|pollo
🐓|ave|gallina|gallinácea|gallo|pollo
🐣|ave|huevo|pollito|pollito rompiendo el cascarón|pollo
🐤|ave|pollito|pollo|polluelo
🐥|ave|pollito|pollito de frente|pollo
🐦|ave|pajarillo|pájaro
🐧|ave|pingüino
🕊️|ave|pájaro|paloma|paz
🦅|águila|ave
🦆|ave|pato
🦢|ave|cisne|patito feo
🦉|ave|búho|lechuza|pájaro
🦚|ave|orgulloso|pavo|pavo real|plumas
🦜|ave|hablar|loro|papagayo|pirata
🐊|caimán|cocodrilo
🐢|galápago|tortuga
🦎|lagartija|lagarto|reptil
🐍|culebra|reptil|serpiente|víbora
🐲|cara|cara de dragón|cuento|dragón|fantasía
🐉|cuento|dragón|fantasía
🦕|braquiosaurio|brontosaurio|diplodocus|saurópodo
🦖|t-rex|tiranosaurio|tiranosaurio rex
🧌|cuento de hadas|fantasía|monstruo|trol
🐳|ballena|ballena soltando un chorro|chorro de agua
🐋|ballena|cachalote|cetáceo
🐬|cetáceo|delfín
🐟|pececillo|pescado|pez|piscis|zodiaco
🐠|pez|tropical
🐡|globo|pez
🦈|pez|tiburón
🐙|cefalópodo|octópodo|pulpo
🪹|anidación|anidamiento|anidar|nido vacío
🪺|anidación|anidamiento|anidar|nido con huevos
🐚|caracola|concha|espiral
🪸|arrecife|coral|océano
🐌|caracol|caracola|molusco
🦋|bonito|insecto|mariposa
🐛|bicho|gusano|insecto
🐜|antenas|hormiga|insecto
🐝|abeja|insecto|miel
🐞|cochinilla|insecto|mariquita
🦗|grillo|saltamontes
🕷️|araña|insecto
🕸️|araña|tela|tela de araña|telaraña
🦂|escorpio|escorpión|zodiaco
🦟|fiebre|insecto|malaria|mosquito|virus
🦠|ameba|bacteria|germen|microbio|virus
💐|bouquet|flores|ramo|ramo de flores
🌸|cerezo|flor|flor de cerezo
💮|blanca|flor
🏵️|flor|planta|roseta
🪷|budismo|flor|hinduismo|loto|pureza
🌹|flor|rosa
🥀|flor|marchita|marchitada|marchitarse
🌺|flor|flor de hibisco|hibisco
🌻|flor|girasol|sol
🌼|flor
🌷|flor|tulipán
🌱|planta joven|plantón
🌲|árbol|árbol de hoja perenne|hoja perenne|perenne
🌳|árbol|árbol de hoja caduca|caducifolio|hoja caduca
🌴|árbol|árbol de palma|palmera
🌵|cactus|planta
🌾|arroz|espiga|espiga de arroz|planta
🌿|hierba|hoja|verde
☘️|planta|trébol
🍀|suerte|trébol|trébol de cuatro hojas
🍁|arce|hoja|hoja de arce
🍂|caída|hojas|hojas caídas
🍃|hoja|hojas revoloteando al viento|revolotear|soplar|viento
🍄|champiñón|hongo|seta
🌰|castaña|castaño|fruto seco
🦀|animal|cáncer|cangrejo|zodiaco
🦞|bogavante|langosta|marisco|pinzas
🦐|camarón|comida|gamba|langostino|marisco
🦑|calamar|comida|molusco
🌍|África|Europa|globo terráqueo mostrando Europa y África|mundo|planeta|Tierra
🌎|América|globo|globo terráqueo mostrando América|mundo|planeta|Tierra
🌏|Asia|Australia|globo terráqueo mostrando Asia y Australia|mundo|planeta|Tierra
🌐|globo|globo terráqueo con meridianos|meridianos|mundo|Tierra
🌑|luna|luna nueva|oscuridad
🌒|creciente|cuarto|espacio|luna
🌓|creciente|cuarto|espacio|luna|luna en cuarto creciente
🌔|creciente|gibosa|luna
🌕|llena|luna|plenilunio
🌖|gibosa|luna|menguante
🌗|cuarto|luna|luna en cuarto menguante|menguante
🌘|luna|menguante
🌙|creciente|espacio|luna
🌚|cara|espacio|luna|luna nueva con cara
🌛|cara|creciente|cuarto|espacio|luna|luna de cuarto creciente con cara
🌜|cara|creciente|cuarto|espacio|luna|luna de cuarto menguante con cara
☀️|espacio|rayos|sol|soleado
🌝|cara|llena|luna|luna llena con cara
🌞|brillante|cara|sol|sol con cara
⭐|estelar|estrella
🌟|brillante|estrella|resplandeciente
🌠|estrella|estrella fugaz|lluvia
☁️|nube|tiempo
⛅|nube|sol|sol con nubes|sol detrás de una nube
⛈️|lluvia|nube|nube con rayo y lluvia|trueno
🌤️|nube|sol|sol detrás de una nube pequeña
🌥️|nube|sol|sol detrás de una nube grande
🌦️|lluvia|nube|sol|sol detrás de una nube con lluvia
🌧️|lluvia|nube|nube con lluvia
🌨️|frío|nieve|nube|nube con nieve
🌩️|nube|nube con rayo|rayo
🌪️|nube|torbellino|tornado
🌫️|niebla|nube
🌬️|cara|cara de viento|nube|soplar|viento
🌈|arcoíris|colores|lluvia
☔|gotas|lluvia|paraguas|paraguas con gotas de lluvia
⚡|alto voltaje|electricidad|peligro|peligro de alto voltaje|señal de alto voltaje|voltaje
❄️|copo de nieve|frío|nieve
☃️|muñeco de nieve con nieve|nieve
⛄|muñeco de nieve|muñeco de nieve sin nieve|nieve
☄️|cometa|espacio|meteorito
🔥|fuego|llama
💧|agua|cómic|gota|sudor
🫧|bajo el agua|burbujas|eructar|jabón|limpiar
🌊|mar|océano|ola|ola de mar
🎄|abeto de Navidad|árbol|árbol de Navidad|celebración|Navidad
✨|*|bengala|chispas|estrellas
🎋|árbol|árbol de tanabata|celebración|festividad|tanabata
🎍|año nuevo japonés|bambú|celebración|decoración|decoración de pino|kadomatsu
🍇|agracejo|fruta|racimo|uva|uvas
🍈|fruta|melón
🍉|fruta|sandía
🍊|fruta|mandarina|naranja
🍋|cítrico|citrón|fruta|limón
🍌|banana|fruta|plátano
🍍|ananás|fruta|piña
🥭|fruta|mango|tropical
🍎|fruta|manzana|poma|roja
🍏|fruta|manzana|poma|verde
🍐|fruta|pera|perilla
🍑|durazno|fruta|melocotón
🍒|cereza|cerezas|fruta|guindas
🍓|fresa|fresón|fruta
🥝|comida|fruta|kiwi
🍅|ensalada|fruta|tomate|verdura
🥥|coco|palmera|piña colada
🥑|aguacate|comida|fruta
🍆|berenjena|fruto|verdura
🥔|comida|papa|patata|verdura
🥕|comida|verdura|zanahoria
🌽|espiga|espiga de maíz|maíz|mazorca|mijo
🌶️|chile|picante|planta
🥒|comida|pepinillo|pepino|verdura
🥬|bok choy|col|kale|lechuga|pak choi|verdura de hoja verde
🥦|brócoli|col|repollo
🥜|cacahuete|cacahuetes|comida|fruto seco|verdura
🫘|alubias|comida|habichuela roja|habichuelas|judía roja|judías|legumbre
🍞|pan|pan de molde|rebanada|tostada
🥐|bollo|comida|croissant|cruasán|francés
🥖|baguete|baguette|barra|comida|francés|pan
🥨|bretzel|galleta salada|pretzel
🥯|bagel|bocadillo|pan|panadería
🥞|comida|dulce|pancakes|postre|tortita|tortitas
🧀|cuña|cuña de queso|queso|trozo
🍖|carne|carne con hueso|hueso|restaurante
🍗|muslo|muslo de pollo|pollo|restaurante
🥩|carne|chuleta|corte de carne|filete
🥓|bacon|beicon|carne|comida|panceta
🍔|burger|hamburguesa
🍟|papas fritas|patatas|patatas fritas|restaurante
🍕|pizza|porción|restaurante
🌭|perrito|perrito caliente|salchicha
🥪|bocadillo|bocata|emparedado|sándwich
🌮|comida|mexicano|taco
🌯|burrito|comida|mexicano|tex mex|wrap
🥙|comida|durum|falafel|kebab|pan de pita|pan relleno
🍳|cocinar|freír|huevo|sartén
🥘|arroz|comida|paella
🍲|comida de olla|olla de comida|puchero|restaurante
🥣|cereal|cuenco con cuchara|desayuno
🥗|bol|comida|ensalada|verde
🍿|maíz|palomitas
🧂|condimento|sal|salero
🥫|comida enlatada|conserva|lata
🫙|almacenar|condimento|frasco|recipiente|salsa|tarro|vacío
🍱|bento|caja|caja de bento|comida|restaurante
🍘|arroz|galleta|galleta de arroz
🍙|arroz|bola de arroz|japonés|onigiri|restaurante
🍚|arroz|arroz cocido|restaurante
🍛|arroz|arroz con curry|curry|restaurante
🍜|fideos calientes|fideos chinos|fideos ramen|ramen|tazón de fideos
🍝|espagueti|pasta|restaurante
🍠|asada|papa asada|patata|restaurante
🍢|brocheta|japonés|marisco|oden|pincho
🍣|restaurante|sushi
🍤|frito|gamba|gamba frita|restaurante
🍥|comida japonesa|pastel|pastel de pescado japonés|pescado
🥮|festival|luna|otoño|pastel de luna|yuebing
🍡|dango|japonés|pincho|postre|restaurante
🥟|comida|dumpling|gyōza|jiaozi|masa
🥠|adivinación|galleta de la fortuna|profecía|superstición
🥡|caja para llevar|recipiente para llevar|restaurante
🍦|cucurucho|cucurucho de helado|dulce|helado|helado de cucurucho|restaurante
🍧|granizado hawaiano|helado|hielo|postre|raspado
🍨|helado|postre|sorbete
🍩|berlina|dónut|pastel|rosquilla
🍪|dulce|galleta|pasta|postre
🎂|celebración|cumpleaños|tarta|tarta de cumpleaños
🍰|pedazo de tarta|restaurante|tarta|trozo de tarta
🧁|cupcake|dulce|magdalena|repostería
🥧|masa|pastel|relleno
🍫|barra|chocolate|restaurante|tableta|tableta de chocolate
🍬|caramelo|chuche|chuchería|dulce|golosina
🍭|chuche|chuchería|dulce|golosina|piruleta
🍮|dulce|flan|postre|pudding
🍯|dulce|miel|tarro|tarro de miel
🍼|bebé|bibe|biberón|bibi|botella|leche
🥛|bebida|leche|vaso|vaso de leche
🫗|bebida|derramar|líquido derramándose|vacío|vaso|verter
☕|bebida|café|caliente|té
🍵|bebida|taza|tazón de té|té
🧉|bebida|infusión|mate
🍶|bar|bebida|botella|restaurante|sake|tazón
🍾|bar|beber|botella|botella descorchada|cava|corcho
🍷|bar|bebida|copa|copa de vino|vaso|vino
🍸|bar|cóctel|copa|copa de cóctel|restaurante
🍹|bar|bebida|restaurante|tropical
🍺|bar|cerveza|jarra|jarra de cerveza|restaurante
🍻|bar|cerveza|jarra|jarras|jarras de cerveza brindando|restaurante
🥂|bebida|brindar|brindis|celebración|copa|copas brindando
🥃|chupito|copa|licor|vaso|vaso de whisky|whisky
🥤|refresco|vaso con pajita|zumo
🥢|cubiertos|hashi|palillos
🍽️|cuchillo|cuchillo y tenedor con un plato|plato|restaurante|tenedor
🍴|cuchillo|restaurante|tenedor|tenedor y cuchillo
🥄|cubiertos|cuchara|cucharilla
🗾|Japón|mapa
🏔️|frío|montaña|montaña con nieve|nieve
⛰️|montaña|monte
🌋|erupción|erupción volcánica|volcán
🗻|Fuji|montaña|monte|naturaleza
🏕️|acampada|campamento|camping|vacaciones
🏖️|playa|playa y sombrilla|sombrilla
🏜️|arena|desierto
🏝️|desierta|isla
🏞️|nacional|parque
🏟️|estadio
🏛️|clásico|edificio
🏗️|construcción|edificio|obra
🏘️|casas|edificio|urbanización
🏚️|abandonada|casa|deshabitada|inhabitada|vacía
🏠|casa|vivienda
🏡|casa|casa con jardín|construcción|jardín|vivienda
🏢|construcción|edificio|edificio de oficinas|oficinas
🏣|correos|edificio|japón|oficina de correos|oficina de correos japonesa
🏤|correos|edificio|europa|oficina de correos|oficina de correos europea
🏥|doctor|edificio|hospital|medicina|médico
🏦|banca|banco|edificio
🏨|alojamiento|edificio|hotel|turismo
🏩|amor|edificio|hotel|hotel del amor
🏪|edificio|establecimiento|tienda 24 horas|tienda de comestibles
🏫|colegio|edificio|escuela
🏬|comercio|grandes almacenes
🏭|edificio|fábrica|industria
🏯|castillo|castillo japonés|construcción
🏰|castillo|castillo europeo|construcción
💒|boda|iglesia|iglesia celebrando boda|romance
🗼|Tokio|torre|Torre de Tokio
🗽|estatua|Estatua de la Libertad|libertad|nueva|ny|nyc|york
⛪|cristianismo|cruz|edificio|iglesia|religión
🕌|islam|mezquita|religión
🕍|judaísmo|religión|sinagoga
⛩️|japón|religión|santuario|santuario sintoísta|sintoísmo
🕋|hach|islam|Kaaba|musulmán|religión|umrah
⛲|fuente
⛺|campaña|camping|tienda|tienda de campaña|vacaciones
🌁|bruma|niebla
🌃|estrellas|noche|noche estrellada
🏙️|ciudad|edificio|paisaje|paisaje urbano
🌄|amanecer|amanecer sobre montañas|montaña|salida|sol
🌅|amanecer|salida del sol
🌆|atardecer|ciudad|ciudad al atardecer|edificios|paisaje
🌇|edificios|puesta del sol
🌉|noche|puente|puente de noche
🎠|caballo|caballo de tiovivo|entretenimiento|tiovivo
🎡|atracciones|entretenimiento|feria|noria|noria de feria
🎢|atracciones|entretenimiento|feria|montaña rusa|parque
🚂|locomotora|locomotora de vapor|tren|vehículo
🚃|ferrocarril|tranvía|tren eléctrico|vagón|vehículo
🚄|AVE|ferrocarril|rápido|tren|tren de alta velocidad|velocidad
🚅|bala|shinkansen|tren|vehículo|velocidad
🚆|ferrocarril|tren|vehículo
🚇|metro|subterráneo|suburbano|transporte
🚈|ferrocarril|transporte|tren|tren ligero
🚉|estación|estación de tren|tren
🚊|transporte|tranvía|trolebús
🚝|ferrocarril|monocarril|monorraíl|transporte|tren
🚞|ferrocarril|ferrocarril de montaña|montaña|vehículo
🚋|tranvía|vagón|vagón de tranvía|vehículo
🚌|autobús|bus|transporte
🚍|autobús|próximo|vehículo
🚎|transporte|tranvía|trolebús
🚐|autobús|bus|minibús|transporte
🚑|ambulancia|asistencia médica|transporte|vehículo
🚒|camión|camión de bomberos|coche de bomberos|fuego|vehículo
🚓|coche de policía|coche patrulla|policía|vehículo
🚔|coche de policía próximo|coche patrulla|policía|próximo|vehículo
🚕|coche|taxi|vehículo
🚖|taxi|taxi próximo|vehículo
🚗|automóvil|coche|vehículo
🚘|automóvil|coche|próximo|vehículo
🚚|camión de reparto|mercancías|reparto|transporte|vehículo
🚛|camión|camión articulado|tráiler|vehículo
🚜|agricultura|tractor|vehículo
🏎️|carreras|coche|coche de carreras
🏍️|carreras|moto|motocicleta|vehículo
🛵|escúter|moto|scooter
🚲|bici|bicicleta|vehículo
🛴|patinete
🚏|autobús|parada|parada de autobús
🛤️|tren|vía|vía de tren
⛽|bomba de gasolina|combustible|gasolina|surtidor|surtidor de gasolina
🛞|círculo|girar|neumático|rodar|rueda
🚨|coche de policía|luces|luces de policía|policía
🚥|luz|semáforo horizontal|señales de tráfico|tráfico
🚦|luz|semáforo|semáforo vertical|señales de tráfico|tráfico
🚧|construcción|obras|señal|señal de obras
⚓|ancla|barco|gancho
⛵|barco|barco de vela|velero|yate
🚤|barco|lancha motora|vehículo
🛳️|barco|barco de pasajeros|pasajeros|vehículo
⛴️|barco|ferri|ferry
🛥️|barco|barco a motor|motor|vehículo
🚢|barco|vehículo
🛟|flotador|rescate|salvavidas|seguridad|socorrista
✈️|aeroplano|avión
🛩️|avión|avioneta
🛫|aeroplano|avión|avión despegando|salida
🛬|aeroplano|avión|avión aterrizando|llegada
💺|asiento|asiento de transporte|plaza|silla
🚁|aspas|helicóptero|rotores|vehículo|volar
🚟|ferrocarril|ferrocarril de suspensión|suspensión|vehículo
🚠|cable|funicular|montaña|teleférico|teleférico de montaña|vehículo
🚡|aéreo|teleférico|tranvía|vehículo
🛰️|espacio|satélite|vehículo
🚀|cohete|espacio|vehículo
🛸|ovni|platillo volante
🌌|espacio|galaxia|láctea|vía
⛱️|arena|sol|sombrilla|sombrilla en la arena
🎆|celebración|fuegos artificiales
🎇|bengala|celebración|fuegos artificiales
🎑|celebración|ceremonia de contemplación de la luna|contemplación|luna|tsukimi
🗿|estatua|moái|Pascua
🛂|control|control de pasaportes|pasaportes
🛃|aduana
🛄|equipaje|maleta|recogida de equipajes
🛅|consigna|depósito|equipaje|servicio de equipaje en depósito
🧗‍♂️|alpinista|escalador|persona escalando hombre|signo|signo masculino|símbolo
🧗‍♀️|alpinista|escalador|persona escalando mujer|signo|signo femenino|símbolo
🏇|caballo|caballo de carreras|carrera de caballos|carreras|jinete
⛷️|esquí|esquiador|nieve|persona esquiando
🏂|nieve|practicante de snowboard|snowboard
🏌️‍♂️|golf|golfista|pelota|persona jugando al golf hombre|signo|signo masculino|símbolo
🏌️‍♀️|golf|golfista|pelota|persona jugando al golf mujer|signo|signo femenino|símbolo
🏄‍♂️|persona haciendo surf|surf|surfear hombre|signo|signo masculino|símbolo
🏄‍♀️|persona haciendo surf|surf|surfear mujer|signo|signo femenino|símbolo
🚣‍♂️|barca|bote|persona remando en un bote|remo hombre|signo|signo masculino|símbolo
🚣‍♀️|barca|bote|persona remando en un bote|remo mujer|signo|signo femenino|símbolo
🏊‍♂️|nadar|natación|persona nadando hombre|signo|signo masculino|símbolo
🏊‍♀️|nadar|natación|persona nadando mujer|signo|signo femenino|símbolo
⛹️‍♂️|balón|botar|pelota|persona botando un balón hombre|signo|signo masculino|símbolo
⛹️‍♀️|balón|botar|pelota|persona botando un balón mujer|signo|signo femenino|símbolo
🏋️‍♂️|halterofilia|levantador|persona levantando pesas|pesas|peso hombre|signo|signo masculino|símbolo
🏋️‍♀️|halterofilia|levantador|persona levantando pesas|pesas|peso mujer|signo|signo femenino|símbolo
🚴‍♂️|bicicleta|ciclismo|ciclista|persona en bicicleta hombre|signo|signo masculino|símbolo
🚴‍♀️|bicicleta|ciclismo|ciclista|persona en bicicleta mujer|signo|signo femenino|símbolo
🚵‍♂️|bicicleta|ciclista|montaña|mountain bike|persona en bicicleta de montaña hombre|signo|signo masculino|símbolo
🚵‍♀️|bicicleta|ciclista|montaña|mountain bike|persona en bicicleta de montaña mujer|signo|signo femenino|símbolo
🤸‍♂️|acrobacia|gimnasia|persona haciendo voltereta lateral|pirueta|rueda|voltereta hombre|signo|signo masculino|símbolo
🤸‍♀️|acrobacia|gimnasia|persona haciendo voltereta lateral|pirueta|rueda|voltereta mujer|signo|signo femenino|símbolo
🤼‍♂️|lucha|luchador|personas luchando hombre|signo|signo masculino|símbolo
🤼‍♀️|lucha|luchador|personas luchando mujer|signo|signo femenino|símbolo
🤽‍♂️|persona jugando al waterpolo|waterpolista|waterpolo hombre|signo|signo masculino|símbolo
🤽‍♀️|persona jugando al waterpolo|waterpolista|waterpolo mujer|signo|signo femenino|símbolo
🤾‍♂️|balonmanista|balonmano|persona jugando al balonmano hombre|signo|signo masculino|símbolo
🤾‍♀️|balonmanista|balonmano|persona jugando al balonmano mujer|signo|signo femenino|símbolo
🤹‍♂️|equilibrio|malabares|malabarismo|malabarista|persona haciendo malabares hombre|signo|signo masculino|símbolo
🤹‍♀️|equilibrio|malabares|malabarismo|malabarista|persona haciendo malabares mujer|signo|signo femenino|símbolo
🧘‍♂️|meditación|persona en posición de loto|yoga hombre|signo|signo masculino|símbolo
🧘‍♀️|meditación|persona en posición de loto|yoga mujer|signo|signo femenino|símbolo
🎪|carpa|carpa de circo|circo|entretenimiento
🛹|monopatín|skateboard|tabla
🎗️|conmemorativo|lazo
🎟️|acceso|admisión|entrada|entradas|evento
🎫|acceso|admisión|tique
🎖️|celebración|medalla|militar
🏆|premio|trofeo
🏅|medalla|medalla deportiva|premio
🥇|medalla|medalla de oro|oro|primero
🥈|medalla|medalla de plata|plata|segundo
🥉|bronce|medalla|medalla de bronce|tercero
⚽|balón|balón de fútbol|fútbol
⚾|balón|baseball|béisbol|pelota
🥎|bola|pelota|pelota de softball|softball
🏀|balón|balón de baloncesto|canasta|deporte
🏐|balón|juego|pelota|pelota de voleibol|voleibol
🏈|balón|balón de fútbol americano|deporte|fútbol americano
🏉|balón|balón de rugby|deporte|rugby
🎾|deporte|pelota|pelota de tenis|tenis
🥏|disco|disco volador|frisbee
🎳|bola|bola de bolos|bolos|juego
🏏|críquet|juego|pelota
🏑|hierba|hockey|hockey sobre hierba|juego|palo|pelota
🏒|disco|hielo|hockey|hockey sobre hielo|palo
🥍|bola|lacrosse|palo|pelota|raqueta
🏓|juego|mesa|pelota|ping pong|tenis de mesa
🏸|bádminton|pluma|raqueta|volante
🪃|boomerang|bumerán|rebotar
🥅|deporte|portería|red
⛳|banderín|banderín en hoyo|golf|hoyo
🪁|cometa|juguete|planear|viento|volar
🛝|jugar|parque|parque de atracciones|tobogán
🏹|arco|arco y flecha|arquero|flecha|sagitario|zodiaco
🎣|caña|caña de pescar|entretenimiento|esparcimiento|pesca|pez
🤿 |bucear|buzo|esnórquel|máscara|máscara de buceo|tubo
🥊|boxeo|deporte|guante|guante de boxeo
🥋|artes marciales|judo|kárate|taekwondo|uniforme de artes marciales
🎽|banda|camiseta con banda|camiseta de correr|camiseta sin mangas|deporte
🛼|patín|patín de 4 ruedas|patín de cuatro ruedas|patines
🛷|trineo
⛸️|hielo|patín|patín de hielo
🥌|juego|piedra de curling|roca
🎿|esquí|esquíes|esquís|nieve
🎯|blanco|diana|en el blanco|juego
🎱|8|billar|bola negra de billar|bola ocho|juego
🎮|juego|mando|mando de videoconsola|videojuego
🎰|juego|máquina|máquina tragaperras
🎲|dado|juego
🧩|conectar|pieza|pieza de puzle|pista|puzle|rompecabezas
♟️|ajedrez|peón|peón de ajedrez
🎭|actuación|arte|artes escénicas|entretenimiento|máscaras de teatro
🎨|arte|artista|paleta|paleta de pintor|pintura
🎼|música|partitura|pentagrama
🎤|entretenimiento|karaoke|micro|micrófono
🎧|auricular|cascos
🎷|instrumento|instrumento musical|música|saxo|saxofón
🎸|guitarra|instrumento|instrumento musical|música
🎹|instrumento|instrumento musical|música|piano|teclado|teclado musical
🎺|instrumento|instrumento musical|música|trompeta
🎻|instrumento|instrumento musical|música|violín
🥁|baquetas|música|tambor
🎬|cine|claqueta|claqueta de cine|entretenimiento|película
💌|amor|carta|carta de amor|corazón|correo
🕳️|agujero|orificio
💣|bomba|cómic|emoción
🛀|bañera|baño|persona|persona en la bañera
🛌|dormir|hotel|persona en la cama
🏺|acuario|ánfora|beber|jarra|zodiaco
🗺️|mapa|mapa mundial|mapamundi|mundo
🧭|brújula|compás|magnético|navegación|orientación
🧱|arcilla|cemento|ladrillo|muro|pared
💈|barbería|barbero|peluquero|poste|poste de barbero
🛢️|barril|barril de petróleo|bidón|petróleo
🛎️|botones|campanilla|hotel|timbre|timbre de hotel
⌛|arena|reloj|reloj de arena sin tiempo|temporizador
⏳|reloj con arena cayendo|reloj de arena con tiempo|temporizador
⌚|reloj
⏰|alarma|despertador|reloj
⏱️|cronómetro|reloj
⏲️|reloj|temporizador
🕰️|reloj|reloj de sobremesa|sobremesa
🌡️|temperatura|termómetro
🧨|dinamita|explosivo|fuegos artificiales|petardo
🎈|celebración|globo
🎉|cañón de confeti|celebración|confeti|fiesta
🎊|bola de confeti|celebración|confeti
🎎|celebración|festival|hinamatsuri|muñecas|muñecas japonesas
🎏|banderín|banderín de carpas|carpa|celebración|koinobori
🎐|campanilla|campanilla de viento|furin|viento
🪩|bailar|bola de espejos|brillar|disco|discoteca|fiesta
🧧|buena suerte|hóngbāo|lai see|regalo|sobre rojo
🎀|celebración|lazo
🎁|celebración|envoltorio|presente|regalo|regalo envuelto
🔮|adivinación|bola|bola de cristal|buena fortuna|cristal
🧿|amuleto|mal de ojo|nazar|ojo turco|talismán
🪬|amuleto|Fátima|hamsa|jamsa|mano|María|Miriam
🕹️|joystick|juego|mando|palanca|videojuego
🧸|juguete|osito de peluche|oso|peluche
🖼️|cuadro enmarcado|marco|museo
🛍️|bolsa|bolsas de compras|compra
📿|collar|cuentas|religión|rosario
💎|diamante|gema|joya|piedra|preciosa
📯|corneta|corneta de posta|posta
🎙️|estudio|micrófono|micrófono de estudio|música
🎚️|control|control de volumen|fader|volumen
🎛️|control|diales|música|potenciómetros|ruedas|ruedas de control
📻|radio
📱|celular|móvil|teléfono
📲|flecha|llamada|móvil|móvil con una flecha|recibir|teléfono
☎️|teléfono
📞|auricular de teléfono|comunicación|teléfono
📟|busca|comunicación|localizador
📠|comunicación|fax|máquina de fax
🔋|batería|pila
🪫|batería|batería baja|carga baja|electrónico|energía baja|pila
🔌|corriente|electricidad|eléctrico|enchufe
💻|ordenador|ordenador portátil|pc|personal
🖥️|ordenador|ordenador de sobremesa|sobremesa
🖨️|impresora|ordenador
⌨️|ordenador|teclado
🖱️|ordenador|ratón|ratón de ordenador
🖲️|bola de desplazamiento|ordenador|trackball
💽|disco|md|minidisc
💾|disco|disco de 3 1/2|disquete
💿|cd|disco|disco óptico
📀|disco|dvd
🧮|ábaco|cálculo|contar|matemáticas
🎥|cámara|cámara de cine|cine|entretenimiento|película
🎞️|cine|fotograma|fotograma de película|película
📽️|cine|película|proyector|proyector de cine
📺|televisión|tv
📷|cámara|cámara de fotos
📸|cámara|cámara con flash|flash
📹|cámara|vídeo|videocámara
📼|cinta|cinta de vídeo
🔍|buscar|lupa|lupa orientada hacia la izquierda
🔎|buscar|lupa|lupa orientada hacia la derecha
🕯️|luz|vela
💡|bombilla|cómic|electricidad|idea|luz
🔦|linterna|luz
🏮|izakaya|lámpara japonesa|lámpara roja|linterna izakaya|linterna japonesa|restaurante
📔|cuaderno|cuaderno con tapa decorativa|decoración|tapa
📕|cerrado|libro
📖|abierto|libro
📗|libro|verde
📘|azul|libro
📙|libro|naranja
📚|libro|libros
📓|cuaderno|libreta
📃|documento|página|página doblada
📜|pergamino|pergamino de papel
📄|anverso|documento|página|página hacia arriba
📰|diario|periódico
🗞️|noticias|papel|periódico|periódico enrollado
📑|marcadores|pestañas
🔖|marcador|marcapáginas
🏷️|etiqueta
💰|bolsa|bolsa de dinero|bolsa de dólares|dinero
💴|billete|billete de banco|billete de yen|dinero|yen
💵|billete|billete de banco|billete de dólar|dinero|dólar
💶|billete|billete de banco|billete de euro|dinero|euro
💷|billete de banco|billete de libra|dinero|libra
💸|billete|billete con alas|billete de banco|dinero|dinero con alas
💳|crédito|tarjeta|tarjeta de crédito
🪪|carné de conducir|carné de identidad|credenciales|identificación|permiso|seguridad
🧾|contabilidad|prueba|recibo|teneduría de libros|testimonio
✉️|carta|correo|sobre
📧|comunicación|correo|correo electrónico|sobre
📨|carta|comunicación|correo|correo electrónico|sobre|sobre entrante
📩|carta|comunicación|correo|correo electrónico|sobre|sobre con flecha
📤|bandeja|bandeja de salida|comunicación|correo|enviado|salida
📥|bandeja|bandeja de entrada|comunicación|correo|entrada|recibido
📦|caja|paquete
📫|bandera|buzón|buzón cerrado|buzón cerrado con la bandera levantada|con contenido
📪|bandera|buzón|buzón cerrado|buzón cerrado con la bandera bajada|vacío
📬|bandera|buzón|buzón abierto|buzón abierto con la bandera levantada|con contenido
📭|bandera|buzón|buzón abierto|buzón abierto con la bandera bajada|vacío
📮|buzón|cartas|correo
🗳️|papeleta|urna|urna con papeleta|voto
✏️|escolar|escribir|lapicero|lápiz
✒️|bolígrafo|escribir|pluma|pluma negra|tinta
🖋️|bolígrafo|escribir|estilográfica|pluma|tinta
🖊️|boli|bolígrafo|escribir
🖌️|pincel|pintar
🖍️|cera|lápiz|lápiz de cera
📝|comunicación|cuaderno de notas
📁|archivo|carpeta|carpeta de archivos
📂|abierta|archivo|carpeta|carpeta de archivos abierta
🗂️|fichas|fichero|separador|separador de fichas
📅|calendario|fecha
📆|calendario|calendario recortable|fecha
🗒️|bloc|bloc de notas de espiral|cuaderno|espiral|notas
🗓️|calendario|calendario de espiral|espiral
📇|cartera|ficha|organizador|organizador de fichas|tarjetas
📈|ascendente|gráfica|gráfica de evolución ascendente|gráfico|tendencia ascendente
📉|descendente|gráfica|gráfica de evolución descendente|gráfico|tendencia descendente
📊|barras|gráfico|gráfico de barras
📋|papeles|pinza|portapapeles|tabla
📌|chincheta|tachuela
📍|chincheta|chincheta redonda
📎|clip
🖇️|clips|unidos|unión
📏|regla
📐|escuadra|regla|regla triangular|triángulo
✂️|cortar|herramienta|tijeras
🗃️|archivador|archivador de tarjetas|archivo|caja
🗄️|archivador|archivos|oficina|organizador
🗑️|basura|cubo|papelera
🔒|candado|cerrado|cerrar
🔓|abierto|abrir|candado
🔏|candado|candado con pluma estilográfica|cerrado|estilográfica|pluma|privacidad
🔐|candado|candado cerrado y llave|cerrado|llave|seguro
🔑|contraseña|llave
🗝️|antigua|llave
🔨|herramienta|martillo
⛏️|herramienta|mina|pico
⚒️|herramienta|martillo|martillo y pico|pico
🛠️|herramienta|llave inglesa|martillo|martillo y llave inglesa
🔪|arma|cocinar|cuchillo|cuchillo de cocina
🗡️|arma|cuchillo|daga|puñal
⚔️|arma|cruzadas|espadas
🔫|agua|juguete|pistola|pistola de agua|verano
🛡️|defensa|escudo
🔧|herramienta|llave inglesa
🔩|herramienta|tornillo|tornillo y tuerca|tuerca
⚙️|engranaje|herramienta
🗜️|herramienta|tornillo|tornillo de banco
⚖️|balanza|justicia|libra|peso|zodiaco
🔗|eslabón
⛓️|cadena|cadenas
🧰|armario|caja de herramientas|herramienta|mecánico
🧲|atracción|herradura|imán|magnético
⚗️|alambique|herramienta|química
🧪|ciencia|experimento|laboratorio|química|químico|tubo de ensayo
🧫|bacterias|biología|biólogo|cultivo|laboratorio|placa de petri
🧬|adn|biólogo|evolución|gen|genética|vida
🔬|instrumento|laboratorio|microscopio
🩻|doctor|doctora|esqueleto|huesos|médico|radiografía|rayos
🔭|astronomía|instrumento|telescopio
📡|antena|antena de satélite|comunicación|satélite
💉|aguja|jeringa|jeringuilla|medicina|médico
💊|comprimido|medicina|médico|pastilla|píldora
🚪|puerta
🛏️|cama|dormir|hotel
🛋️|hotel|lámpara|sofá|sofá y lámpara
🚽|baño|inodoro|váter|wc
🚿|agua|baño|ducha
🛁|bañera|baño
🧴|bote de crema|champú|crema|hidratante|protector solar
🧷|imperdible|pañal|punk rock
🧹|barrer|bruja|escoba|fregar
🧺|cesta|colada|cosecha|pícnic
🧻|papel absorbente|papel higiénico|rollo de papel
🧼|bañarse|enjabonarse|jabón|jabonera|lavarse|pastilla
🧽|absorbente|esponja|limpiar|poroso
🧯|apagar|extinguir|extintor|incendio
🚬|cigarrillo|cigarro|fumar
⚰️|ataúd|muerte
⚱️|funeraria|muerte|urna
🚰|agua|potable
💘|amor|corazón|corazón con flecha|emoción|flecha
💝|corazón|corazón con lazo|emoción|lazo|san valentín
💖|amor|brillante|corazón brillante|emoción
💗|corazón|creciente|emocionado|latido|nervioso
💓|amor|corazón|corazón latiendo|emoción|latido
💞|corazón|corazones giratorios|giratorio
💕|amantes|amor|corazón|dos corazones
💟|adorno de corazón|corazón
❣️|corazón|exclamación|exclamación de corazón|puntuación
💔|corazón|emoción|partido|roto
❤️‍🔥|corazón|emoción|rojo|fuego|ardiente
❤️|corazón|emoción|rojo
🧡|corazón|emoción|naranja
💛|amarillo|corazón|emoción
💚|corazón|emoción|verde
💙|azul|corazón|emoción
💜|corazón|emoción|morado
🖤|corazón|negro
💯|100|cien puntos|pleno|puntos
💢|cómic|enfadado|enfado|símbolo de enfado
💬|bocadillo|bocadillo de diálogo|cómic|conversación|diálogo
👁️‍🗨️|cuerpo|ojo bocadillo|bocadillo de diálogo por la izquierda|burbuja|conversación|diálogo
🗯️|bocadillo|bocadillo de enfado por la derecha|cabreo|enfado|rabia
💭|bocadillo|bocadillo de pensamiento|burbuja|cómic|pensamiento
💤|cómic|dormir|símbolo de sueño|sueño|zzz
♨️|aguas termales|termas|vapor
🛑|octágono|parada|señal|señal de stop|stop
🕛|12 en punto|12
🕧|12
🕐|1 en punto|1
🕜|1
🕑|2 en punto|2
🕝|2
🕒|3 en punto|3
🕞|3
🕓|4 en punto|4
🕟|4
🕔|5 en punto|5
🕠|5
🕕|6 en punto|6
🕡|6
🕖|7 en punto|7
🕢|7
🕗|8 en punto|8
🕣|8
🕘|9 en punto|9
🕤|9
🕙|10 en punto|10
🕥|10
🕚|11 en punto|11
🕦|11
🌀|ciclón|mareo|tifón|tornado
♠️|carta|juego|palo|palo de picas|picas
♥️|carta|corazones|juego|palo|palo de corazones
♦️|carta|diamantes|juego|palo|palo de diamantes
♣️|carta|juego|palo|palo de tréboles|tréboles
🃏|comodín|joker
🀄|dragón rojo|dragón rojo de mahjong|juego|mahjong
🎴|carta|cartas de flores|flor|hanafuda|naipe japonés
🔇|altavoz|altavoz con marca de cancelación|altavoz silenciado|mute|silencio
🔈|altavoz a volumen bajo|volumen bajo
🔉|altavoz a volumen medio|altavoz con volumen medio|medio|volumen medio
🔊|altavoz|altavoz a volumen alto|alto|volumen alto
📢|altavoz|altavoz de mano|comunicación
📣|comunicación|megáfono
🔔|campana
🔕|campana|campana con signo de cancelación|cancelación|ruido
🎵|música|nota|nota musical
🎶|música|notas|notas musicales
🏧|atm|banco|cajero|señal de cajero automático
🚮|basura|papelera|señal|señal de usar papelera|tirar la basura en la papelera
♿|acceso|señal|silla|silla de ruedas|símbolo|símbolo de silla de ruedas
🩼|ayuda para la movilidad|bastón|discapacidad|lesión|muleta|palo
🚹|aseo de caballeros|aseo para hombres|baño|señal|señal con un hombre|servicio
🚺|aseo de señoras|baño|señal|señal con una mujer|señal de aseo para mujeres|servicio
🚻|aseos|señal de aseos|servicios|wc
🚼|bebé|cambiar|lactancia|señal de bebé
🚾|aseos|lavabo|servicios|WC
⚠️|advertencia|cuidado|señal
🚸|cruzando|niños|señal
⛔|dirección prohibida|no|prohibido|señal|señal de dirección prohibida
🚫|entrar|no|pasar|prohibición|prohibido
🚳|bicicleta|bicicletas prohibidas|prohibido|vehículo
🚭|fumar|no|prohibido|señal
🚯|basura|prohibido|prohibido tirar basura|señal|señal de no tirar basura
🚱|agua|agua no potable|no potable
🚷|peatón|peatones|prohibido|prohibido el paso de peatones|señal
🔞|18|no apto para menores|prohibido|prohibido para menores de 18 años|prohibido para menos de 18 años
☢️|radiactividad|radiactivo|radioactividad|radioactivo|señal
☣️|peligro|riesgo biológico|señal
⬆️|dirección|flecha|flecha arriba|flecha hacia arriba|norte
↗️|arriba|derecha|dirección|flecha|flecha hacia la esquina superior derecha|noreste
➡️|derecha|dirección|este|flecha|flecha hacia la derecha
↘️|abajo|derecha|dirección|flecha|flecha hacia la esquina inferior derecha|sudeste
⬇️|abajo|dirección|flecha|flecha hacia abajo|sur
↙️|abajo|dirección|flecha|flecha hacia la esquina inferior izquierda|izquierda|suroeste
⬅️|flecha|flecha hacia la izquierda|izquierda|oeste
↖️|arriba|dirección|flecha|flecha hacia la esquina superior izquierda|izquierda|noroeste
↕️|abajo|arriba|dirección|flecha|flecha arriba y abajo
↔️|derecha|dirección|flecha|flecha izquierda y derecha|izquierda
↩️|curva|dirección|flecha|flecha derecha curvándose a la izquierda|izquierda
↪️|curva|derecha|dirección|flecha|flecha izquierda curvándose a la derecha
⤴️|arriba|curva|dirección|flecha|flecha derecha curvándose hacia arriba
⤵️|abajo|curva|dirección|flecha|flecha derecha curvándose hacia abajo
🔃|flechas|flechas verticales en sentido horario|flechas verticales sentido horario|horario|señal de recarga
🔄|dirección|flechas|flechas en sentido antihorario|señal de recarga|sentido antihorario
🔙|atrás|atrás con flecha izquierda|back|flecha|flecha a la izquierda
🔚|final|final con flecha izquierda|flecha|flecha a la izquierda|flecha END
🔛|flecha|flecha de doble punta con la palabra "on" encima|flecha ON!|on|señal
🔜|flecha|soon|soon con flecha a la derecha
🔝|arriba|flecha hacia arriba|flecha TOP|top|top con flecha hacia arriba
🛐|culto|lugar de culto|religión
⚛️|átomo|símbolo|símbolo de átomo
🕉️|hindú|om|religión
✡️|David|estrella|judaísmo|judío|religión
☸️|budismo|dharma|religión|rueda|rueda del dharma
☯️|religión|taoísmo|yang|yin
✝️|cristianismo|cruz|cruz latina|religión
☦️|cruz|cruz ortodoxa|religión
☪️|estrella|islam|luna|media luna y estrella|religión
☮️|paz|símbolo de la paz
🕎|candelabro|menorá|religión
🔯|adivinación|buena fortuna|estrella|estrella de seis puntas|seis puntas
♈|Aries|carnero|horóscopo|zodiaco
♉|buey|horóscopo|Tauro|toro|zodiaco
♊|gemelos|Géminis|horóscopo|zodiaco
♋|Cáncer|cangrejo|horóscopo|zodiaco
♌|horóscopo|Leo|león|zodiaco
♍|horóscopo|Virgo|zodiaco
♎|balanza|escala|horóscopo|justicia|Libra|zodiaco
♏|Escorpio|escorpión|horóscopo|zodiaco
♐|arquero|horóscopo|Sagitario|zodiaco
♑|cabra|Capricornio|horóscopo|zodiaco
♒|Acuario|agua|horóscopo|zodiaco
♓|horóscopo|pescado|pez|Piscis|zodiaco
⛎|horóscopo|Ofiuco|portador|serpiente|zodiaco
🔀|cruzado|flechas|flechas entrecruzadas|reproducción aleatoria
🔁|flechas|repetición|repetir
🔂|flechas|repetición|repetir una vez|uno
▶️|botón de reproducción|flecha|reproducir|triángulo
⏩|avance rápido|avanzar|doble|flecha
◀️|izquierda|retroceso|triángulo
⏪|flecha|flecha doble a la izquierda|izquierda|rebobinado|rebobinar|retroceso rápido
🔼|arriba|botón|botón triángulo hacia arriba|triángulo|triángulo hacia arriba
⏫|arriba|flecha|triángulo doble hacia arriba
🔽|abajo|botón|botón triángulo hacia abajo|triángulo|triángulo hacia abajo
⏬|triángulo|triángulo doble abajo|triángulo doble hacia abajo
⏹️|botón|cuadrado|detener|parar
⏏️|botón|expulsar
🎦|cine|entretenimiento|película
🔅|bajo|brillo|señal de brillo bajo|tenue
🔆|alto|brillante|brillo|señal de brillo alto
📶|antena|barras de cobertura|celular|móvil|señal|teléfono
📳|modo vibración|móvil|teléfono|teléfono celular|vibración
📴|apagado|móvil|teléfono|teléfono celular
♾️|ilimitado|infinito|siempre|universal
♻️|reciclaje|reciclar|señal|símbolo de reciclaje|símbolo universal de reciclaje sólido|universal
🔱|ancla|emblema|emblema de tridente|tridente
📛|etiqueta|etiqueta identificativa|nombre
🔰|amarillo|japonés|principiante|símbolo japonés para principiante|verde
⭕|aro|círculo|círculo rojo hueco|o|rojo
✅|✓|botón|botón de marca de verificación|marca|selección|verificación
☑️|✓|casilla|casilla con marca de verificación|marca|selección|verificación
✔️|✓|marca|marca de verificación|selección|verificación
❌|×|cancelar|cruz|marca de cruz|marca de tachado|tachar|x
❎|×|botón con marca de cruz|casilla|cruz|marca|x
➕|+|más|signo|suma
➖|-|−|menos|resta|signo
➗|÷|división|signo|signo de división
✖️|×|cancelar|marca|multiplicación|prohibido|signo de multiplicación|x
🟰|equivalencia|igualdad|matemáticas|mates|signo igual grueso
➰|bucle|giro|tirabuzón
➿|bucle|doble
〽️|alternancia|marca|marca de alternancia
✳️|*|asterisco|asterisco de ocho puntas
✴️|*|estrella|estrella de ocho puntas
❇️|*|chispa
‼️|!!|exclamación|exclamación doble|puntuación|sorpresa
⁉️|!|!?|?|exclamación|exclamación e interrogación|interrogación
❓|?|interrogación|interrogación roja|pregunta|puntuación|signo de interrogación
❔|?|interrogación|interrogación blanca|pregunta|puntuación
❕|!|exclamación|exclamación blanca|puntuación
❗|!|exclamación|exclamación roja|puntuación|signo de exclamación
©️|c|copyright|símbolo
®️|marca registrada|r|símbolo de marca registrada
™️|marca comercial|símbolo de marca comercial
#️⃣|Keycap Number Sign
0️⃣|Keycap Digit Zero
1️⃣|Keycap Digit One
2️⃣|Keycap Digit Two
3️⃣|Keycap Digit Three
4️⃣|Keycap Digit Four
5️⃣|Keycap Digit Five
6️⃣|Keycap Digit Six
7️⃣|Keycap Digit Seven
8️⃣|Keycap Digit Eight
9️⃣|Keycap Digit Nine
🔟|Keycap: 10
🔠|abcd|letras|letras latinas mayúsculas|mayúsculas
🔡|abcd|letras|letras latinas minúsculas|minúsculas
🔢|1234|dígitos|números
🔣|〒♪&%|símbolos
🔤|ABC|alfabeto latino|latino
🅰️|A|grupo|sanguíneo|tipo A
🆎|AB|grupo|sanguíneo|tipo AB
🅱️|B|grupo|sanguíneo|tipo B
🆑|borrar|símbolo
🆒|botón|cool|mola
🆓|botón FREE|gratis|símbolo gratis
ℹ️|i|información
🆔|ID|identidad|símbolo de identificación|símbolo identidad
Ⓜ️|círculo|m|m en círculo
🆕|botón|NEW|nuevo
🆖|botón|ng|nuevo
🅾️|grupo sanguíneo|grupo sanguíneo tipo O|o
🆗|botón|ok
🅿️|aparcamiento|p|parking
🆘|ayuda|símbolo|símbolo de socorro|socorro|sos
🆙|arriba|botón UP!|información|novedad|símbolo|up
🆚|botón VS|contra|frente a|símbolo|versus|vs
🈁|“aquí”|ideograma japonés para "aquí"|japonés|katakana
🈂️|cortesía|ideograma japonés para "de cortesía"|japonés|katakana
🈷️|“cantidad mensual”|ideograma|ideograma japonés para "cantidad mensual"|japonés|kanji
🈶|“de pago”|ideograma|ideograma japonés para "de pago"|japonés|kanji
🈯|ideograma|ideograma japonés para "reservado"|japonés|kanji|reservado
🉐|ganga|ideograma|ideograma japonés para "ganga"|japonés|kanji
🈹|descuento|ideograma|ideograma japonés para "descuento"|japonés|kanji
🈚|gratis|ideograma|ideograma japonés para "gratis"|japonés|kanji
🈲|ideograma|ideograma japonés para "prohibido"|japonés|kanji|prohibido
🉑|aceptable|ideograma|ideograma japonés para "aceptable"|japonés|kanji
🈸|aplicación|ideograma|ideograma japonés para "aplicación"|japonés|kanji
🈴|aprobado|ideograma|ideograma japonés para "aprobado"|japonés|kanji
🈳|ideograma|ideograma japonés para "vacante"|japonés|kanji|vacante
㊗️|enhorabuena|ideograma|ideograma japonés para "enhorabuena"|japonés|kanji
㊙️|ideograma|ideograma japonés para "secreto"|japonés|kanji|secreto
🈺|abierto|ideograma|ideograma japonés para "abierto"|japonés|kanji
🈵|completo|ideograma|ideograma japonés para "completo"|japonés|kanji|lleno
🔴|círculo|geometría|rojo
🔵|azul|círculo|geometría
⚫|círculo|círculo negro|geometría
⚪|círculo|círculo blanco|geometría
⬛|cuadrado|cuadrado negro grande|geometría|negro
⬜|blanco|cuadrado|cuadrado blanco grande|geometría
◼️|cuadrado|cuadrado negro mediano|geometría|negro
◻️|blanco|cuadrado|cuadrado blanco mediano|geometría
◾|cuadrado|cuadrado negro mediano-pequeño|geometría|negro
◽|blanco|cuadrado|cuadrado blanco mediano-pequeño|geometría
▪️|cuadrado|cuadrado negro pequeño|geometría|negro
▫️|blanco|cuadrado|cuadrado blanco pequeño|geometría
🔶|geometría|naranja|rombo|rombo naranja grande
🔷|azul|geometría|rombo|rombo azul grande
🔸|geometría|naranja|rombo|rombo naranja pequeño
🔹|azul|geometría|rombo|rombo azul pequeño
🔺|geometría|rojo|triángulo|triángulo hacia arriba rojo|triángulo rojo hacia arriba
🔻|geometría|rojo|triángulo|triángulo hacia abajo rojo|triángulo rojo hacia abajo
💠|flor|geometría|rombo|rombo con pétalo
🔳|botón|botón cuadrado con borde blanco|cuadrado
🔲|botón|botón cuadrado con borde negro|cuadrado
🏁|bandera|bandera de cuadros|carreras|cuadros|deporte|motor
🚩|bandera|bandera de localización triangular|bandera informativa de localización|bandera triangular|localización
🎌|banderas|banderas cruzadas|celebración|japón
🏴|bandera|negra|ondear
🏳️|bandera|blanca|ondear
🏳️‍🌈|bandera|blanca|ondear arcoíris|colores|lluvia
🏳️‍⚧️|bandera|blanca|ondear símbolo de transgénero|transgénero
🏴‍☠️|bandera|negra|ondear calavera|calavera y huesos cruzados|cara|huesos|muerte
🇦🇨|Flag: Ascension Island
🇦🇩|Flag: Andorra
🇦🇪|Flag: United Arab Emirates
🇦🇫|Flag: Afghanistan
🇦🇬|Flag: Antigua & Barbuda
🇦🇮|Flag: Anguilla
🇦🇱|Flag: Albania
🇦🇲|Flag: Armenia
🇦🇴|Flag: Angola
🇦🇶|Flag: Antarctica
🇦🇷|Flag: Argentina
🇦🇸|Flag: American Samoa
🇦🇹|Flag: Austria
🇦🇺|Flag: Australia
🇦🇼|Flag: Aruba
🇦🇽|Flag: Åland Islands
🇦🇿|Flag: Azerbaijan
🇧🇦|Flag: Bosnia & Herzegovina
🇧🇧|Flag: Barbados
🇧🇩|Flag: Bangladesh
🇧🇪|Flag: Belgium
🇧🇫|Flag: Burkina Faso
🇧🇬|Flag: Bulgaria
🇧🇭|Flag: Bahrain
🇧🇮|Flag: Burundi
🇧🇯|Flag: Benin
🇧🇱|Flag: St. Barthélemy
🇧🇲|Flag: Bermuda
🇧🇳|Flag: Brunei
🇧🇴|Flag: Bolivia
🇧🇶|Flag: Caribbean Netherlands
🇧🇷|Flag: Brazil
🇧🇸|Flag: Bahamas
🇧🇹|Flag: Bhutan
🇧🇻|Flag: Bouvet Island
🇧🇼|Flag: Botswana
🇧🇾|Flag: Belarus
🇧🇿|Flag: Belize
🇨🇦|Flag: Canada
🇨🇨|Flag: Cocos (Keeling) Islands
🇨🇩|Flag: Congo - Kinshasa
🇨🇫|Flag: Central African Republic
🇨🇬|Flag: Congo - Brazzaville
🇨🇭|Flag: Switzerland
🇨🇮|Flag: Côte d’Ivoire
🇨🇰|Flag: Cook Islands
🇨🇱|Flag: Chile
🇨🇲|Flag: Cameroon
🇨🇳|Flag: China
🇨🇴|Flag: Colombia
🇨🇵|Flag: Clipperton Island
🇨🇷|Flag: Costa Rica
🇨🇺|Flag: Cuba
🇨🇻|Flag: Cape Verde
🇨🇼|Flag: Curaçao
🇨🇽|Flag: Christmas Island
🇨🇾|Flag: Cyprus
🇨🇿|Flag: Czechia
🇩🇪|Flag: Germany
🇩🇬|Flag: Diego Garcia
🇩🇯|Flag: Djibouti
🇩🇰|Flag: Denmark
🇩🇲|Flag: Dominica
🇩🇴|Flag: Dominican Republic
🇩🇿|Flag: Algeria
🇪🇦|Flag: Ceuta & Melilla
🇪🇨|Flag: Ecuador
🇪🇪|Flag: Estonia
🇪🇬|Flag: Egypt
🇪🇭|Flag: Western Sahara
🇪🇷|Flag: Eritrea
🇪🇸|Flag: Spain
🇪🇹|Flag: Ethiopia
🇪🇺|Flag: European Union
🇫🇮|Flag: Finland
🇫🇯|Flag: Fiji
🇫🇰|Flag: Falkland Islands
🇫🇲|Flag: Micronesia
🇫🇴|Flag: Faroe Islands
🇫🇷|Flag: France
🇬🇦|Flag: Gabon
🇬🇧|Flag: United Kingdom
🇬🇩|Flag: Grenada
🇬🇪|Flag: Georgia
🇬🇫|Flag: French Guiana
🇬🇬|Flag: Guernsey
🇬🇭|Flag: Ghana
🇬🇮|Flag: Gibraltar
🇬🇱|Flag: Greenland
🇬🇲|Flag: Gambia
🇬🇳|Flag: Guinea
🇬🇵|Flag: Guadeloupe
🇬🇶|Flag: Equatorial Guinea
🇬🇷|Flag: Greece
🇬🇸|Flag: South Georgia & South Sandwich Islands
🇬🇹|Flag: Guatemala
🇬🇺|Flag: Guam
🇬🇼|Flag: Guinea-Bissau
🇬🇾|Flag: Guyana
🇭🇰|Flag: Hong Kong SAR China
🇭🇲|Flag: Heard & McDonald Islands
🇭🇳|Flag: Honduras
🇭🇷|Flag: Croatia
🇭🇹|Flag: Haiti
🇭🇺|Flag: Hungary
🇮🇨|Flag: Canary Islands
🇮🇩|Flag: Indonesia
🇮🇪|Flag: Ireland
🇮🇱|Flag: Israel
🇮🇲|Flag: Isle of Man
🇮🇳|Flag: India
🇮🇴|Flag: British Indian Ocean Territory
🇮🇶|Flag: Iraq
🇮🇷|Flag: Iran
🇮🇸|Flag: Iceland
🇮🇹|Flag: Italy
🇯🇪|Flag: Jersey
🇯🇲|Flag: Jamaica
🇯🇴|Flag: Jordan
🇯🇵|Flag: Japan
🇰🇪|Flag: Kenya
🇰🇬|Flag: Kyrgyzstan
🇰🇭|Flag: Cambodia
🇰🇮|Flag: Kiribati
🇰🇲|Flag: Comoros
🇰🇳|Flag: St. Kitts & Nevis
🇰🇵|Flag: North Korea
🇰🇷|Flag: South Korea
🇰🇼|Flag: Kuwait
🇰🇾|Flag: Cayman Islands
🇰🇿|Flag: Kazakhstan
🇱🇦|Flag: Laos
🇱🇧|Flag: Lebanon
🇱🇨|Flag: St. Lucia
🇱🇮|Flag: Liechtenstein
🇱🇰|Flag: Sri Lanka
🇱🇷|Flag: Liberia
🇱🇸|Flag: Lesotho
🇱🇹|Flag: Lithuania
🇱🇺|Flag: Luxembourg
🇱🇻|Flag: Latvia
🇱🇾|Flag: Libya
🇲🇦|Flag: Morocco
🇲🇨|Flag: Monaco
🇲🇩|Flag: Moldova
🇲🇪|Flag: Montenegro
🇲🇫|Flag: St. Martin
🇲🇬|Flag: Madagascar
🇲🇭|Flag: Marshall Islands
🇲🇰|Flag: North Macedonia
🇲🇱|Flag: Mali
🇲🇲|Flag: Myanmar (Burma)
🇲🇳|Flag: Mongolia
🇲🇴|Flag: Macau Sar China
🇲🇵|Flag: Northern Mariana Islands
🇲🇶|Flag: Martinique
🇲🇷|Flag: Mauritania
🇲🇸|Flag: Montserrat
🇲🇹|Flag: Malta
🇲🇺|Flag: Mauritius
🇲🇻|Flag: Maldives
🇲🇼|Flag: Malawi
🇲🇽|Flag: Mexico
🇲🇾|Flag: Malaysia
🇲🇿|Flag: Mozambique
🇳🇦|Flag: Namibia
🇳🇨|Flag: New Caledonia
🇳🇪|Flag: Niger
🇳🇫|Flag: Norfolk Island
🇳🇬|Flag: Nigeria
🇳🇮|Flag: Nicaragua
🇳🇱|Flag: Netherlands
🇳🇴|Flag: Norway
🇳🇵|Flag: Nepal
🇳🇷|Flag: Nauru
🇳🇺|Flag: Niue
🇳🇿|Flag: New Zealand
🇴🇲|Flag: Oman
🇵🇦|Flag: Panama
🇵🇪|Flag: Peru
🇵🇫|Flag: French Polynesia
🇵🇬|Flag: Papua New Guinea
🇵🇭|Flag: Philippines
🇵🇰|Flag: Pakistan
🇵🇱|Flag: Poland
🇵🇲|Flag: St. Pierre & Miquelon
🇵🇳|Flag: Pitcairn Islands
🇵🇷|Flag: Puerto Rico
🇵🇸|Flag: Palestinian Territories
🇵🇹|Flag: Portugal
🇵🇼|Flag: Palau
🇵🇾|Flag: Paraguay
🇶🇦|Flag: Qatar
🇷🇪|Flag: Réunion
🇷🇴|Flag: Romania
🇷🇸|Flag: Serbia
🇷🇺|Flag: Russia
🇷🇼|Flag: Rwanda
🇸🇦|Flag: Saudi Arabia
🇸🇧|Flag: Solomon Islands
🇸🇨|Flag: Seychelles
🇸🇩|Flag: Sudan
🇸🇪|Flag: Sweden
🇸🇬|Flag: Singapore
🇸🇭|Flag: St. Helena
🇸🇮|Flag: Slovenia
🇸🇯|Flag: Svalbard & Jan Mayen
🇸🇰|Flag: Slovakia
🇸🇱|Flag: Sierra Leone
🇸🇲|Flag: San Marino
🇸🇳|Flag: Senegal
🇸🇴|Flag: Somalia
🇸🇷|Flag: Suriname
🇸🇸|Flag: South Sudan
🇸🇹|Flag: São Tomé & Príncipe
🇸🇻|Flag: El Salvador
🇸🇽|Flag: Sint Maarten
🇸🇾|Flag: Syria
🇸🇿|Flag: Swaziland
🇹🇦|Flag: Tristan Da Cunha
🇹🇨|Flag: Turks & Caicos Islands
🇹🇩|Flag: Chad
🇹🇫|Flag: French Southern Territories
🇹🇬|Flag: Togo
🇹🇭|Flag: Thailand
🇹🇯|Flag: Tajikistan
🇹🇰|Flag: Tokelau
🇹🇱|Flag: Timor-Leste
🇹🇲|Flag: Turkmenistan
🇹🇳|Flag: Tunisia
🇹🇴|Flag: Tonga
🇹🇷|Flag: Turkey
🇹🇹|Flag: Trinidad & Tobago
🇹🇻|Flag: Tuvalu
🇹🇼|Flag: Taiwan
🇹🇿|Flag: Tanzania
🇺🇦|Flag: Ukraine
🇺🇬|Flag: Uganda
🇺🇲|Flag: U.S. Outlying Islands
🇺🇳|Flag: United Nations
🇺🇸|Flag: United States
🇺🇾|Flag: Uruguay
🇺🇿|Flag: Uzbekistan
🇻🇦|Flag: Vatican City
🇻🇨|Flag: St. Vincent & Grenadines
🇻🇪|Flag: Venezuela
🇻🇬|Flag: British Virgin Islands
🇻🇮|Flag: U.S. Virgin Islands
🇻🇳|Flag: Vietnam
🇻🇺|Flag: Vanuatu
🇼🇫|Flag: Wallis & Futuna
🇼🇸|Flag: Samoa
🇽🇰|Flag: Kosovo
🇾🇪|Flag: Yemen
🇾🇹|Flag: Mayotte
🇿🇦|Flag: South Africa
🇿🇲|Flag: Zambia
🇿🇼|Flag: Zimbabwe
''',
  'fr': r'''
😀|content|dents|émoticône|grand sourire|heureux|joyeux|rire|sourire|super|visage|visage rieur|visage très souriant
😃|content|dents|émoticône|formidable|grand sourire|heureux|sourire|super|visage souriant avec de grands yeux|visage très souriant avec la bouche ouverte
😄|content|émoticône|grand sourire|heureux|joyeux|lol|mdr|rire|sourire|sourire mignon|visage|visage avec la bouche ouverte et les yeux souriants|visage très souriant aux yeux rieurs
😁|content|dents|émoticône|grand sourire|heureux|sourire|sourire de toutes ses dents|super|visage|visage souriant aux yeux rieurs|visage souriant avec yeux souriants|yeux souriants
😆|ahah|bouche|content|émoticône|lol|mdr|rire|sourire|visage|visage souriant avec bouche ouverte et yeux fermés|visage souriant avec yeux plissés
😅|émoticône|excité|froid|goutte|sourire|sourire nerveux|stressé|sueur|sueurs froides|visage souriant avec une goutte de sueur
🤣|content|drôle|émoticône|hilare|joyeux|larmes|lol|mdr|pleurer de rire|rire|rire aux larmes|se rouler par terre|se rouler par terre de rire|se tordre de rire|visage|visage qui rit aux larmes
😂|content|émoticône|heureux|joie|larmes|lol|mdr|pleurer de joie|pleurer de rire|rire aux larmes|sourire|visage riant aux larmes
🙂|content|émoticône|heureux|léger sourire|sourire|visage avec un léger sourire|visage souriant
🙃|émoticône|incroyable|renversée|tête|tête à l’envers|visage
😉|blague|clin d’œil|émoticône|flirter|plaisanter|sexy|visage|visage faisant un clin d’œil
😊|content|émoticône|heureux|œil|rougir|satisfait|sourire|visage|visage qui rougit|visage souriant avec yeux rieurs|visage souriant avec yeux souriants|yeux
😇|ange|angélique|auréole|béni|Bible|émoticône|heureux|innocent|paix|sourire|spirituel|visage|visage souriant avec auréole|visage souriant avec une auréole
🥰|adorer|aimer|amour|amoureuse|amoureux|béguin|coeur|coeurs|cœurs|j’adore|Je t’aime|romance|smiley avec 3 coeurs|sourire|visage souriant avec cœurs
😍|amour|amoureux|cœur|émoticône|œil|romantique|sourire|visage|visage souriant avec yeux en forme de cœur|yeux
🤩|étoile|étoiles dans les yeux|grand sourire|heureux|pressé|surexcité|tête avec étoiles|visage|visage avec des étoiles à la place des yeux|wow|yeux
😘|amour|baiser|bise|bisou|bisou et cœur|bonjour|bonne nuit|cœur|embrasser|émoticône|je t’aime|visage envoyant un bisou|visage qui fait une bise avec un cœur
😗|amour|baiser|bise|bisou|embrasser|émoticône|je t’aime|petit bisou|visage faisant un bisou|visage qui fait une bise
☺️|content|décontracté|détendu|émoticône|heureux|sourire|visage souriant|visage souriant avec les yeux fermés
😚|baiser|bise|bisou|bisou les yeux fermés|embrasser|émoticône|rougir|visage faisant un bisou avec les yeux fermés|visage qui fait une bise avec les yeux fermés|visage rougissant|yeux fermés
😙|amour|baiser|bise|bisou|embrasser|émoticône|gros bisou|je t’aime|sourire|visage aux yeux rieurs faisant un bisou|visage aux yeux souriants qui fait une bise|yeux fermés
😋|bon|content|délicieux|émoticône|faim|heureux|langue|manger|miam|savourer|sourire|visage souriant qui tire la langue
😛|cool|émoticône|génial|langue|super|visage|visage qui tire la langue
😜|amusant|blague|clin d’œil|émoticône|fou|langue|loufoque|marrant|œil|rigolo|visage|visage qui tire la langue et fait un clin d’œil
🤪|grand|large|oeil|œil|petit|tête de fou|tête folle|yeux|yeux fous
😝|dégoûtant|émoticône|goût|horrible|langue|œil|omd|on ne vit qu’une fois|peu importe|visage|visage qui tire la langue et ferme les yeux|visage qui tire la langue les yeux plissés|yeux fermés
🤑|argent|argent dans les yeux et la bouche|bouche|dollars|émoticône|yeux
🤗|câlin|émoticône|gentil|mains|visage|visage qui fait un câlin
🫣|captivé|effrayé|fasciné|jeter un coup d’œil|regarder fixement|se cacher|timide|visage qui regarde entre ses doigts
🤭|malin|oops|oups|rigole|secret|surprise|visage avec main devant la bouche|visage avec une main sur la bouche
🫢|choqué|embarrassé|étonné|gêné|impressionné|stupéfait|surpris|visage avec yeux ouverts et main sur la bouche
🫡|armée|bonne chance|compris|OK|oui|respect|salut|visage qui fait un salut militaire
🤫|chut|pas un bruit|silence|tête qui dit chut|visage avec un doigt sur la bouche
🫠|disparaître|fondre|gêne|liquéfié|liquide|sarcasme|se dissoudre|visage qui fond
🤔|émoticône|hum|méditer|penser|réfléchir|réflexion|visage|visage en pleine réflexion
🤐|bouche|bouche cousue|émoticône|fermeture éclair|motus|se taire|secret|visage|visage avec bouche cousue|visage avec bouche fermeture éclair
🤨|euh|hein|incrédule|méfiant|pas vrai|quoi|sceptique|surprise|tête avec sourcil levé|visage avec les sourcils relevés
😐|émoticône|gêné|neutre|ni chaud ni froid|pas drôle|peu importe|rester de marbre|sans commentaires|sans rire|visage neutre|visage sans expression
🫤|bof|confus|déçu|euh|frustration|incertain|sceptique|visage avec bouche en diagonale
😑|émoticône|inexpressif|mécontent|neutre|peu importe|sans expression|visage|visage sans expression
😶|émoticône|muet|ne rien dire|neutre|sans commentaires|sans expression|sans voix|se taire|secret|silence|sourdine|visage|visage sans bouche
🫥|déprimé|disparaître|introverti|invisible|se cacher|visage en pointillés
😏|arrogant|charmeur|émoticône|malin|ricaner|rusé|séducteur|sourire|sourire suffisant|suspicieux|visage avec un sourire malin|visage avec un sourire suffisant
😒|bizarre|blasé|émoticône|énervé|fâché|jaloux|pas content|peu importe|visage|visage qui s’ennuie
🙄|agacé|émoticône|excédé|incrédulité|roulement|visage qui lève les yeux au ciel|visage qui roule des yeux|visage roulant des yeux|yeux
😬|dents|émoticône|gêné|grimace|rien|sourire|visage|visage grimaçant
🤥|émoticône|mensonge|menteur|pinocchio|visage|visage de menteur|visage dont le nez s’allonge
😌|calme|émoticône|sérénité|soulagement|visage|visage soulagé|zen
😔|abattu|déçu|émoticône|horrible|mort|pensif|perdu|triste|visage
🥹|admiration|ému|fierté|gratitude|larmes de joie|pleurs|retenir ses larmes|triste|visage retenant ses larmes
😪|émoticône|fatigué|larme|pleurer|sommeil|triste|visage|visage endormi
🤤|baver|délicieux|émoticône|mmh|visage|visage qui bave
😴|bonne nuit|coucher|dormir|émoticône|endormi|fatigué|sieste|sommeil|visage|visage somnolent|zzz
😷|bactéries|dentiste|docteur|émoticône|germes|malade|masque|masque chirurgical|médecin|rhume|visage avec masque
🤒|indisposé|malade|thermomètre|visage|visage avec thermomètre
🤕|aïe|bandage|blessure|bobo|émoticône|pansement|tête|tête avec un bandage|visage|visage avec bandage autour de la tête
🤢|dégoûtant|écœuré|émoticône|malade|nausée|visage|visage nauséeux|visage vert qui a la nausée|vomir
🤮|gerbe|gerber|malade|tête qui vomit|visage qui vomit|vomi|vomissure
🤧|à tes souhaits|atchoum|émoticône|éternuement|éternuer|fièvre|grippe|malade|mouchoir|rhume|se moucher|visage|visage qui éternue
🥵|chaleur|chaud|coup de chaleur|coup de chaud|fièvre|sue|suer|toute rouge|transpiration|trop chaud|visage|visage rouge et chaud|visage tout rouge
🥶|bleu|ça caille|froid|gel|gelé|gelure|glacé|glacial|glaçon|visage bleu|visage bleu et froid
🥴|bouche ondulée|bourré|bourrée|dans les vapes|hébété|pas clair|pompette|rond|saoul|souler|tête qui tourne|visage éméché
😵|émoticône|fatigué|malade|mort|tournis|visage|visage avec le tournis|visage étourdi
😵‍💫|confusion|étourdi|hagard|malade|nausée|ouh la la|tête qui tourne|visage aux yeux en spirales
🤯|choc|choqué|surpris|surprise|tête choquée|tête qui explose
🤠|chapeau|cowboy|visage|visage avec chapeau de cowboy
🥳|anniversaire|célébration|chapeau|chapeau pointu|émoticône|fête|heureux|hourra|joyeux anniversaire|sifflet|visage de fête|visage festif|youpi
😎|cool|lunettes de soleil|posé|tranquille|visage avec lunettes de soleil
🤓|doué|futé|geek|idiot|intelligent|lunettes|personne|premier de la classe|ringard|surdoué|tronche|visage|visage de geek
🧐|classe|collet monté|fortune|monocle|riche|tête avec monocle|vieux jeu|visage avec un monocle
😕|confus|désolé|émoticône|ennuyé|je ne sais pas|triste|visage
😟|anxieux|émoticône|inquiet|préoccupé|stressé|surpris|triste|visage
🙁|émoticône|mécontent|triste|visage|visage légèrement mécontent
☹️|émoticône|malheureux|mécontent|triste|visage
😮|bouche bée|bouche ouverte|choqué|émoticône|épaté|incroyable|omd|oubli|surpris|visage avec bouche ouverte|visage avec la bouche ouverte|visage étonné
😯|émoticône|incroyable|omd|sans voix|stupéfait|stupeur|surpris|visage|visage à la bouche ouverte|visage ébahi|visage sans voix
😲|choc|choqué|émoticône|étonné|impossible|incroyable|omd|stupéfait|visage
😳|chaud|comment|ébahi|émoticône|étonné|gêné|hébété|impressionné|incrédule|incroyable|quoi|rouge|rougissant|stupéfait|visage|visage qui rougit
🥺|embarrassé|excuse|gros yeux|pardon|pitié|s’il te plaît|supplication|supplie|visage implorant|yeux de chiens battus
😦|bouche|déçu|effrayé|émoticône|ouverte|peur|pris au dépourvu|surpris|visage|visage déçu avec bouche ouverte|visage mécontent avec bouche ouverte
😧|angoisse|comment|émoticône|hein|mécontent|oubli|peur|quoi|stressé|surpris|terrifié|visage|visage angoissé
😨|anxieux|apeuré|blême|effrayé|émoticône|inquiet|peur|terrifié|visage
😰|aah|bleu|bouche|bouche bée|effrayé|émoticône|froid|mince|nerveux|peur|peur bleue|sueur|sueurs froides|terrifié|visage|visage anxieux avec goutte de sueur|visage en sueur bouche ouverte
😥|déçu|émoticône|ouf|pfiou|soulagé|sueur|triste|visage déçu mais soulagé|visage triste mais soulagé
😢|émoticône|horrible|larme|larmes|malheureux|pleurer|triste|visage qui pleure
😭|émoticône|larme|larmes|malheureux|pleurer|pleurs|sangloter|triste|visage|visage qui pleure à chaudes larmes
😱|choqué|cri|effrayé|Munch|omd|peur|surpris|terreur|visage|visage qui hurle de peur
😖|confus|déconcerté|émoticône|fâché|frustré|irrité|triste|visage|yeux fermés
😣|concentré|émoticône|mal de tête|migraine|persévérant|visage
😞|abattu|affreux|découragé|déçu|émoticône|malheureux|tort|triste|visage
😓|émoticône|froide|mal de tête|migraine|mince|ouf|peur|sueur|triste|visage|visage démoralisé avec goutte de sueur|visage et sueurs froides
😩|échec|émoticône|épuisé|faim|fatigué|mécontent|non|pleurer|sommeil|triste|visage|visage las
😫|contrarié|émoticône|fatigue|mécontent|triste|visage|visage fatigué
😤|colère|émoticône|énervé|fâché|mécontent|triomphe|victoire|visage|visage avec fumée sortant des narines
😡|colère|émoticône|énervé|exaspéré|fâché|furieux|mécontent|rageur|rouge|rouge de colère|sourcils froncés|visage|visage boudeur
😠|colère|émoticône|exaspéré|fâché|frustré|mécontent|rageur|sourcils froncés|visage en colère
🤬|censuré|colère|gros mots|insulter|insultes|jurer|juron|tête avec des symboles sur la bouche|visage avec des symboles dans la bouche
😈|cornes|émoticône|fâché|fantastique|sourire|visage|visage souriant avec des cornes
👿|démon|diable|diablotin|émoticône|fantastique|malicieux|mauvais|visage|visage en colère avec des cornes
💀|corps|crâne|dead|fantastique|je suis mort|mort|squelette|tête de mort|visage|yolo
☠️|crâne|mort|os|tête|tête de mort
💩|bande dessinée|BD|caca|crotte|dessin|excrément|odeur|popo|puer|sentir mauvais|tas de crotte|visage
🤡|clown|émoticône|maquillage|visage|visage de clown
👹|créature|effrayant|fantastique|japonais|masque|monstre|ogre
👺|colère|créature|fantastique|farfadet|japonais|masque|méchant|monstre
👻|blague|bouh|créature|effrayant|fantastique|fantôme|Halloween|hanter|monstre|peur|visage|visage de fantôme
👽|alien|créature|émoticône|espace|extraterrestre|monstre|ovni|science-fiction|visage
👾|alien|créature|envahisseur|espace|extraterrestre|fantastique|jeu vidéo|monstre|monstre de l’espace|ovni|pixels
🤖|androïde|automate|machine|monstre|robot|visage|visage de robot
🎃|citrouille|halloween|Halloween|lanterne
😺|animal|bouche ouverte|chat|chat qui sourit|sourire|visage
😸|animal|chat|chat avec un grand sourire|chat qui sourit avec des yeux rieurs|sourire|visage|yeux rieurs|yeux souriants
😹|animal|chat|chat qui rit aux larmes|joie|larmes|lol|mdr|pleurer de rire|rire|rire aux larmes
😻|amour|amoureux|chat|chat souriant aux yeux en cœurs|chat souriant avec des coeurs dans les yeux|cœur|coeurs|coeurs dans les yeux|sourire|yeux
😼|animal|chat|chat avec sourire en coin|ironique|narquois|sourire en coin|sourire narquois|tête de chat|visage
😽|animal|baiser|bise|bisou|chat|chat qui embrasse|chat qui fait un bisou|chat qui fait une bise avec les yeux fermés|embrasser|tête de chat
🙀|animal|chat|chat fatigué|fatigue|inquiet|oh|surpris|tête de chat avec la bouche ouverte|visage
😿|animal|chat|chat qui pleure|larme|pleurer|tête de chat|triste|visage
😾|animal|bouder|chat|chat en colère|chat qui boude|colère|désaccord|ennui|tête de chat|visage
🫶|amour|cœur|mains qui forment un cœur
👋|à bientôt|à plus tard|au revoir|bonjour|bye|coucou|hello|il y a quelqu’un ?|main|main qui salue|salut|signe|signe de la main
🤚|dos de main levée|levée|main
🖐️|doigts|main|main levée doigts écartés|paume|stop
✋|feuille|main|main levée|paume de la main|stop|tope là
🖖|doigts|main|salut vulcain|Spock|Star Trek|vulcain
👌|compris|d’accord|geste|main|nickel|ok|OK|parfait|super|tout va bien
🤌|agacement|argumentation|bout des doigts joints|doigts|geste|interrogation|main|parler avec les mains|patience|silence !
🤏|à deux doigts|petit|petite|petite quantité|petite somme|peu|pouce et index rapprochés|un peu
🫳|chasser|choisir|faire partir|laisser tomber|main paume vers le bas|ouste|rejeter
🫴|appeler de la main|attirer|faire venir|main paume vers le haut|offre
✌️|ciseaux|doigts|main|paix et amour|peace and love|V de la victoire|victoire
🫰|amour|argent|cher|claquer des doigts|cœur|main avec index et pouce croisés
🤞|bonne chance|chance|croisés|doigts|main
🤟|amour|geste pour je t’aime|ILY|je t’aime|main|signe je t’aime|trois doigts
🤘|cornes|cornes avec les doigts|cornes du diable|doigts|main|rock|rock’n roll|yeah
🤙|appel|main|signe|signe appel téléphonique avec les doigts|téléphone
👈|doigt|gauche|index|index pointé vers la gauche|main|main avec index pointant à gauche
👉|doigt|droite|index|index pointé vers la droite|main|main avec index pointant à droite
👆|doigt|haut|index|index vers le haut|main|main avec index pointant vers le haut|montrer
🖕|doigt|doigt d’honneur|main|majeur
👇|bas|doigt|index|index vers le bas|main|main avec index pointant vers le bas|montrer
☝️|doigt|haut|index|index pointant vers le haut|index pointé vers le haut|main|moi
👍|bien|compris|d’accord|génial|haut|main|moi aussi|OK|oui|pouce levé|pouce vers le haut|super|top
👎|bas|main|mauvais|non|nul|pouce|pouce baissé|pouce vers le bas
✊|main|pierre|poing|poing levé|poing serré|solidarité
👊|absolument|battre|boum|correct|coup de poing|d’accord|main|mon pote|poing|poing de face|serrer
🤛|fistbump|gauche|main|poing|poing à gauche
🤜|droite|main|poing|poing à droite
🫲|gauche|main vers la gauche|serrer la main|tenir la main|vers la gauche
🫱|droite|main vers la droite|serrer la main|tenir la main|vers la droite
👏|applaudissements|bien joué|bon travail|bravo|félicitations|formidable|geste|mains|mains qui applaudissent|super
🙌|air|geste|hourra|mains|mains en l’air|mains levées|youpi
👐|main|mains écartées|mains ouvertes|ouvert
🤲|espérer|mains|paume contre paume doigts vers le haut|paumes des mains ensemble|prier|prière
🤝|d’accord|main|mains|marché conclu|poignée|poignée de main|présentation|rencontre|serrer la main
🙏|demander|félicitations|mains|mains en prière|mains l’une contre l’autre|merci|prier|prière|s’il te plaît|s’il vous plaît|salut|se taper dans la main|tope là
🫵|index pointant vers l’utilisateur|pointer|toi
✍️|écrire|main|main qui écrit
💅|cosmétiques|manucure|maquillage|peu importe|s’ennuyer|vernis à ongles
🤳|appareil photo|photo|selfie|téléphone
💪|bande dessinée|BD|biceps|bodybuilding|contracté|corps|culturisme|entraînement|exercice|force|haltérophilie|muscle|muscles|soulever
🦵|coup de pied|cuisse|genou|genou fléchi|genoux|jambe|membre|pied
🦶|cheville|coup de pied|pas lourd|pied
👂|corps|écouter|entendre|oreille|ouïe|son
👃|corps|narines|nez|odeur|sentir
🧠|cerveau|intelligent|intelligente
🦴|chien|halloween|os|squelette
👀|chercher|corps|coup d’œil|œil|regarder|visage|voir|yeux
👁️|corps|œil
💋|baiser|bise|bisou|bouche|embrasser|lèvres|rendez-vous|rouge|sexy|trace de rouge à lèvres
👄|baiser|beauté|bise|bisou|bouche|corps|embrasser|lèvres|rouge à lèvres
🫦|anxieux|flirt|inquiet|lèvre mordue|lèvres qui se mordent|mal à l’aise|nerveux
🦷|carie|dent|dentiste|émail diamant
👅|corps|langue|lécher
👶|bébé|émoticône|enceinte|enfant|nouveau-né|petit
🧒|enfant|genre neutre|jeune|non-genré
👦|émoticône|enfant|garçon|jeune|personne
👧|couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
🧑|adulte|genre neutre|non-genré
👨|ami|garçon|homme|personne|petit ami|pote
🧔|barbe|barbu|personne avec une barbe|personne barbue
👱|blond|cheveux|garçon|homme|humain|personne blonde|tête|visage
👨‍🦰|ami|garçon|homme|personne|petit ami|pote cheveux roux|rouquin|rouquine
👨‍🦱|ami|garçon|homme|personne|petit ami|pote afro|boucles|bouclés|cheveux bouclés
👨‍🦳|ami|garçon|homme|personne|petit ami|pote blancs|cheveux|gris|vieux
👨‍🦲|ami|garçon|homme|personne|petit ami|pote chauve|chimiothérapie|imberbe|rasé|sans cheveux
👩|blonde|coupe de cheveux|femme|personne
👱‍♀️|blond|cheveux|garçon|homme|humain|personne blonde|tête|visage femme|symbole de la femme
👩‍🦰|blonde|coupe de cheveux|femme|personne cheveux roux|rouquin|rouquine
👩‍🦱|blonde|coupe de cheveux|femme|personne afro|boucles|bouclés|cheveux bouclés
👩‍🦳|blonde|coupe de cheveux|femme|personne blancs|cheveux|gris|vieux
👩‍🦲|blonde|coupe de cheveux|femme|personne chauve|chimiothérapie|imberbe|rasé|sans cheveux
🧓|adulte|âgé|genre neutre|non-genré|personne âgée
👴|âgé|chauve|émoticône|grand-père|homme|papi|personne|personne âgée|sage|vieux monsieur
👵|âgée|blonde|dame|émoticône|femme|grand-mère|mamie|personne|sage
🙍‍♂️|contrariée|déçue|embêtée|femme|froncer|gênée|geste|mécontente|pas contente|personne|personne fronçant les sourcils|sourcils|triste homme|symbole de l’homme
🙍‍♀️|contrariée|déçue|embêtée|femme|froncer|gênée|geste|mécontente|pas contente|personne|personne fronçant les sourcils|sourcils|triste femme|symbole de la femme
🙎‍♂️|bouder|déçue|énervée|expression|fâchée|faire la tête|femme|froncer les sourcils|geste|inquiète|moue|personne|personne qui boude homme|symbole de l’homme
🙎‍♀️|bouder|déçue|énervée|expression|fâchée|faire la tête|femme|froncer les sourcils|geste|inquiète|moue|personne|personne qui boude femme|symbole de la femme
🙅‍♂️|aucune chance|bloquer|femme|geste|impossible|interdit|main|niet|non|pas possible|personne faisant un geste d’interdiction|stop homme|symbole de l’homme
🙅‍♀️|aucune chance|bloquer|femme|geste|impossible|interdit|main|niet|non|pas possible|personne faisant un geste d’interdiction|stop femme|symbole de la femme
🙆‍♂️|d’accord|danser|exercice|femme|geste|grandir|lever les bras|main|OK|personne|personne faisant un geste d’acceptation homme|symbole de l’homme
🙆‍♀️|d’accord|danser|exercice|femme|geste|grandir|lever les bras|main|OK|personne|personne faisant un geste d’acceptation femme|symbole de la femme
💁‍♂️|aide|diva|femme|information|insouciante|main|personne|personne paume vers le haut|peu importe|potins|prétentieuse|sarcastique|sophistiqué homme|symbole de l’homme
💁‍♀️|aide|diva|femme|information|insouciante|main|personne|personne paume vers le haut|peu importe|potins|prétentieuse|sarcastique|sophistiqué femme|symbole de la femme
🙋‍♂️|compte sur moi|content|femme qui lève la main|geste|ici|je sais|levée|main|moi|participer|personne qui lève la main|présente homme|symbole de l’homme
🙋‍♀️|compte sur moi|content|femme qui lève la main|geste|ici|je sais|levée|main|moi|participer|personne qui lève la main|présente femme|symbole de la femme
🙇‍♂️|confus|désolé|excuses|geste|gronder|incliné|j’ai compris|OK|pardon|personne inclinée|personne qui s’incline homme|symbole de l’homme
🙇‍♀️|confus|désolé|excuses|geste|gronder|incliné|j’ai compris|OK|pardon|personne inclinée|personne qui s’incline femme|symbole de la femme
🤦‍♂️|drame|exaspération|femme avec paume sur visage|geste|incrédulité|incroyable|j’en peux plus|main|pas possible|paume de main|personne|personne avec la paume sur le visage|visage homme|symbole de l’homme
🤦‍♀️|drame|exaspération|femme avec paume sur visage|geste|incrédulité|incroyable|j’en peux plus|main|pas possible|paume de main|personne|personne avec la paume sur le visage|visage femme|symbole de la femme
🤷‍♂️|aucune idée|c’est comme ça|doute|femme qui hausse les épaules|haussement d’épaules|ignorance|indifférence|je ne sais pas|personne|personne qui hausse les épaules|peut-être|que faire|qui sait homme|symbole de l’homme
🤷‍♀️|aucune idée|c’est comme ça|doute|femme qui hausse les épaules|haussement d’épaules|ignorance|indifférence|je ne sais pas|personne|personne qui hausse les épaules|peut-être|que faire|qui sait femme|symbole de la femme
👨‍⚕️|ami|garçon|homme|personne|petit ami|pote caducée|docteur|Esculape|médecine|personnel
👩‍⚕️|blonde|coupe de cheveux|femme|personne caducée|docteur|Esculape|médecine|personnel
👨‍🎓|diplômé|étudiant|homme
👩‍🎓|diplômée|étudiante|femme
👨‍🏫|enseignant|homme|instituteur|instructeur|métier|professeur
👩‍🏫|enseignante|femme|institutrice|instructrice|professeure
👨‍⚖️|ami|garçon|homme|personne|petit ami|pote astrologie|balance|balance à poids|horoscope|justice|poids|zodiaque
👩‍⚖️|blonde|coupe de cheveux|femme|personne astrologie|balance|balance à poids|horoscope|justice|poids|zodiaque
👨‍🌾|agriculteur|fermier|homme|jardinier|métier
👩‍🌾|agricultrice|femme|fermière|jardinière|métier
👨‍🍳|chef|cuisinier|homme|métier
👩‍🍳|chef|cuisinière|femme|métier
👨‍🔧|électricien|homme|mécanicien|mécanique|métier|ouvrier|plombier
👩‍🔧|électricienne|femme|mécanicienne|mécanique|métier|ouvrière|plombier
👨‍🏭|assemblage|homme|industrie|métier|montage|ouvrier|usine
👩‍🏭|assemblage|femme|industrie|métier|montage|ouvrière|usine
👨‍💼|affaires|architecte|bureau|cadre|directeur|employé de bureau|homme|métier
👩‍💼|affaires|architecte|bureau|cadre|directrice|employée de bureau|femme|métier
👨‍🔬|biologiste|chimiste|homme|ingénieur|mathématicien|métier|physicien|scientifique
👩‍🔬|biologiste|chimiste|femme|ingénieure|mathématicienne|métier|physicienne|scientifique
👨‍💻|codeur|développeur|homme|informaticien|inventeur|logiciels|métier|technologie
👩‍💻|codeuse|développeuse|femme|informaticienne|inventrice|logiciels|métier|technologie
👨‍🎤|acteur|artiste|chanteur|homme|métier|rock|rockeur|star
👩‍🎤|actrice|artiste|chanteuse|femme|métier|rock|rockeuse|star
👨‍🎨|artiste|homme|métier|palette|peintre
👩‍🎨|artiste|femme|métier|palette|peintre
👨‍✈️|ami|garçon|homme|personne|petit ami|pote avion|avion en vol|jet|moyen de transport|véhicule|vol|voyage
👩‍✈️|blonde|coupe de cheveux|femme|personne avion|avion en vol|jet|moyen de transport|véhicule|vol|voyage
👨‍🚀|astronaute|casque|cosmonaute|espace|fusée|homme|métier|spationaute
👩‍🚀|astronaute|casque|cosmonaute|espace|femme|fusée|métier|spationaute
👨‍🚒|camion de pompiers|casque|casque de pompier|homme|métier|pompier
👩‍🚒|camion de pompiers|casque|femme|métier|pompier
👮‍♂️|autorité|flic|homme|loi|métier|officier|officier de police|personne|police|policier|tenue|uniforme homme|symbole de l’homme
👮‍♀️|autorité|flic|homme|loi|métier|officier|officier de police|personne|police|policier|tenue|uniforme femme|symbole de la femme
🕵️‍♂️|détective|enquêteur|espion|homme homme|symbole de l’homme
🕵️‍♀️|détective|enquêteur|espion|homme femme|symbole de la femme
💂‍♂️|Buckingham Palace|casque|garde|garde homme|Londres homme|symbole de l’homme
💂‍♀️|Buckingham Palace|casque|garde|garde homme|Londres femme|symbole de la femme
👷‍♂️|bâtiment|BTP|casque|chantier|construction|homme|métier|ouvrier|personne|personnel du bâtiment|réparer homme|symbole de l’homme
👷‍♀️|bâtiment|BTP|casque|chantier|construction|homme|métier|ouvrier|personne|personnel du bâtiment|réparer femme|symbole de la femme
🤴|couronne|prince|royal|royauté
👸|conte de fées|couronne|fantastique|personne|princesse|reine
👳‍♂️|homme avec turban|oriental|personne avec turban|personne en turban|turban|visage homme|symbole de l’homme
👳‍♀️|homme avec turban|oriental|personne avec turban|personne en turban|turban|visage femme|symbole de la femme
👲|casquette mao|chapeau|homme|homme avec casquette chinoise
🧕|bandana|femme avec foulard|femme avec un voile|foulard|hijab|mantilla|tichel|voile
🤵|élégant|homme|marié|personne en smoking|personne mariée|smoking
👰|mariage|mariée|mariée avec voile|personne mariée avec voile|voile
🤰|enceinte|femme
🤱|allaitement|bébé|maman|nourrice|nourrir le bébé|sein|soins
👼|ailes|ange|auréole|bébé|église|émoticône|fantastique|visage
🎅|bonnet|fêtes|magie|noël|Noël|père|Santa Claus|tradition
🤶|bonnet|fêtes|mère|Noël|Santa
🦸‍♂️|bien|cape|force|heroïne|héroïne|héros|personnage|sauver le monde|super pouvoir|super-héros|super-pouvoir|superhéros|superman|vengeur|voler homme|symbole de l’homme
🦸‍♀️|bien|cape|force|heroïne|héroïne|héros|personnage|sauver le monde|super pouvoir|super-héros|super-pouvoir|superhéros|superman|vengeur|voler femme|symbole de la femme
🦹‍♂️|cape|criminel|déguisement|diabolique|mal|mauvais|méchant|personnage|super pouvoir|super vilain|super-pouvoir|super-vilain homme|symbole de l’homme
🦹‍♀️|cape|criminel|déguisement|diabolique|mal|mauvais|méchant|personnage|super pouvoir|super vilain|super-pouvoir|super-vilain femme|symbole de la femme
🧙‍♂️|chapeau|enchantement|ensorceleur|envoûtement|jeu de rôle|mage|magicien|personnage|sorcier|sorcière|sortilège homme|symbole de l’homme
🧙‍♀️|chapeau|enchantement|ensorceleur|envoûtement|jeu de rôle|mage|magicien|personnage|sorcier|sorcière|sortilège femme|symbole de la femme
🧚‍♂️|ailes|déguisement|fée|Fée clochette|féerie|magie|Obéron|personnage féérique|Puck|Titania|voler homme|symbole de l’homme
🧚‍♀️|ailes|déguisement|fée|Fée clochette|féerie|magie|Obéron|personnage féérique|Puck|Titania|voler femme|symbole de la femme
🧛‍♂️|canines|cape|conte|déguisement|dents|dracula|Dracula|halloween|mort-vivant|personnage|sang|vampire homme|symbole de l’homme
🧛‍♀️|canines|cape|conte|déguisement|dents|dracula|Dracula|halloween|mort-vivant|personnage|sang|vampire femme|symbole de la femme
🧜‍♂️|ariel|créature aquatique|folklore|mer|océan|personnage|petite sirène|queue de poisson|sirène|trident|triton homme|symbole de l’homme
🧜‍♀️|ariel|créature aquatique|folklore|mer|océan|personnage|petite sirène|queue de poisson|sirène|trident|triton femme|symbole de la femme
🧝‍♂️|conte|elf|elfe|le seigneur des anneaux|legolas|magique|oreilles|personnage homme|symbole de l’homme
🧝‍♀️|conte|elf|elfe|le seigneur des anneaux|legolas|magique|oreilles|personnage femme|symbole de la femme
🧞‍♂️|aladin|djinn|génie|homme génie|lampe magique|magie|personnage|souhait|voeu|vœu homme|symbole de l’homme
🧞‍♀️|aladin|djinn|génie|homme génie|lampe magique|magie|personnage|souhait|voeu|vœu femme|symbole de la femme
🧟‍♂️|effrayant|flippant|halloween|horreur|mort vivant|mort-vivant|personnage|peur|zombie homme|symbole de l’homme
🧟‍♀️|effrayant|flippant|halloween|horreur|mort vivant|mort-vivant|personnage|peur|zombie femme|symbole de la femme
💆‍♂️|détente|femme qui se fait masser|fermer les yeux|massage|personne qui se fait masser|relaxation|repos|salon|tête|thérapie|visage|zen homme|symbole de l’homme
💆‍♀️|détente|femme qui se fait masser|fermer les yeux|massage|personne qui se fait masser|relaxation|repos|salon|tête|thérapie|visage|zen femme|symbole de la femme
💇‍♂️|barbier|beauté|cheveux|ciseaux|coiffure|coupe de cheveux|couper|femme qui se fait couper les cheveux|personne|personne qui se fait couper les cheveux|salon|style homme|symbole de l’homme
💇‍♀️|barbier|beauté|cheveux|ciseaux|coiffure|coupe de cheveux|couper|femme qui se fait couper les cheveux|personne|personne qui se fait couper les cheveux|salon|style femme|symbole de la femme
🚶‍♂️|balade|en route|flâner|homme|marche|marcher|nonchalant|personne|personne qui marche|piéton|promenade|se balader homme|symbole de l’homme
🚶‍♀️|balade|en route|flâner|homme|marche|marcher|nonchalant|personne|personne qui marche|piéton|promenade|se balader femme|symbole de la femme
🏃‍♂️|arriver|coureur|courir|course à pied|homme qui court|jogging|marathon|marathonien|personne qui court|pressé|rapide|sportif|vite homme|symbole de l’homme
🏃‍♀️|arriver|coureur|courir|course à pied|homme qui court|jogging|marathon|marathonien|personne qui court|pressé|rapide|sportif|vite femme|symbole de la femme
🕺|danse|danseur|femme|fête|flamenco|homme|homme qui danse|rythme|salsa
💃|danse|danseuse|femme|femme qui danse|fête|flamenco|rythme|salsa|sortir danser|tango
🕴️|affaires|costume|homme|homme d’affaires en lévitation
👯‍♂️|amies|bunny|danseuse|déguisement|double|femme|femmes|fête|fille|filles|jumelles|oreilles de lapin|personnes avec des oreilles de lapin|synchro homme|symbole de l’homme
👯‍♀️|amies|bunny|danseuse|déguisement|double|femme|femmes|fête|fille|filles|jumelles|oreilles de lapin|personnes avec des oreilles de lapin|synchro femme|symbole de la femme
🧖‍♂️|bien-être|chaud|détente|hammam|personne au hammam|personne dans un sauna|relaxation|sauna|spa|vapeur homme|symbole de l’homme
🧖‍♀️|bien-être|chaud|détente|hammam|personne au hammam|personne dans un sauna|relaxation|sauna|spa|vapeur femme|symbole de la femme
🧘|détendu|femme|lotus|méditation|personne assise en position du lotus|personne dans la posture du lotus|position du lotus|relax|relaxation|tailleur|yoga|zen
👭|amies|amitié|amoureuses|couple|deux femmes se donnant la main|deux femmes se tenant la main|femmes|filles|gay|homosexuelles|jumelles|lesbiennes|LGBT|LGBTQ|LGBTQIA|main dans la main|meilleures amies|petite amie|rendez-vous|sœurs
👫|amis|amoureux|couple|femme|femme et homme se tenant la main|homme|homme et femme se donnant la main|main dans la main|petit ami|petite amie|rendez-vous
👬|amis|amitié|amoureux|couple|deux hommes se donnant la main|deux hommes se tenant la main|fils|frères|gay|Gémeaux|hommes|homosexuels|jumeaux|LGBT|main dans la main|meilleurs amis|petit ami|rendez-vous|zodiaque
💏|amour|anniversaire|baiser|bisou|couple|femme|homme
👨‍❤️‍💋‍👨|ami|garçon|homme|personne|petit ami|pote amour|cœur|cœur rouge|sentiment baiser|bise|bisou|bouche|embrasser|lèvres|rendez-vous|rouge|sexy|trace de rouge à lèvres ami|garçon|homme|personne|petit ami|pote
👩‍❤️‍💋‍👩|blonde|coupe de cheveux|femme|personne amour|cœur|cœur rouge|sentiment baiser|bise|bisou|bouche|embrasser|lèvres|rendez-vous|rouge|sexy|trace de rouge à lèvres blonde|coupe de cheveux|femme|personne
💑|amour|anniversaire|cœur|couple|couple avec cœur|femme|homme|rendez-vous
👨‍❤️‍👨|ami|garçon|homme|personne|petit ami|pote amour|cœur|cœur rouge|sentiment ami|garçon|homme|personne|petit ami|pote
👩‍❤️‍👩|blonde|coupe de cheveux|femme|personne amour|cœur|cœur rouge|sentiment blonde|coupe de cheveux|femme|personne
👪|enfant|famille|famille avec un père, une mère et un fils|femme|fils|garçon|homme|mère|père
👨‍👩‍👦|ami|garçon|homme|personne|petit ami|pote blonde|coupe de cheveux|femme|personne émoticône|enfant|garçon|jeune|personne
👨‍👩‍👧|ami|garçon|homme|personne|petit ami|pote blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👨‍👩‍👧‍👦|ami|garçon|homme|personne|petit ami|pote blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque émoticône|enfant|garçon|jeune|personne
👨‍👩‍👦‍👦|ami|garçon|homme|personne|petit ami|pote blonde|coupe de cheveux|femme|personne émoticône|enfant|garçon|jeune|personne émoticône|enfant|garçon|jeune|personne
👨‍👩‍👧‍👧|ami|garçon|homme|personne|petit ami|pote blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👨‍👨‍👦|ami|garçon|homme|personne|petit ami|pote ami|garçon|homme|personne|petit ami|pote émoticône|enfant|garçon|jeune|personne
👨‍👨‍👧|ami|garçon|homme|personne|petit ami|pote ami|garçon|homme|personne|petit ami|pote couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👨‍👨‍👧‍👦|ami|garçon|homme|personne|petit ami|pote ami|garçon|homme|personne|petit ami|pote couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque émoticône|enfant|garçon|jeune|personne
👨‍👨‍👦‍👦|ami|garçon|homme|personne|petit ami|pote ami|garçon|homme|personne|petit ami|pote émoticône|enfant|garçon|jeune|personne émoticône|enfant|garçon|jeune|personne
👨‍👨‍👧‍👧|ami|garçon|homme|personne|petit ami|pote ami|garçon|homme|personne|petit ami|pote couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👩‍👩‍👦|blonde|coupe de cheveux|femme|personne blonde|coupe de cheveux|femme|personne émoticône|enfant|garçon|jeune|personne
👩‍👩‍👧|blonde|coupe de cheveux|femme|personne blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👩‍👩‍👧‍👦|blonde|coupe de cheveux|femme|personne blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque émoticône|enfant|garçon|jeune|personne
👩‍👩‍👦‍👦|blonde|coupe de cheveux|femme|personne blonde|coupe de cheveux|femme|personne émoticône|enfant|garçon|jeune|personne émoticône|enfant|garçon|jeune|personne
👩‍👩‍👧‍👧|blonde|coupe de cheveux|femme|personne blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👨‍👦|ami|garçon|homme|personne|petit ami|pote émoticône|enfant|garçon|jeune|personne
👨‍👦‍👦|ami|garçon|homme|personne|petit ami|pote émoticône|enfant|garçon|jeune|personne émoticône|enfant|garçon|jeune|personne
👨‍👧|ami|garçon|homme|personne|petit ami|pote couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👨‍👧‍👦|ami|garçon|homme|personne|petit ami|pote couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque émoticône|enfant|garçon|jeune|personne
👨‍👧‍👧|ami|garçon|homme|personne|petit ami|pote couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👩‍👦|blonde|coupe de cheveux|femme|personne émoticône|enfant|garçon|jeune|personne
👩‍👦‍👦|blonde|coupe de cheveux|femme|personne émoticône|enfant|garçon|jeune|personne émoticône|enfant|garçon|jeune|personne
👩‍👧|blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
👩‍👧‍👦|blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque émoticône|enfant|garçon|jeune|personne
👩‍👧‍👧|blonde|coupe de cheveux|femme|personne couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque couettes|émoticône|enfant|fille|grands yeux|jeune|nattes|personne|petite fille|tresses|vierge|visage|zodiaque
🗣️|parler|silhouette|tête qui parle
👤|buste|mystère|ombre|silhouette de buste
👥|amis|bff|bustes|gens|meilleur ami|meilleure amie|meilleures amies|meilleurs amis|personnes|silhouettes|silhouettes de bustes|tout le monde
🫂|accolade|amitié|au revoir|bonjour|câlin|embrassades|étreinte|gratitude|merci|personne
👣|empreintes|pied|pieds|pieds nus|traces de pas
🧳|bagage|valise|voyage
🌂|météo|parapluie|parapluie fermé|pluie
☂️|parapluie|parapluie ouvert|pluie
🧵|aiguille|bobine|bobine de fil|coudre|couture|ficelle|fil
🧶|boule|crochet|fil|laine|pelote|tricot
👓|accessoire|lunettes|lunettes de vue|œil|vêtements|yeux
🕶️|lunettes|lunettes de soleil|lunettes noires|soleil
🥽|lunettes|lunettes de chimiste|lunettes de labo|lunettes de piscine|lunettes de protection|lunettes de soudage|lunettes de soudure|masque|natation|protection des yeux|soudage
🥼|blouse|blouse blanche|docteur|expérience|expérimentation|labo|laboratoire|manteau blanc|médecin|scientifique|vêtements
👔|chemise|cravate|travail|vêtements
👕|bleu|chemise|courses|décontracté|polo|shopping|T-shirt|tee-shirt|vêtements|week-end
👖|bleu|courses|denim|jean|pantalon|shopping|vêtements|week-end
🧣|cou|écharpe|foulard|froid|glagla|vêtements
🧤|gant|gants|main|vêtements
🧥|froid|glagla|manteau|veste|vêtements
🧦|chaussettes|pieds|vêtements
👗|courses|élégante|jolie|robe|shopping|vêtements
👘|kimono|vêtements
👙|bikini|maillot de bain|nager|piscine|plage|vêtements
👚|chemise|chemisier|courses|femme|shopping|vêtements|vêtements de femme
👛|accessoire|courses|monnaie|porte-monnaie|sac à main|shopping|vêtements
👜|accessoire|courses|sac|sac à main|shopping|vêtements
👝|accessoire|pochette|sac|sac à main|trousse|vêtements
🎒|cartable|école|sac|sac à dos
👞|accessoire|chaussure|chaussure d’homme|coup de pied|courses|homme|marron|pied|shopping|vêtements
👟|accessoire|athlétisme|basket|chaussure|chaussure de sport|coup de pied|courir|courses|shopping|tennis|vêtements|vite
🥾|camping|chaussure|chaussure de marche|chaussure de randonnée|chaussures de chantier|chaussures de montagne|chaussures de sécurité|chaussures marron|marche|rando|randonnée|timberland|vêtements
🥿|ballerine|chaussure plate|chaussure sans lacets|chaussures plates|mule|vêtements
👠|accessoire|chaussure|chaussure à talon|chaussure à talon haut|chaussure de femme|courses|mode|shopping|stilletto|talon aiguille|talon haut|vêtements
👡|chaussure|chaussure à talon|chaussure de femme|femme|sandale|sandale de femme|talon haut|vêtements
👢|accessoire|botte|botte de femme|chaussure|courses|femme|shopping|vêtements
👑|accessoire|couronne|famille royale|monarchie|monarque|reine|roi|royauté|succès|vêtements
👒|chapeau|chapeau de femme|femme|vêtements
🎩|accessoire|chapeau|élégant|haut de forme|haut-de-forme|magie|vêtements
🎓|accessoire|chapeau|diplôme|étudiant|toque universitaire|université|vêtements
🧢|baseball cap|casquette|casquette américaine|casquette de baseball|chapeau|vêtements
⛑️|assistance|casque|casque croix blanche|casque de sauveteur|casque de secouriste|croix|secours
💄|cosmétiques|maquillage|rendez-vous|rouge à lèvres
💍|alliance|amour|bague|brillant|diamant|étincelant|fiançailles|mariage|solitaire
💼|accessoire|bureau|cartable|porte-documents
🐶|animal|animal domestique|chien|chiot|tête de chien|visage
🐱|animal|chat|chaton|miaou|minou|tête de chat
🐭|animal|souris|tête de souris|visage
🐹|animal|animal domestique|hamster|tête|tête de hamster|visage
🐰|animal|animal domestique|dents|lapin|tête de lapin
🦊|animal|nature|renard|tête|visage
🐻|animal|miel|nounours|ours|ours brun|teddy|tête|visage
🐼|animal|panda|tête|tête de panda|visage
🐨|animal|Australie|koala
🐯|animal|félin|prédateur|tête de tigre|tigre|visage
🦁|animal|astrologie|crinière|fort|horoscope|lion|roi|rugissement|safari|savane|tête de lion|visage|zodiaque
🐮|animal|lait|meuh|tête de vache|vache|visage
🐷|animal|cochon|ferme|porc|tête de cochon|visage
🐽|animal|cochon|ferme|flair|groin|museau|porc|sentir|tête de cochon
🐸|animal|crapaud|grenouille|tête|tête de grenouille
🐵|animal|Georges le petit curieux|singe|sourire|tête de singe|visage
🙈|animal|caché|effrayé|embarras|gêne|geste|interdit|ne pas voir|non|omd|oubli|peur|rien vu rien entendu|secret|singe|visage|voir|yeux
🙉|animal|écouter|geste|interdit|ne pas entendre|non|oreilles|rien vu rien entendu|secret|singe|singe ne rien entendre|sourd|visage
🙊|animal|bouche cousue|chut|geste|interdit|motus|muet|non|parler|se taire|secret|silence|singe|singe ne rien dire|visage
🐒|animal|primate|singe
💥|bande dessinée|BD|bombe|boum|collision|détonation|étincelles|explosion
💫|bande dessinée|BD|étincelles|étoile|étoile filante|étourdissement|tournis|voir des étoiles
💦|bande dessinée|BD|eau|éclabousser|éclaboussures|effort|entraînement|gouttes|gouttes de sueur|sueur
💨|bande dessinée|BD|décamper|déguerpir|détaler|filer|fumée|nuage|partir en courant|pet|vent|vite
🦍|animal|gorille|primate
🐕|aboyer|animal|animal domestique|chien
🐩|animal|caniche|chien
🐺|animal|loup|louve|tête|tête de loup
🦝|animal|curieux|raton laveur|sournois
🐈|animal|animal domestique|chat|chaton|miaou|miauler
🐅|animal|félin|prédateur|tigre|tigresse|zoo
🐆|animal|félin|léopard|prédateur|zoo
🐴|animal|cheval|dressage|équitation|ferme|jument|tête de cheval
🐎|animal|cheval|course hippique|hippodrome|tiercé
🦄|animal|licorne|licrone|tête|tête de licorne
🦓|animal|noir et blanc|rayure|rayures|zèbre|zébrure
🐂|animal|astrologie|bœuf|ferme|horoscope|taureau|zodiaque
🐃|animal|buffle|corne|zoo
🐄|animal|ferme|lait|meuh|vache
🐖|animal|cochon|ferme|gros|jambon|porc|truie
🐗|animal|Game of Thrones|sanglier
🐏|animal|astrologie|bélier|corne|ferme|horoscope|mouton|zodiaque
🐑|animal|bêler|brebis|doux|ferme|laine|lait|mouton
🐐|animal|astrologie|Capricorne|chèvre|ferme|fromage|horoscope|lait|zodiaque
🐪|animal|bosse|désert|dromadaire|une bosse
🐫|animal|bosse|chameau|chameau à deux bosses|désert|deux bosses
🦙|alpaca|alpaga|animal|guanaco|laine|lama|llama|pérou|vicuña|vigogne
🦒|animal|cou|girafe|taches
🐘|animal|éléphant|pachyderme|trompe
🦏|animal|corne|rhinocéros
🦛|animal|hippo|hippopotame
🐁|animal|souris
🐀|animal|rat
🐇|animal|animal domestique|lapin
🐿️|animal|écureuil|noisettes
🦔|animal|épines|épineux|hérisson|piquant|porc-épic
🦇|animal|chauve-souris|vampire
🦘|austalie|joey|kangoo|kangourou|marsupial|marsupiaux|saut
🦡|animal|blaireau|ratel
🐾|empreintes|empreintes d’animaux|empreintes de pattes|pattes
🦃|action de grâces|animal|dinde|dindon|oiseau|thanksgiving|volaille
🐔|animal|coq|ferme|oiseau|poule|poulet|volaille
🐓|animal|coq|oiseau|volaille
🐣|animal|bébé|éclosion|naissance|naître|nouveau-né|œuf|oiseau|poussin|poussin qui éclôt
🐤|animal|oiseau|poussin|tête de poussin
🐥|animal|bébé|nouveau-né|oiseau|poussin|poussin de face
🐦|animal|oiseau|ornithologie
🐧|animal|Antarctique|banquise|manchot|oiseau|pingouin
🕊️|animal|colombe|oiseau|paix|rameau|voler
🦅|aigle|animal|oiseau|rapace
🦆|animal|canard|coin-coin|oiseau
🦢|animal|cygne|jeune cygne|oiseau|vilain petit canard
🦉|animal|chouette|hibou|oiseau|sage
🦚|animal|bel oiseau|coloré|fier|fière|oiseau|paon|paonne|prétentieux
🦜|animal|oiseau|parle|perroquet|pirate|répète
🐊|alligator|animal|caïman|crocodile|reptile|zoo
🐢|animal|carapace|lentement|reptile|tortue
🦎|animal|lézard|reptile
🐍|animal|reptile|serpent|serpent à sonnette|venin
🐲|animal|dragon|mythe|tête de dragon|tradition
🐉|animal|Chine|chinois|dragon|Game of Thrones|mythe|tradition
🦕|animal|brachiosaure|brontosaure|dinosaure|diplodocus|sauropode
🦖|animal|dinosaure|T-Rex|T. rex|tyrannosaure|Tyrannosaurus rex|Tyrannosaurus Rex
🧌|conte de fées|légende|monstre|mythe|troll|troller
🐳|animal|baleine|baleine avec évent|baleine soufflant par son évent|mer|océan|plage|souffle
🐋|animal|baleine|mer|océan|plage
🐬|animal|dauphin|Flipper|mer|océan|plage
🐟|alimentation|animal|astrologie|horoscope|manger|nourriture|poisson|poissons|Poissons|repas|zodiaque
🐠|animal|poisson|poisson tropical
🐡|animal|poisson|poisson-lune
🦈|animal|Dents de la mer|poisson|requin
🐙|animal|créature|mer|mollusque|océan|pieuvre|poulpe
🪹|branches|faire son nid|maison|nid|nid vide
🪺|branches|faire son nid|nid|nid avec œufs|oiseau
🐚|animal|conque|coquillage|coquille|coquille en spirale|mer|plage|spirale
🪸|corail|océan|réchauffement climatique|récif
🐌|animal|escargot|jardin|lentement|nature
🦋|animal|insecte|mignon|papillon|printemps
🐛|animal|chenille|insecte|jardin
🐜|animal|fourmi|insecte|jardin
🐝|abeille|animal|bourdon|guêpe|insecte|miel|nature|printemps
🐞|animal|bête|coccinelle|insecte|jardin|nature
🦗|animal|criquet|insecte|sauterelle
🕷️|animal|araignée|insecte
🕸️|araignée|toile|toile d’araignée
🦂|animal|astrologie|désert|horoscope|scorpion|zodiaque
🦟|fièvre|infection|insecte|maladie|malaria|moustique|piqûre|virus
🦠|amibe|bactérie|biologie|microbe|microorganisme|phagocytose|pseudopode|science|virus
💐|amoureux|anniversaire|bouquet|fleur|fleurs|plante|rendez-vous|roses
🌸|bourgeon|fleur|fleur de cerisier|plante|printemps
💮|fleur|fleur blanche
🏵️|plante|rosette
🪷|beauté|bouddhisme|calme|fleur|hindouisme|lotus|pureté|sérénité
🌹|amour|beauté|fleur|plante|rose|rouge|Saint-Valentin
🥀|fanée|fleur|mort|rose
🌺|fleur|hibiscus|plante
🌻|champs|fleur|plante|soleil|tournesol
🌼|bourgeon|bouton d’or|dent-de-lion|fleur|pissenlit|plante|printemps
🌷|bourgeon|fleur|plante|printemps|tulipe
🌱|germe|jeune plant|jeune pousse|plante|plantule|pousser|printemps|semis
🌲|arbre|conifère|feuilles persistantes|forêt|pin|plante|sapin|sapin de Noël
🌳|arbre|arbre à feuilles caduques|feuilles caduques|feuillu|forêt|nature|plante
🌴|arbre|cocotier|palmier|plage|plante|tropical|tropiques
🌵|cactus|désert|épines|nature|piquant|plante|sécheresse
🌾|grain|plant de riz|plante|riz
🌿|arbre|feuille|feuilles|plante
☘️|Irlande|plante|trèfle
🍀|4|chance|feuilles|Irlande|plante|porte-bonheur|quatre|trèfle|trèfle à quatre feuilles
🍁|automne|érable|feuille|feuille d’érable|feuille morte|tomber
🍂|automne|feuille|feuille morte|feuilles mortes|tomber
🍃|bourrasque|feuille|feuille virevoltante|souffle|tourbillon de feuilles|vent|virevolter
🍄|champignon|champignon vénéneux|Mario|plante
🌰|châtaigne|marron|nourriture|plante
🦀|animal|astrologie|Cancer|crabe|horoscope|mer|pinces|plage|zodiaque
🦞|animal|bisque|fruit de mer|fruits de mer|homard|pinces
🦐|aliment|crevette|crustacé|fruits de mer|nourriture
🦑|aliment|animal|calamar|encornet|mollusque|nourriture
🌍|afrique|Afrique|espace|europe|Europe|globe|globe présentant l’Europe et l’Afrique|globe tourné sur l’Afrique et l’Europe|monde|planète|Terre
🌎|amérique|Amérique|espace|globe|globe présentant l’Amérique|globe tourné sur les Amériques|monde|planète|Terre
🌏|asie|Asie|australie|Australie|espace|globe|globe présentant l’Asie et l’Australie|globe tourné sur l’Asie et l’Australie|monde|planète|Terre
🌐|globe avec méridiens|globe terrestre|Internet|méridiens|monde|net|toile
🌑|espace|lune|nouvelle lune|sombre
🌒|espace|lune|lune croissante|nuit
🌓|espace|lune|nuit|premier quartier|premier quartier de lune|quartier
🌔|croissant|espace|gibbeux|lune|lune gibbeuse croissante|nuit
🌕|espace|lune|nuit|pleine lune
🌖|décroissant|espace|gibbeux|lune|lune gibbeuse décroissante|nuit
🌗|dernier quartier|dernier quartier de lune|espace|lune|quartier
🌘|croissant|croissant de lune|espace|lune|lune décroissante|lune descendante|nuit
🌙|croissant|croissant de lune|espace|lune|nuit|Ramadan
🌚|espace|lune|nouvelle lune à visage|nouvelle lune avec visage|nuit|visage
🌛|croissant de lune|espace|lune|lune à visage|nuit|premier quartier de lune|premier quartier de lune avec visage|quartier|visage
🌜|croissant de lune|dernier quartier de lune|dernier quartier de lune avec visage|lune|lune à visage|nuit|quartier|visage
☀️|beau temps|brillant|espace|grand soleil|météo|rayons|soleil
🌝|lune|lune à visage|nuit|pleine lune|pleine lune avec visage|sourire|visage
🌞|chaleur|chaud|éclat|éclatant|ensoleillé|jour|lumière|météo|plage|rayon de soleil|soleil|soleil à visage|soleil avec visage
⭐|astronomie|étoile|nuit
🌟|éclat|étincelant|étincelle|étoile|étoile brillante|nuit|nuit étoilée|succès
🌠|espace|étoile|étoile filante|nuit
☁️|gris|météo|nuage
⛅|caché|météo|nuage|nuageux|soleil|soleil derrière les nuages|soleil derrière nuages
⛈️|éclair|météo|nuage|nuage avec éclair et pluie|orage|pluie
🌤️|caché|météo|nuage|soleil|soleil derrière petit nuage|soleil derrière un petit nuage
🌥️|caché|météo|nuage|soleil|soleil derrière gros nuage|soleil derrière un gros nuage
🌦️|caché|gouttes|météo|nuage|pluie|soleil|soleil derrière un nuage|soleil derrière un nuage de pluie
🌧️|averse|gouttes|mauvais temps|météo|nuage|nuage avec pluie|nuage de pluie|pluie
🌨️|flocons|froid|hiver|météo|neige|nuage|nuage avec neige|nuage de neige
🌩️|éclair|nuage|nuage avec éclair|nuage avec un éclair|orage|orageux|temps
🌪️|cyclone|météo|nuage|tornade|tourbillon
🌫️|brouillard|brume|fog|météo|nuage
🌬️|météo|nuage|souffle|vent|vent avec visage|visage|visage du vent
🌈|arc-en-ciel|bisexuel|bisexuelle|gay|Gay Pride|homosexuel|homosexuelle|lesbienne|LGBT|LGBTQ|LGBTQIA|météo|nature|orgueil|pluie|trans|transgenre
☔|gouttes|météo|parapluie|parapluie avec gouttes|parapluie avec gouttes de pluie|pluie
⚡|courant|danger|éclair|électricité|haute tension|nature|orage|symbole haute tension|tension|vitesse
❄️|flocon|flocon de neige|froid|météo|neige
☃️|bonhomme de neige|bonhomme de neige avec flocons|flocons|neige
⛄|bonhomme de neige|bonhomme de neige sans flocons|bonhomme de neige sans neige|froid|neige
☄️|comète|espace|météore
🔥|allumer|brûler|chaud|feu|flamme|fournaise|incendie
💧|bande dessinée|BD|eau|froid|goutte|goutte d’eau|larme|météo|nature|pluie|sueur|sueurs froides|tristesse
🫧|bulle|bulles|propre|savon|sous l’eau
🌊|eau|Kanagawa|lame|large|marée|mer|nature|océan|remous|rouleau|surf|vague
🎄|arbre|fête|fêtes|guirlandes|Noël|sapin de Noël|Sapin de Noël
✨|*|étincelles|étoile|étoiles|magie|nuit|nuit étoilée|scintiller
🎋|arbre|arbre à vœux|fête|Japon|prières|Tanabata|vœux
🎍|bambou|bambou décoratif|fête|japonais|plante
🍇|fruit|nourriture|raisin
🍈|fruit|melon
🍉|fruit|pastèque
🍊|agrume|clémentine|fruit|mandarine|nourriture|orange|vitamine C
🍋|acide|agrume|citron|fruit|nourriture|zeste
🍌|banane|fruit|nourriture|potassium
🍍|ananas|fruit|nourriture|tropical
🥭|fruit|mangue|nourriture|tropical|tropique
🍎|fruit|nourriture|pomme|pomme rouge
🍏|fruit|nourriture|pomme|pomme verte
🍐|fruit|nourriture|poire
🍑|fruit|nourriture|pêche
🍒|cerise|cerises|fruit|nourriture
🍓|fraise|fruit|nourriture
🥝|fruit|kiwi|nourriture
🍅|fruit|légume|nourriture|plante|tomate
🥥|coco|fruit|noix de coco|nourriture|palmier|piña colada
🥑|avocat|fruit|nourriture
🍆|aubergine|légume|nourriture
🥔|légume|nourriture|patate|pomme de terre|purée
🥕|carotte|légume|nourriture
🌽|épi|épi de maïs|ferme|maïs|nourriture
🌶️|nourriture|piment|piment rouge|piquant
🥒|concombre|cornichon|légume|nourriture
🥬|bok choy|chou|chou chinois|chou frisé|chou pommé|kale|laitue|légume à feuilles vertes|salade
🥦|broccoli|brocoli|chou|chou sauvage|légume
🥜|arachide|cacahuète|cacahuètes|noisette|nourriture
🫘|haricot rouge|haricots|légume|légumineuse|nourriture|petit|rognon
🍞|miche|nourriture|pain|pain de mie
🥐|croissant|nourriture|pain|petit-déjeuner|viennoiserie
🥖|baguette|nourriture|pain
🥨|bretzel|nourriture|torsade
🥯|bagel|boulangerie|petit-déjeuner|sandwich|schmear
🥞|crêpe|goûter|nourriture|pancake|pancakes|petit-déjeuner
🧀|fromage|nourriture|part de fromage
🍖|nourriture|os|viande|viande sur un os
🍗|cuisse|cuisse de poulet|dinde|nourriture|os|poulet|volaille
🥩|côtelette|côtelette d’agneau|côtelette de porc|morceau de viande|nourriture|steak|viande|viande rouge
🥓|bacon|lard|nourriture|porc|viande
🍔|burger|cheeseburger|fast food|hamburger|nourriture
🍟|fast food|frites|potatoes|potatœs
🍕|fromage|nourriture|part|pepperoni|pizza|tranche
🌭|hot dog|nourriture|saucisse|saucisse de Francfort
🥪|nourriture|pain|pain de mie|pique-nique|sandwich
🌮|mexicain|nourriture|taco
🌯|burrito|kebab|mexicain|wrap
🥙|falafel|kebab|nourriture|pain pita
🍳|cuisine|friture|nourriture|œuf|œuf au plat|petit-déjeuner|poêle|poêle à frire|se faire cuire un œuf
🥘|casserole|Espagne|paella|plat|plat mitonné|poêle|riz
🍲|marmite|nourriture|ragoût
🥣|bol avec cuillère|bol avec une cuillère|céréales|congee|déjeuner|petit déjeuner|soupe
🥗|nourriture|salade|verte
🍿|cinéma|nourriture|pop-corn
🧂|condiment|salé|salière|saveur|sel
🥫|aliments en conserve|boîte de conserve|conserve|nourriture
🫙|bocal|condiments|conserver|pot|récipient|rien|sauce|vide
🍱|bento|boîte|déjeuner|nourriture
🍘|cracker|galette de riz|nourriture|riz
🍙|boulette de riz|japonais|nourriture|onigiri|plat|riz
🍚|bol de riz|nourriture|riz
🍛|curry|nourriture|riz|riz au curry
🍜|bol|bol fumant|nouilles|nourriture|ramen|vapeur
🍝|italien|nourriture|pâtes|restaurant|sauce bolognaise|spaghetti
🍠|nourriture|patate|patate douce|patate douce au four
🍢|brochette|brochette de poisson|fruits de mer|nourriture|restaurant
🍣|japonais|nourriture|poisson|riz|sushi
🍤|beignet de crevette|crevette
🍥|croquette de poisson|gâteau|narutomaki|nourriture|poisson|restaurant|surimi
🥮|automne|festival|gâteau de lune|moon cake|yuèbǐng
🍡|bonbons|brochette de bonbons|dango|dessert|japonais|nourriture
🥟|boulette de pâte|dumpling|empanada|gyoza|gyōza|jiaozi|pierogi|potsticker|ravioli
🥠|biscuit chinois|nourriture|prophétie
🥡|baguettes|boîte à emporter|carton|chinois|nourriture à emporter
🍦|cornet de glace|dessert|glace|glace italienne|nourriture|sucré
🍧|coupe de glace|crème glacée|dessert|glace|granité|nourriture|restaurant|sucré
🍨|coupe de glace|crème|crème glacée|dessert|glace|nourriture|restaurant|sucré
🍩|dessert|donut|doughnut|goûter|nourriture|sucré|sucrerie
🍪|biscuit|cookie|dessert|gâteau|goûter|nourriture|pépites de chocolat|sucré
🎂|anniversaire|bougies|dessert|fête|gâteau|gâteau d’anniversaire|goûter|joyeux anniversaire|nourriture|pâtisserie
🍰|dessert|gâteau|gâteau sablé|goûter|nourriture|pâtisserie|sucré
🧁|cupcake|dessert|muffin|pâtisserie|sucre|sucrerie
🥧|décoration|garniture|gâteau|nourriture|pâte à tarte|pâtisserie|tarte|tarte aux fruits|tourte
🍫|barre|barre chocolatée|chocolat|dessert|goûter|nourriture|sucré
🍬|bonbon|dessert|goûter|nourriture|sucré|sucrerie
🍭|dessert|goûter|nourriture|sucette|sucré|sucrerie
🍮|crème renversée|dessert|flan|nourriture|pudding|sucré
🍯|miel|nourriture|ours|pot|pot de miel|sucré
🍼|bébé|biberon|boisson|lait|naissance|nouveau-né|tétine
🥛|boisson|lait|verre|verre de lait
🫗|accident|boisson|eau|oups|renverser|verre|verser|verser un liquide|vider
☕|boisson|boisson chaude|café|caféine|matin|thé
🍵|boisson|tasse|tasse de thé sans anse|thé
🧉|boisson|maté
🍶|boisson|bouteille|bouteille et verre|restaurant|saké|verre
🍾|alcool|boisson|bouchon|bouteille|bouteille de champagne|champagne|félicitations|fête|pop
🍷|alcool|bar|boisson|club|restaurant|verre|verre à vin|verre de vin|vin
🍸|alcool|bar|boisson|club|cocktail|martini|verre|verre à cocktail|verre à pied
🍹|alcool|bar|boîte|cocktail|cocktail tropical|fête|tequila sunrise|verre
🍺|alcool|bar|bière|boisson|chope|chope de bière|oktoberfest|picoler|pinte|santé
🍻|alcool|bière|boisson|chopes de bière|santé|tchin|trinquer
🥂|alcool|célébrer|champagne|fêter|santé|tchin|trinquer|verre|verres
🥃|alcool|liqueur|tumbler|verre|whisky
🥤|boisson|eau|gobelet avec paille|jus de fruit|jus de fruits|soda|verre avec une paille
🥢|baguettes|hashi
🍽️|assiette|assiette et couverts|couteau|cuisine|fourchette|fourchette et couteau avec assiette|restaurant|table
🍴|couteau et fourchette|couverts|faim|fourchette et couteau|manger|nourriture|repas|restaurant
🥄|couvert|cuillère|manger
🗾|carte|carte du Japon|japon|voyage
🏔️|froid|montagne|montagne enneigée|neige|sommet|voyage
⛰️|montagne|nature|sommet|voyage
🌋|éruption|lave|nature|volcan
🗻|mont Fuji|montagne|nature|sommet|voyage
🏕️|camping|nature|tente avec un sapin|voyage
🏖️|parasol|plage|plage avec parasol|voyage
🏜️|désert|voyage
🏝️|cocotier|île|île déserte|palmier|voyage
🏞️|nature|parc national|voyage
🏟️|stade
🏛️|colonnes|monument|monument classique|voyage
🏗️|chantier|construction|construction d’un bâtiment|grue
🏘️|bâtiment|bâtiments|maison|maisons|pavillons
🏚️|maison|maison abandonnée
🏠|bâtiment|foyer|maison|maison simple|pavillon|résidentiel
🏡|foyer|jardin|maison|maison avec jardin|pavillon|résidentiel
🏢|bureaux|immeuble|immeuble de bureaux|ville
🏣|bâtiment|bureau de poste japonais|Japon|poste|poste japonaise|voyage
🏤|bâtiment|bureau de poste|européen|poste
🏥|bâtiment|docteur|hôpital|médecin|urgences
🏦|banque|bâtiment
🏨|bâtiment|hôtel|voyage
🏩|amour|bâtiment|cœur|hôtel|love hotel|voyage
🏪|24h/24|bâtiment|épicerie|magasin|supérette|supermarché
🏫|bâtiment|école
🏬|bâtiment|centre commercial|grand magasin|magasin
🏭|bâtiment|usine
🏯|bâtiment|château|japonais|voyage
🏰|bâtiment|château|européen|voyage
💒|amour|chapelle|cœur|église|mariage
🗼|Japon|Tokyo|tour|tour de Tokyo|voyage
🗽|liberté|New York|statue|statue de la liberté|statue de la Liberté|voyage
⛪|bâtiment|chapelle|chrétien|croix|église|religion|voyage
🕌|islam|mosquée|musulman|musulmane|religion|voyage
🕍|judaïsme|juif|juive|religion|synagogue|temple|voyage
⛩️|religion|sanctuaire shinto|shinto|voyage
🕋|islam|kaaba|Kaaba|musulman|musulmane|religion|voyage
⛲|eau|fontaine
⛺|camping|nature|tente|voyage
🌁|brouillard|brume|voyage
🌃|étoiles|nuit|nuit étoilée|ville|voyage
🏙️|bâtiment|ville|voyage
🌄|lever de soleil|matin|nature|soleil|soleil levant derrière les montagnes|voyage
🌅|lever de soleil|matin|nature|soleil|soleil levant|voyage
🌆|coucher de soleil|crépuscule|immeubles|soir|soleil|tombée de la nuit|ville|ville au crépuscule|voyage
🌇|coucher de soleil|coucher de soleil en ville|crépuscule|soir|soleil|tombée de la nuit|ville|voyage
🌉|nuit|pont|pont de nuit
🎠|cheval|cheval de manège|manège
🎡|attractions|grande roue|parc d’attractions|roue
🎢|attractions|montagnes|parc d’attractions|russes
🚂|chemin de fer|locomotive|machine à vapeur|moyen de transport|rail|tchou tchou|train|vapeur|voyage
🚃|chemin de fer|moyen de transport|rail|train|tram|tramway|voiture|voyage|wagon
🚄|chemin de fer|moyen de transport|rail|rapide|TGV|train|train à grande vitesse|vitesse|voyage
🚅|chemin de fer|moyen de transport|rail|rapide|TGV|train|train à grande vitesse|voyage
🚆|arrivée|chemin de fer|moyen de transport|rail|train|voyage
🚇|métro|moyen de transport
🚈|métro|métro léger|monorail|moyen de transport|rail|RER
🚉|chemin de fer|gare|moyen de transport|rail|RER|train
🚊|moyen de transport|RER|tram|tramway|transport|trolley|trolleybus
🚝|monorail|moyen de transport|véhicule
🚞|chemin de fer|moyen de transport|rail|train|train de montagne|voyage|wagon
🚋|moyen de transport|tram|trolleybus|voiture|voyage|wagon de tramway
🚌|bus|école|moyen de transport|véhicule
🚍|bus|bus de face|bus qui arrive|car|moyen de transport
🚎|bus|moyen de transport|tram|tramway|trolley|trolleybus
🚐|bus|minibus|moyen de transport|navette|véhicule
🚑|ambulance|urgences|véhicule
🚒|camion de pompier|pin-pon|pompier
🚓|flic|patrouille|police|véhicule|voiture de police
🚔|police|véhicule|voiture de police de face|voiture de police qui arrive
🚕|moyen de transport|taxi|taxi jaune|uber|véhicule
🚖|joe le taxi|new york|taxi|taxi de face|taxi jaune|uber|voiture
🚗|automobile|conduire|moyen de transport|véhicule|voiture|voyage
🚘|automobile|conduire|moyen de transport|véhicule|voiture|voiture de face|voiture qui arrive|voyage
🚚|camion|camion de livraison|camionnette|moyen de transport|véhicule
🚛|camion|moyen de transport|poids lourd|semi|semi-remorque|véhicule
🚜|moyen de transport|tracteur|véhicule
🏎️|course|course automobile|formule 1|voiture|voiture de course
🏍️|course|moto
🛵|scooter
🚲|bicyclette|cyclisme|moyen de transport|vélo|voyage
🛴|trottinette
🚏|arrêt de bus|bus
🛤️|chemin de fer|rail|train|voie ferrée|voyage
⛽|diesel|essence|gazole|pompe à essence|station
🛞|cercle|pneu|roue|tourner|véhicule|voiture
🚨|alarme|alerte|gyrophare|lumière|police|sirène|urgences|voiture
🚥|carrefour|croisement|feu|feu de circulation|feu tricolore horizontal|tricolore
🚦|carrefour|croisement|feu|feu de circulation|feu tricolore vertical|tricolore
🚧|barrière|travaux
⚓|ancre|bateau|outil|voyage
⛵|bateau|mer|moyen de transport|plaisance|voilier|voyage|yacht
🚤|bateau|été|hors-bord|luxe|moyen de transport|vedette|voyage
🛳️|bateau|croisière|paquebot|voyage
⛴️|bateau|ferry|moyen de transport|voyage
🛥️|bateau|bateau à moteur
🚢|bateau|croisière|moyen de transport|navire|paquebot|Titanic|voyage
🛟|bouée de sauvetage|flotter|sauver|sauveteur|secours|sécurité
✈️|avion|avion en vol|jet|moyen de transport|véhicule|vol|voyage
🛩️|avion|moyen de transport|petit avion|voyage
🛫|avion|avion au décollage|décollage|départ|moyen de transport|voyage
🛬|arrivée|atterrissage|avion|avion à l’atterrissage|moyen de transport|voyage
💺|chaise|fauteuil|place|siège
🚁|hélico|hélicoptère|moyen de transport|véhicule
🚟|moyen de transport|train|train suspendu|voyage
🚠|montagne|moyen de transport|ski|télécabine|téléphérique
🚡|moyen de transport|télécabine|tramway|tramway aérien
🛰️|espace|satellite
🚀|décollage|espace|fusée|moyen de transport|voyage
🛸|alien|extraterrestre|ovni|OVNI|soucoupe volante
🌌|espace|voie lactée
⛱️|météo|parapluie|parapluie au sol|parasol|parasol sur le sol|plage|pluie|soleil|voyage
🎆|14 juillet|artifice|fête|feu d’artifice
🎇|14 juillet|artifice|cierge magique|étincelle|étincelles|fête|feu d’artifice
🎑|cérémonie|cérémonie de la lune|lune
🗿|île de Pâques|moai|moaï|monolithe|statue|voyage
🛂|contrôle|contrôle des passeports|passeport
🛃|douane|douanes
🛄|aéroport|arrivée|avion|bagages|retrait des bagages|valise|voyage
🛅|bagages|casier|clé|consigne|valise
🧗‍♂️|alpiniste|escalader|grimper|grimpeur|montagne|personne qui escalade|personne qui grimpe|sport homme|symbole de l’homme
🧗‍♀️|alpiniste|escalader|grimper|grimpeur|montagne|personne qui escalade|personne qui grimpe|sport femme|symbole de la femme
🏇|cheval|course de chevaux|course hippique|jockey|sport
⛷️|neige|ski|skieur|sport
🏂|homme|neige|ski|snowboard|snowboardeur|sport
🏌️‍♂️|balle|golf|golfeur|green|homme|joueur de golf|personne|pga|pitch|sport homme|symbole de l’homme
🏌️‍♀️|balle|golf|golfeur|green|homme|joueur de golf|personne|pga|pitch|sport femme|symbole de la femme
🏄‍♂️|glisse|homme|mer|océan|personne|personne faisant du surf|plage|planche|sport|surf|vagues homme|symbole de l’homme
🏄‍♀️|glisse|homme|mer|océan|personne|personne faisant du surf|plage|planche|sport|surf|vagues femme|symbole de la femme
🚣‍♂️|barque|bateau|lac|naviguer|pêche|personne|personne ramant dans une barque|ramer|rameur|rivière|sport homme|symbole de l’homme
🚣‍♀️|barque|bateau|lac|naviguer|pêche|personne|personne ramant dans une barque|ramer|rameur|rivière|sport femme|symbole de la femme
🏊‍♂️|crawl|eau|exercice|homme|nage|nageur|natation|personne|personne nageant|piscine|sport homme|symbole de l’homme
🏊‍♀️|crawl|eau|exercice|homme|nage|nageur|natation|personne|personne nageant|piscine|sport femme|symbole de la femme
⛹️‍♂️|athlétique|ballon|basket-ball|basketteur|dribble|joueur|match|personne|personne avec ballon|rebond|sport homme|symbole de l’homme
⛹️‍♀️|athlétique|ballon|basket-ball|basketteur|dribble|joueur|match|personne|personne avec ballon|rebond|sport femme|symbole de la femme
🏋️‍♂️|bodybuilding|entraînement|force|haltérophile|haltérophilie|homme|lever des poids|muscles|personne|poids|sport homme|symbole de l’homme
🏋️‍♀️|bodybuilding|entraînement|force|haltérophile|haltérophilie|homme|lever des poids|muscles|personne|poids|sport femme|symbole de la femme
🚴‍♂️|course|cycliste|guidon|homme|pédaler|personne|rouler|sport|tour de france|vélo homme|symbole de l’homme
🚴‍♀️|course|cycliste|guidon|homme|pédaler|personne|rouler|sport|tour de france|vélo femme|symbole de la femme
🚵‍♂️|coureur|cyclisme|grimper|homme en VTT|montagne|personne|personne en VTT|sport|tour de France|vélo|VTT homme|symbole de l’homme
🚵‍♀️|coureur|cyclisme|grimper|homme en VTT|montagne|personne|personne en VTT|sport|tour de France|vélo|VTT femme|symbole de la femme
🤸‍♂️|agilité|athlète|faire la roue|femme faisant la roue|gymnaste|gymnastique|personne|personne faisant la roue|roue|sport homme|symbole de l’homme
🤸‍♀️|agilité|athlète|faire la roue|femme faisant la roue|gymnaste|gymnastique|personne|personne faisant la roue|roue|sport femme|symbole de la femme
🤼‍♂️|bataille|lutte|lutteur|lutteurs|personnes|personnes faisant de la lutte|sport homme|symbole de l’homme
🤼‍♀️|bataille|lutte|lutteur|lutteurs|personnes|personnes faisant de la lutte|sport femme|symbole de la femme
🤽‍♂️|ballon|homme qui joue au water-polo|personne|personne jouant au water-polo|piscine|sport|water-polo homme|symbole de l’homme
🤽‍♀️|ballon|homme qui joue au water-polo|personne|personne jouant au water-polo|piscine|sport|water-polo femme|symbole de la femme
🤾‍♂️|athlète|ballon|handball|handballeur|lancer|personne|personne jouant au handball|sport homme|symbole de l’homme
🤾‍♀️|athlète|ballon|handball|handballeur|lancer|personne|personne jouant au handball|sport femme|symbole de la femme
🤹‍♂️|artiste|cirque|gérer|jongler|jongleur|multitâche|personne qui jongle homme|symbole de l’homme
🤹‍♀️|artiste|cirque|gérer|jongler|jongleur|multitâche|personne qui jongle femme|symbole de la femme
🧘‍♂️|détendu|femme|lotus|méditation|personne assise en position du lotus|personne dans la posture du lotus|position du lotus|relax|relaxation|tailleur|yoga|zen homme|symbole de l’homme
🧘‍♀️|détendu|femme|lotus|méditation|personne assise en position du lotus|personne dans la posture du lotus|position du lotus|relax|relaxation|tailleur|yoga|zen femme|symbole de la femme
🎪|chapiteau|cirque
🛹|glisse|longboard|planche à roulettes|roulettes|skate|skateboard
🎗️|mémoire|ruban|ruban de mémoire|souvenir
🎟️|billet d’entrée|place|spectacle
🎫|billet|place|spectacle
🎖️|médaille|médaille militaire
🏆|champion|championne|coupe|gagner|prix|trophée|victoire
🏅|champion|championne|médaille|médaille d’or|médaille sportive|sport|vainqueur|victoire
🥇|1er|médaille|médaille d’or|or|premier
🥈|2e|argent|deuxième|médaille|médaille d’argent
🥉|3e|bronze|médaille|médaille de bronze|troisième
⚽|balle|ballon|ballon de football|football|sport
⚾|balle|balle de baseball|baseball|sport
🥎|balle|gant|softball|sports
🏀|ballon|basket|basket-ball|panier|sport
🏐|ballon|jeu|match|sport|volley|volley-ball
🏈|ballon|football américain|sport|Super Bowl
🏉|ballon|rugby|sport
🎾|balle|balle de tennis|sport|tennis
🥏|discoplane|disque|disque volant|disque-volant|frisbee|sport|ultimate|ultime-passe
🎳|boule|bowling|jeu|partie|quilles|sport|strike
🏏|balle|balle de cricket|batte|cricket|jeu|match|sport
🏑|balle|crosse|hockey|hockey sur gazon|sport
🏒|crosse|hockey|hockey sur glace|palet|sport
🥍|balle|but|crosse|lacrosse|raquette|sport
🏓|balle|jeu|partie|ping-pong|raquette|sport|tennis de table
🏸|badminton|jeu|match|raquette|sport|volant
🪃|aborigène|australie|boomerang|jeu|outil|répercussion|retour
🥅|but|cage|filet|sport
⛳|drapeau de golf|golf|sport|trou
🪁|cerf-volant|planer|voler
🛝|aire de jeu|glissade|jouer|toboggan
🏹|arc|arc et flèche|archer|astrologie|flèche|horoscope|Sagittaire|sport|tir à l’arc|zodiaque
🎣|canne à pêche|pêche|pêche à la ligne|sport
🤿 |apnée|masque|masque de plongée|masque et tuba|plongée|plonger|snorkeling|tuba
🥊|boxe|gant|gant de boxe|sport
🥋|arts martiaux|judo|karaté|kimono|sport|taekwondo|tenue|tenue d’arts martiaux
🎽|athlétisme|course à pied|jogging|maillot de course|running|sport|tee-shirt de course
🛼|derby|patin à roulettes|roller|roulette|roulettes|sport
🛷|glisser|luge|neige|traîneau
⛸️|glace|patin|patin à glace|patiner|patinoire|sport
🥌|curling|granit|jeu|match|partie|pierre|pierre de curling|sport
🎿|neige|ski|sport
🎯|cible|dans le mille|fléchettes|jeu
🎱|8|billard|boule de billard|boule magique|huit|jeu|pool
🎮|jeu vidéo|joystick|manette|playstation|xbox
🎰|casino|jeu|machine à sous
🎲|dé|dés|hasard|jeu
🧩|assemblage|énigme|indice|interloqué|pièce de puzzle|pièce manquante|puzzle
♟️|duper|échec|pion d’échec|sacrifiable
🎭|acteur|actrice|art|masque|spectacle|spectacle vivant|théâtre
🎨|art|artiste|couleurs|musée de peinture|palette de peinture|peindre|peintre|peinture
🎼|musique|note|partition
🎤|chanter|karaoke|karaoké|micro|microphone|musique
🎧|casque|écouteur|écouteurs|musique|son
🎷|instrument|musique|saxophone
🎸|guitare|guitare électrique|instrument|musique
🎹|clavier|instrument|musique|piano|touches
🎺|instrument|musique|trompette
🎻|instrument|musique|violon
🥁|baguette|baguettes|batterie|musique|tambour
🎬|action|ça tourne|clap|film
💌|amour|cœur|lettre|lettre d’amour|Saint-Valentin
🕳️|trou
💣|bande dessinée|BD|bombe|boum|danger|dessin|explosion
🛀|baignoire|bain|personne prenant un bain|personne qui prend un bain
🛌|auberge|bonne nuit|coucher|dodo|dormir|fatigué|hôtel|lit|personne au lit|sieste
🏺|amphore|astrologie|cuisine|grec|Grèce|horoscope|vase|Verseau|zodiaque
🗺️|carte|carte du monde|monde|planisphère|voyage
🧭|boussole|compas|direction|magnétique|navigation|orientation
🧱|argile|brique|briques|mortier|mur|mur de briques|the wall|voie 9 3/4
💈|barbier|coiffeur|coiffure|enseigne|enseigne de barbier|salon
🛢️|baril|baril de pétrole|pétrole
🛎️|cloche|cloche de comptoir|clochette|hôtel|réception|sonnette
⌛|chronomètre|minuteur|sable|sablier|temps
⏳|attendre|chronomètre|minuteur|sable|sablier|sablier avec sable qui coule|temps
⌚|heure|montre
⏰|alarme|attendre|dring|heure|matin|retard|réveil|sonnerie
⏱️|chronomètre|heure|temps
⏲️|heure|horloge|minuteur|temps
🕰️|horloge|horloge posée|pendule
🌡️|météo|thermomètre
🧨|dynamite|étincelle|explosif|explosive|feu d’artifice|pétard|tnt
🎈|anniversaire|ballon|ballon de baudruche|ballon gonflable|fête
🎉|anniversaire|cotillons|fête|super
🎊|anniversaire|confettis|fête
🎎|festival|Japon|poupées|poupées japonaises
🎏|carpe|fête|koinobori
🎐|carillon|carillon éolien|clochette|fête|vent
🪩|boule à facettes|briller|danse|disco|fête|soirée
🧧|argent|bonne chance|cadeau|enveloppe rouge|hóngbāo|lai see
🎀|fête|nœud|ruban|ruban rose
🎁|anniversaire|cadeau|cadeau emballé|fête|Noël|nœud|surprise
🔮|avenir|boule de cristal|cristal|magie|voyant|voyante
🧿|amulette|l’oeil bleu|mauvais oeil|mauvais œil|nazar|nazar boncuk|nazarboncuk|œil bleu|perle|superstition|talisman|talisman turc
🪬|amulette|chance|Fatma|hamsa|khamsa|main de Fatma|Myriam|protection
🕹️|jeu|jeu vidéo|joystick|manette de jeu
🧸|jeu|jouet|nounours|ours|ours en peluche|peluche
🖼️|art|cadre avec image|image|musée|peinture|tableau|tableau encadré
🛍️|achats|courses|sac|sacs|sacs de shopping|shopping
📿|accessoire|chapelet|collier|perles|prière|religion|vêtements
💎|argent|bijou|diamant|fiançailles|joyau|mariage|pierre précieuse|romantique
📯|cor de facteur|cor postal|facteur|poste
🎙️|chant|enregistrement|micro|micro de studio|microphone|musique|studio
🎚️|curseur|curseur de niveau|musique|niveau
🎛️|boutons|boutons de commande|boutons de contrôle|boutons de réglage|commande|musique|réglages
📻|actualités|communication|loisirs|musique|radio|vidéo
📱|communication|smartphone|téléphone|téléphone portable
📲|appel|appel entrant|communication|recevoir un appel|smartphone|téléphone portable avec une flèche
☎️|téléphone|téléphone rouge
📞|combiné téléphonique|communication|téléphone
📟|bip|bipeur|communication|pager
📠|communication|fax|télécopieur
🔋|pile
🪫|batterie|batterie faible|déchargé|électronique|énergie faible|pile faible
🔌|branché|câble avec fiche électrique|électricité|prise|prise électrique
💻|bureau|ordinateur|ordinateur portable|travail
🖥️|moniteur|ordinateur|ordinateur de bureau
🖨️|imprimante|imprimer|ordinateur
⌨️|clavier|informatique|ordinateur
🖱️|informatique|souris|souris d’ordinateur
🖲️|boule de commande|informatique|ordinateur|souris à boule|trackball
💽|disque|disque d’ordinateur|minidisc
💾|disque|disquette|informatique|ordinateur
💿|blu-ray|CD|disque|DVD
📀|blu-ray|CD|disque|DVD
🧮|abaque|boulier|calcul|calculation|math|mathématiques
🎥|caméra|cinéma|film|filmer|réalisateur|réalisatrice|vidéo
🎞️|bande|cinéma|film|pellicule
📽️|cinéma|film|projecteur|projecteur cinématographique|vidéo
📺|petit écran|télé|téléviseur|télévision|TV
📷|appareil photo|photo|selfie|vidéo
📸|appareil photo|appareil photo avec flash|flash
📹|caméra|caméscope|filmer|vidéo
📼|cassette vidéo|magnétoscope|vhs|vidéocassette|vintage
🔍|agrandir|chercher|détective|loupe|loupe gauche|loupe orientée à gauche|recherche
🔎|agrandir|chercher|détective|loupe|loupe droite|loupe orientée à droite|recherche
🕯️|bougie|chandelle|lumière
💡|allumer|ampoule|bande dessinée|BD|dessin|idée|lampe|lumière
🔦|lampe électrique|lampe torche|lumière|outil|torche
🏮|japonais|lampion rouge|lanterne|lumière|restaurant|rouge
📔|cahier|carnet|carnet avec couverture|école|écrire|livre
📕|apprendre|école|enseignement|lire|littérature|livre|livre fermé|livre rouge|manuel scolaire|savoir
📖|apprendre|bibliothèque|école|enseignement|étudier|lecture|lire|littérature|livre|livre ouvert|manuel scolaire|roman|savoir
📗|apprendre|bibliothèque|école|enseignement|étudier|lecture|lire|littérature|livre|livre vert|manuel scolaire|savoir
📘|apprendre|école|éducation|lecture|lire|littérature|livre|livre bleu|manuel scolaire|roman
📙|apprendre|école|éducation|lecture|lire|littérature|livre|livre orange|manuel scolaire|roman
📚|apprendre|bibliothèque|école|enseignement|étudier|lecture|lire|littérature|livre|livres|manuels scolaires|roman|savoir
📓|cahier|carnet|écrire
📃|document|page|page enroulée
📜|papier|parchemin
📄|document|page
📰|actualités|communication|gros titres|journal|presse|une
🗞️|actualités|journal|journal roulé|presse
📑|marque|marqueur|onglets|signet|signets
🔖|marque-page|marqueur|signet
🏷️|étiquette
💰|argent|avare|banque|dollar|parier|payer|sac|sac d’argent|sac plein d’argent
💴|argent|billet|billet de banque|billet en yens|payer|yens
💵|argent|billet|billet de banque|billet en dollars|dollar|payer
💶|argent|billet|billet de banque|billet en euros|euros|payer
💷|argent|billet|billet de banque|billet en livres|livres|payer
💸|ailes|argent|billet|billet avec des ailes|billet de banque|dollars|payer
💳|argent|bancaire|banque|carte|carte de crédit|payer
🪪|carte d’identité|justificatif|papiers|permis de conduire|pièce d’identité|sécurité
🧾|compta|comptabilité|comptable|facture|faire les comptes|justificatif|preuve|reçu|ticket de caisse
✉️|courrier électronique|e-mail|enveloppe|lettre|message
📧|courriel|courrier électronique|e-mail|lettre|message
📨|courriel|courrier|courrier électronique|e-mail|enveloppe|envoyer|lettre|message|message électronique|message reçu|recevoir
📩|communication|courriel|courrier électronique|e-mail|enveloppe|enveloppe avec flèche|envoi|envoyer|flèche|message|message électronique|message envoyé
📤|boîte d’envoi|courriel|courrier électronique|e-mail|envoyer|flèche|lettre|message|message électronique
📥|boîte de réception|courriel|courrier électronique|e-mail|flèche|lettre|message|message électronique|recevoir
📦|boîte|colis|livraison|paquet
📫|boîte aux lettres|boîte aux lettres fermée drapeau levé|courrier
📪|boîte aux lettres|boîte aux lettres fermée drapeau baissé|courrier
📬|boîte aux lettres|boîte aux lettres ouverte drapeau levé|courrier
📭|boîte aux lettres|boîte aux lettres ouverte drapeau baissé|courrier
📮|boîte aux lettres|courrier|poste
🗳️|a voté|bulletin de vote|urne|urne électorale|urne électorale avec un bulletin|voter
✏️|crayon|crayon à papier|gomme|mine
✒️|écrire|stylo|stylo plume noir
🖋️|écrire|stylo|stylo plume
🖊️|écrire|stylo|stylo bille|stylo-bille
🖌️|peinture|pinceau
🖍️|crayon pastel|pastel|rouge
📝|bloc-notes|crayon|écrire|mémo
📁|dossier|fichier|répertoire
📂|dossier|dossier ouvert|ouvrir|ouvrir le dossier|répertoire
🗂️|classement|classeur|index|intercalaire|intercalaires
📅|calendrier|date
📆|agenda|calendrier|date|éphéméride|planning
🗒️|bloc-notes à spirale|bloc-notes à spirales|cahier|notes
🗓️|bloc-notes|calendrier|calendrier à spirale|calendrier à spirales
📇|carnet d’adresses|carte|fiche|index|rolodex|vintage
📈|croissance|données|graphique|graphique en hausse|hausse|haut|tendance
📉|baisse|bas|chute|données|graphique|graphique en baisse|négatif|tendance
📊|données|graphique|graphiques à barres
📋|fournitures|liste|porte-bloc|presse-papiers
📌|fournitures|punaise
📍|carte|emplacement|épingle|fournitures|punaise ronde
📎|fournitures|trombone
🖇️|fournitures|trombones
📏|fournitures|mathématiques|règle|règle plate
📐|équerre|fournitures|mathématiques
✂️|ciseaux|couper|découper|fournitures|papier
🗃️|boîte à dossiers|classeur|dossier
🗄️|classement|classer|classeur|dossier|meuble|meuble à dossiers
🗑️|corbeille|corbeille à papiers|poubelle
🔒|cadenas|cadenas fermé|privé|verrouillé|verrouiller
🔓|cadenas|déverrouiller|ouvert|ouvrir
🔏|cadenas avec un stylo plume|cadenas fermé avec stylo|confidentiel|privé|stylo plume|verrouillé
🔐|cadenas|cadenas avec une clé|cadenas fermé avec clé|clé|fermé|privé|sécurisé|verrouillé
🔑|clé|mot de passe|ouvrir|serrure
🗝️|clé|clé ancienne|fermer|indice|serrure|verrouiller
🔨|marteau|outil|réparer|travaux
⛏️|mine|outil|pioche
⚒️|burin|marteau|marteau et burin|marteau et pioche|outil|outils|pioche
🛠️|clé|clé à molette|marteau|marteau et clé à molette|outil|outils
🔪|arme|chef|couteau|couteau de cuisine|cuisine|outil
🗡️|arme|couteau|dague|poignard
⚔️|arme|armes|croisées|épées
🔫|arme|arme à feu|flingue|pistolet|pistolet à eau|revolver
🛡️|arme|bouclier
🔧|clé|clé à molette|outil|travaux
🔩|boulon|écrou|outil|travaux|vis|vis et écrou
⚙️|engrenage|outil|roue dentée
🗜️|compresser|comprimer|outil|serre-joint|serre-joints
⚖️|astrologie|balance|balance à poids|horoscope|justice|poids|zodiaque
🔗|chaîne|chaînons|maillons|mousqueton
⛓️|chaîne|chaînes
🧰|boîte à outils|caisse à outils|coffre|mécanique|mécano|outil|outils
🧲|aimant|aimanter|attirer|attraction|fer à cheval|magnet|magnétique|positif négatif
⚗️|alambic|chimie|outil
🧪|chimie|chimiste|expérience|expérimentation|labo|laboratoire|réaction|science|sciences|tube à essai
🧫|bactérie|bactériologie|biologie|biologiste|boîte de petri|boîte de pétri|culture|labo|laboratoire|micro-organismes|microbiologie|science
🧬|adn|biologie|biologiste|évolution|gène|génétique|science|vie
🔬|expérience|laboratoire|microscope|outil|science
🩻|cage thoracique|docteur|médical|os|radiographie|rayons X|squelette
🔭|astronomie|espace|outil|planètes|science|télescope
📡|antenne|antenne parabolique|parabole|satellite|science
💉|aiguille|docteur|malade|médecine|piqûre|seringue|vaccin|vaccination
💊|docteur|gélule|malade|médecine|médicament|pilule|vitamines
🚪|placard|porte|porte d’entrée
🛏️|dormir|hôtel|lit
🛋️|canapé|canapé avec une lampe|canapé et lampe|lampe
🚽|cabinets|toilettes|WC
🚿|douche|eau|pommeau de douche
🛁|baignoire|bain|mousse
🧴|après-shampoing|bouteille de lotion|crème hydratante|crème pour le corps|crème solaire|flacon|hydratant|lotion|shampoing|shampooing
🧷|couche|épingle à nourrice|épingle de nourrice|épingle de sûreté|imperdable|lange|punk rock
🧹|balai|balais|balayage|ménage|nettoie|nettoyage|nettoyé|nettoyer|sorcière
🧺|agriculture|cueillette|lessive|linge|panier|pique-nique
🧻|essuie-tout|papier hygiénique|papier toilette|rouleau de papier|rouleau de pq
🧼|bain|bulles|lavage|laver|me lave|me laver|mousse|pain de savon|porte-savon|savon|se lave|se laver
🧽|absorbante|absorbe|éponge|laver|nettoyage|nettoyer|poreuse|savonner
🧯|chaud|éteindre|extincteur|feu|fire|incendie
🚬|cigarette|cigarette allumée|fumer|fumeur|signe Fumeur
⚰️|cercueil|enterrement|mort|obsèques|vampire
⚱️|cendres|mort|obsèques|urne|urne funéraire
🚰|eau|eau du robinet|eau potable|robinet
💘|amour|cœur|cœur et flèche|coeur transpercé|Cupidon|flèche|sentiment
💝|amour|anniversaire|cœur|cœur avec ruban|ruban|Saint-Valentin|sentiment
💖|amour|cœur|cœur étincelant|étincelles|sentiment
💗|amour|cœur|cœur battant|cœur grandissant|cœur qui bat|pulsations|sentiment
💓|amour|cardio|cœur|cœur battant|cœur qui bat|pulsations|sentiment
💞|amour|anniversaire|cœurs|cœurs qui tournent|deux cœurs|sentiment|tourbillon
💕|amour|anniversaire|cœurs|deux cœurs|deux cœurs roses|petits cœurs|rendez-vous|sentiment
💟|amour|cœur|cœur blanc|cœur décoré|cœur violet|décoration avec cœur|sentiment
❣️|amour|cœur|cœur point d’exclamation|exclamation|ponctuation
💔|amour|cœur|cœur brisé|malheureux|sentiment|séparé|triste
❤️‍🔥|amour|cœur|rouge|sentiment|feu|enflammé
❤️|amour|cœur|cœur rouge|sentiment
🧡|coeur orange|cœur orange|orange
💛|amour|cœur|cœur jaune|sentiment
💚|amour|cœur|sentiment|vert
💙|amour|cœur|cœur bleu|sentiment
💜|amour|cœur|sentiment|violet
🖤|cœur|noir
💯|100|cent|cent points|score
💢|bande dessinée|BD|colère|dessin|furieux|symbole de colère
💬|bande dessinée|BD|bulle|bulle de parole|dialogue|écrire|message|SMS
👁️‍🗨️|corps|œil bulle|bulle à gauche|bulle de parole gauche|dialogue|gauche
🗯️|bande dessinée|BD|bulle|colère|crier|droite|hurler
💭|bande dessinée|BD|bulle|bulle de pensée|idée|imaginer|inventer|invention|pensée|penser|rêve|rêver
💤|bande dessinée|BD|bonne nuit|dormir|endormi|fatigué|ronfler|zzz
♨️|chaud|source|sources chaudes|vapeur
🛑|octogonal|panneau|signe|stop
🕛|0 h|12 h|heure|horloge|midi|midi pile|midi/minuit|minuit|minuit pile
🕧|00 h 30|12 h 30|heure|horloge|midi et demi|midi/minuit et demie|minuit et demi
🕐|1 h|13 h|heure|horloge|treize heures|une heure
🕜|1 h 30|13 h 30|heure|horloge|treize heures trente|une heure et demie
🕑|14 h|2 h|deux heures|heure|horloge|quatorze heures
🕝|14 h 30|2 h 30|deux heures et demie|heure|horloge|quatorze heures trente
🕒|15 h|3 h|heure|horloge|quinze heures|trois heures
🕞|15 h 30|3 h 30|heure|horloge|quinze heures trente|trois heures et demie
🕓|16 h|4 h|quatre heures|seize heures
🕟|16 h 30|4 h 30|heure|horloge|quatre heures et demie|seize heures trente
🕔|17 h|5 h|cinq heures|dix-sept heures|heure|horloge
🕠|17 h 30|5 h 30|cinq heures et demie|dix-sept heures trente|heure|horloge
🕕|18 h|6 h|dix-huit heures|heure|horloge|six heures
🕡|18 h 30|6 h 30|dix-huit heures trente|heure|horloge|six heures et demie
🕖|19 h|7 h|dix-neuf heures|heure|horloge|sept heures
🕢|19 h 30|7 h 30|dix-neuf heures trente|heure|horloge|sept heures et demie
🕗|20 h|8 h|heure|horloge|huit heures|vingt heures
🕣|20 h 30|8 h 30|heure|horloge|huit heures et demie|vingt heures trente
🕘|21 h|9 h|neuf heures
🕤|21 h 30|9 h 30|heure|horloge|neuf heures et demie|vingt et une heures trente
🕙|10 h|22 h|dix heures|heure|horloge|vingt-deux heures
🕥|10 h 30|22 h 30|dix heures et demie|heure|horloge|vingt-deux heures trente
🕚|11 h|23 h|heure|horloge|onze heures|vingt-trois heures
🕦|11 h 30|23 h 30|heure|horloge|onze heures et demie|vingt-trois heures trente
🌀|cyclone|spirale|tourbillon|typhon|vertige
♠️|carte|couleur|jeu|pique
♥️|cartes à jouer|cœur|cœur cartes|couleur|jeu|rouge
♦️|carreau|carreaux|carte|couleur|jeu
♣️|cartes à jouer|couleur|jeu|noir|trèfle|trèfle cartes
🃏|carte Joker|cartes à jouer|jeu|Joker
🀄|dragon rouge mahjong|jeu|mah-jong|mahjong|rouge
🎴|carte|carte à jouer|fleur|fleurs|japonais|jeu|jeu des fleurs
🔇|chut|enceinte|haut-parleur barré|haut-parleur d’enceinte|muet|silence|son|sourdine
🔈|enceinte|haut-parleur|haut-parleur d’enceinte|son|volume bas|volume des enceintes faible
🔉|enceinte|haut-parleur|haut-parleur d’enceinte|son|volume des enceintes moyen|volume moyen
🔊|enceinte|fort|haut-parleur|haut-parleur d’enceinte|musique|son|volume des enceintes élevé|volume élevé
📢|communication|fort|haut-parleur|mégaphone|message|son
📣|encourager|hourra|manifestation|mégaphone|porte-voix
🔔|cloche|clochette|sonner
🔕|alarme désactivée|barrée|cloche|silence
🎵|musique|note|note de musique
🎶|musique|note|notes|notes de musique|partition
🏧|argent|banque|dab|distributeur|distributeur automatiques de billets|distributeur de billets|guichet automatique|retrait
🚮|corbeille|déchets|icône Poubelle|jeter|poubelle
♿|accès|accès handicapés|fauteuil roulant|mobilité réduite|symbole Accès handicapés
🩼|accident|aide|béquille|blessé|boiter|canne|handicap
🚹|homme|symbole Homme|symbole Toilettes hommes|toilettes|WC
🚺|femme|symbole Femme|symbole Toilettes femmes|toilettes|WC
🚻|panneau Toilettes|toilettes|WC
🚼|bébé|espace de change|symbole Bébé
🚾|toilettes|WC
⚠️|attention|avertissement|symbole d’avertissement
🚸|circulation|école|enfants|piétons|traversée d’enfants
⛔|circulation|entrée interdite|interdiction|interdit|non|panneau|sens interdit
🚫|entrée interdite|interdiction|interdit|symbole d’interdiction
🚳|bicyclette|interdiction|interdit|vélo|vélos interdits
🚭|cigarette barrée|fumer|interdiction|interdiction de fumer|interdit|interdit de fumer
🚯|déchets|dépôt d’ordures interdit|interdiction|interdit|ne pas jeter
🚱|eau|eau non potable|imbuvable|interdiction|interdit|ne pas boire
🚷|interdiction|interdit|interdit aux piétons
🔞|18 ans et plus|dix-huit|interdiction|interdit|interdit aux mineurs|interdit aux moins de dix-huit ans|limite d’âge|majorité|mineur
☢️|radioactif|radioactivité|symbole
☣️|danger|danger biologique|symbole
⬆️|direction|flèche|flèche haut|nord|sens
↗️|direction|flèche|flèche haut droite|nord-est|sens
➡️|direction|droite|est|flèche|sens
↘️|direction|flèche|flèche bas droite|sens|sud-est
⬇️|direction|flèche|flèche bas|sens|sud
↙️|direction|flèche|flèche bas gauche|sens|sud-ouest
⬅️|direction|flèche|flèche gauche|ouest|sens
↖️|direction|flèche|flèche haut gauche|nord-ouest|sens
↕️|flèche|flèche dans les deux sens|flèche haut bas
↔️|flèche|flèche gauche droite
↩️|flèche|flèche courbe gauche
↪️|flèche|flèche courbe droite
⤴️|flèche|flèche courbe haut|flèche courbe vers la droite et le haut
⤵️|bas|flèche|flèche courbe bas
🔃|actualiser|flèche|flèches dans le sens horaire|sens des aiguilles d’une montre|sens horaire|symbole Recharger
🔄|actualiser|flèche|flèches|flèches dans le sens antihoraire|retour|sens antihoraire|sens contraire des aiguilles d’une montre|sens horaire inverse|sens inverse des aiguilles d’une montre
🔙|flèche|flèche vers la gauche|retour
🔚|fin|flèche|flèche vers la gauche
🔛|activé|droite et gauche|flèche|flèche dans les deux sens
🔜|bientôt|flèche
🔝|flèche|flèche En haut|flèche vers le haut|haut
🛐|culte|lieu de culte|prier|religion
⚛️|athée|atome|symbole de l’atome
🕉️|hindou|om|religion
✡️|David|étoile|étoile de David|judaïsme|juif|Juif|juive|religion
☸️|bouddhisme|bouddhiste|dharma|religion|roue|roue de dharma|roue du Dharma
☯️|complémentaire|religion|tao|taoïsme|yang|yin
✝️|chrétien|chrétienne|croix|croix latine|religion
☦️|chrétien|chrétienne|croix|croix orthodoxe|religion
☪️|étoile|islam|lune|lune et étoile|musulman|musulmane|ramadan|religion
☮️|paix|paix et amour|peace and love|symbole de paix
🕎|candélabre|chandelier|chandelier à sept branches|Hanoucca|Hanoukka|judaïsme|juif|juive|menora|menorah|religion
🔯|chance|étoile|étoile à 6 branches|judaïsme|juif|juive
♈|astrologie|Bélier|horoscope|zodiaque
♉|astrologie|horoscope|taureau|Taureau|zodiaque
♊|astrologie|gémeaux|Gémeaux|horoscope|zodiaque
♋|astrologie|cancer|Cancer|crabe|horoscope|zodiaque
♌|astrologie|horoscope|lion|Lion|zodiaque
♍|astrologie|horoscope|vierge|Vierge|zodiaque
♎|astrologie|balance|Balance|horoscope|justice|zodiaque
♏|astrologie|horoscope|Scorpion|zodiaque
♐|astrologie|horoscope|sagittaire|Sagittaire|zodiaque
♑|astrologie|capricorne|Capricorne|chèvre|horoscope|zodiaque
♒|astrologie|eau|horoscope|verseau|Verseau|zodiaque
♓|astrologie|horoscope|poissons|Poissons|zodiaque
⛎|ophiuchus|Ophiuchus|serpent|serpentaire|zodiaque
🔀|bouton lecture aléatoire|flèche|flèches croisées|lecture aléatoire
🔁|bouton répéter|bouton répétition|flèche|flèches en cercle|répéter|sens des aiguilles d’une montre|sens horaire
🔂|bouton répétition de la piste|flèche|flèches en cercle avec n°1|répéter|répéter une fois|sens des aiguilles d’une montre|sens horaire
▶️|bouton lecture|droite|flèche|lecture|lire|triangle
⏩|avance|avance rapide|bouton|bouton avance rapide|double flèche|flèche Avance rapide
◀️|bouton retour|flèche|gauche|retour|triangle
⏪|bouton|bouton retour rapide|double flèche|flèche|flèche Retour rapide|retour|retour rapide
🔼|bouton haut|flèche|haut|petit triangle haut
⏫|double flèche vers le haut|flèche double|flèche vers le haut|haut|rapide
🔽|bas|bouton bas|flèche|petit triangle bas
⏬|bas|double flèche vers le bas|flèche double|flèche vers le bas|rapide
⏹️|bouton stop|carré|stop
⏏️|bouton éjecter|éjecter
🎦|caméra|cinéma|film
🔅|brillance|lumière|luminosité|luminosité faible|soleil
🔆|brillance|lumière|luminosité|luminosité élevée|soleil
📶|barres de réseau|communication|couverture|portable|réception|réseau|téléphone
📳|communication|mode vibreur|portable|téléphone|vibreur
📴|éteindre|portable|téléphone|téléphone éteint
♾️|éternité|illimité|infini|universel
♻️|recyclage|symbole Recyclage
🔱|ancre|bateau|fourche|mer|Poséidon|trident
📛|badge|badge nominatif|nom
🔰|chevron|chevron jaune et vert|débutant|symbole japonais|symbole japonais de débutant
⭕|0|anneau|cercle|gros cercle|o|O|rouge
✅|✓|bouton coché|carré|coche|coche blanche|marque|OK|oui|sélection|terminé|voilà
☑️|✓|bouton|carré|case cochée|coche|OK|oui|sélection|terminé|voilà
✔️|✓|coche|coche noire|OK|oui|sélection|terminé|voilà
❌|×|annuler|croix|croix rouge|multiplication|multiplier|x
❎|×|bouton croix|croix|multiplier|vert|x
➕|+|addition|ajouter|arithmétique|mathématiques|plus|signe plus|signe Plus|somme
➖|-|−|arithmétique|mathématiques|moins|signe moins|signe Moins|soustraction|soustraire
➗|÷|algèbre|diviser|division|math|mathématique|mathématiques|signe
✖️|*|×|annuler|croix noire|multiplication|multiplier|non|signe multiplier|x
🟰|égal|égalité|mathématiques|réponse|signe égal gras
➰|boucle|bouclette
➿|boucle|double boucle
〽️|alternance|symbole
✳️|*|astérique|astérique huit branches|astérisque|astérisque huit branches|étoile|huit
✴️|*|astérisque|étoile|étoile huit branches|huit
❇️|*|briller|éclat|étinceler|étincelle|scintiller
‼️|!|!!|double point d’exclamation|exclamation|point|ponctuation|surprise
⁉️|!|!?|?|exclamation|interrogation|point d’exclamation et d’interrogation|points d’exclamation et d’interrogation|ponctuation|question|surprise
❓|?|interrogation|point d’interrogation|point d’interrogation rouge|ponctuation|question
❔|?|interrogation|point d’interrogation blanc|ponctuation|question
❕|!|exclamation|point d’exclamation blanc|ponctuation|surprise
❗|!|exclamation|point d’exclamation|point d’exclamation rouge|ponctuation
©️|©|c|copyright|droits d’auteur|propriété intellectuelle|symbole copyright|symbole Copyright
®️|®|marque commerciale|marque déposée|r
™️|marque commerciale déposée|marque déposée|TM
#️⃣|Keycap Number Sign
0️⃣|Keycap Digit Zero
1️⃣|Keycap Digit One
2️⃣|Keycap Digit Two
3️⃣|Keycap Digit Three
4️⃣|Keycap Digit Four
5️⃣|Keycap Digit Five
6️⃣|Keycap Digit Six
7️⃣|Keycap Digit Seven
8️⃣|Keycap Digit Eight
9️⃣|Keycap Digit Nine
🔟|Keycap: 10
🔠|ABCD|alphabet latin|lettres|lettres latines|majuscules|saisie|saisie en lettres majuscules
🔡|abcd|alphabet latin|lettre|lettres|lettres latines|minuscules|saisie|saisie de lettres minuscules
🔢|1234|chiffres|saisie|saisie de chiffres
🔣|saisie|saisie de symboles|symboles
🔤|abc|alphabet|alphabet latin|lettres|saisie|saisie de lettres
🅰️|A|groupe sanguin|groupe sanguin A
🆎|AB|groupe sanguin|groupe sanguin AB
🅱️|B|groupe sanguin|groupe sanguin B
🆑|bouton Effacer|CL|effacer|icône Effacer
🆒|bouton Cool|cool|icône Cool
🆓|bouton Gratuit|gratuit|icône Gratuit
ℹ️|guichet d’informations|i|informations|source d’informations
🆔|bouton|icône Identifiant|ID|identifiant
Ⓜ️|cercle|m|m encerclé
🆕|bouton Nouveau|icône Nouveau|nouveau|nouveauté
🆖|bouton NG|bouton Pas bien|interdit|mauvais|NG
🅾️|groupe sanguin|groupe sanguin O|O
🆗|bouton OK|icône OK|OK
🅿️|bouton|P|panneau parking|parking
🆘|à l’aide|au secours|bouton SOS|icône SOS|SOS
🆙|bouton Vers le haut|icône Nouveauté|nouveau|nouveauté|up
🆚|bouton VS|contre|icône Contre|versus|vs
🈁|bouton ici en japonais|ici|idéogramme|idéogramme katakana ici|japonais
🈂️|bouton frais de service en japonais|frais de service|idéogramme katakana|japonais
🈷️|bouton montant mensuel en japonais|idéogramme|japonais|montant mensuel
🈶|bouton pas gratuit en japonais|idéogramme|japonais|pas gratuit|payant
🈯|bouton réservé en japonais|idéogramme|japonais|réservé
🉐|bonne affaire|bouton bonne affaire en japonais|idéogramme|idéogramme avantage|japonais
🈹|bouton réduction en japonais|idéogramme|japonais|rabais|réduction
🈚|bouton gratuit en japonais|gratuit|idéogramme|japonais
🈲|bouton interdit en japonais|idéogramme|idéogramme interdit|japonais
🉑|acceptable|accepter|bouton accepter en japonais|idéogramme|japonais
🈸|application|bouton application en japonais|idéogramme|idéogramme appliquer|japonais
🈴|bouton note pour réussir en japonais|idéogramme|japonais|note de passage|note pour réussir
🈳|bouton chambres disponibles en japonais|chambres disponibles|idéogramme|idéogramme vide|japonais
㊗️|bouton félicitations en japonais|félicitations|idéogramme|japonais
㊙️|bouton secret en japonais|idéogramme|japonais|secret
🈺|bouton ouvert pour affaires en japonais|idéogramme|japonais|ouvert|ouvert pour affaires
🈵|bouton complet en japonais|complet|idéogramme|idéogramme plénitude|japonais
🔴|cercle|disque rouge|forme géométrique|géométrie|rond|rouge
🔵|bleu|cercle|disque bleu|forme géométrique|géométrie|rond
⚫|cercle|disque noir|forme géométrique|géométrie|noir|rond
⚪|blanc|cercle|disque blanc|forme géométrique|géométrie|rond
⬛|carré|forme|forme géométrique|géométrie|grand carré noir
⬜|carré|forme|géométrie|grand carré blanc
◼️|carré|carré moyen noir|forme|forme géométrique|géométrie
◻️|carré|carré moyen blanc|forme|forme géométrique|géométrie
◾|carré|carré petit moyen noir|forme|géométrie
◽|carré|carré petit moyen blanc|forme|géométrie
▪️|carré|forme|forme géométrique|géométrie|petit carré noir
▫️|carré|forme|forme géométrique|géométrie|petit carré blanc
🔶|forme géométrique|géométrie|grand losange orange|losange
🔷|forme géométrique|géométrie|grand losange bleu|grand losange orange|losange
🔸|forme géométrique|géométrie|losange|petit losange orange
🔹|forme géométrique|géométrie|losange|petit losange bleu
🔺|flèche|forme géométrique|géométrie|rouge|triangle haut|triangle rouge pointant vers le haut|triangle rouge pointé vers le haut
🔻|bas|flèche|forme|géométrie|rouge|triangle bas|triangle rouge pointant vers le bas|triangle rouge pointé vers le bas
💠|bande dessinée|BD|dessin|diamant|diamant avec un point|géométrie|géométrique|intérieur
🔳|bouton|carré|carré blanc|forme|géométrie
🔲|bouton|carré|carré noir|forme|géométrie
🏁|course automobile|damier|drapeau|drapeau à damier|formule 1|ligne d’arrivée|sport automobile|vainqueur
🚩|drapeau|drapeau rouge|drapeau triangulaire|fanion|golf
🎌|drapeaux|drapeaux croisés|japonais
🏴|drapeau|drapeau noir|drapeau qui flotte au vent
🏳️|drapeau|drapeau blanc|drapeau qui flotte au vent
🏳️‍🌈|drapeau|drapeau blanc|drapeau qui flotte au vent arc-en-ciel|bisexuel|bisexuelle|gay|Gay Pride|homosexuel|homosexuelle|lesbienne|LGBT|LGBTQ|LGBTQIA|météo|nature|orgueil|pluie|trans|transgenre
🏳️‍⚧️|drapeau|drapeau blanc|drapeau qui flotte au vent symbole de la communauté transgenre|transgenre
🏴‍☠️|drapeau|drapeau noir|drapeau qui flotte au vent crâne|mort|os|tête|tête de mort
🇦🇨|Flag: Ascension Island
🇦🇩|Flag: Andorra
🇦🇪|Flag: United Arab Emirates
🇦🇫|Flag: Afghanistan
🇦🇬|Flag: Antigua & Barbuda
🇦🇮|Flag: Anguilla
🇦🇱|Flag: Albania
🇦🇲|Flag: Armenia
🇦🇴|Flag: Angola
🇦🇶|Flag: Antarctica
🇦🇷|Flag: Argentina
🇦🇸|Flag: American Samoa
🇦🇹|Flag: Austria
🇦🇺|Flag: Australia
🇦🇼|Flag: Aruba
🇦🇽|Flag: Åland Islands
🇦🇿|Flag: Azerbaijan
🇧🇦|Flag: Bosnia & Herzegovina
🇧🇧|Flag: Barbados
🇧🇩|Flag: Bangladesh
🇧🇪|Flag: Belgium
🇧🇫|Flag: Burkina Faso
🇧🇬|Flag: Bulgaria
🇧🇭|Flag: Bahrain
🇧🇮|Flag: Burundi
🇧🇯|Flag: Benin
🇧🇱|Flag: St. Barthélemy
🇧🇲|Flag: Bermuda
🇧🇳|Flag: Brunei
🇧🇴|Flag: Bolivia
🇧🇶|Flag: Caribbean Netherlands
🇧🇷|Flag: Brazil
🇧🇸|Flag: Bahamas
🇧🇹|Flag: Bhutan
🇧🇻|Flag: Bouvet Island
🇧🇼|Flag: Botswana
🇧🇾|Flag: Belarus
🇧🇿|Flag: Belize
🇨🇦|Flag: Canada
🇨🇨|Flag: Cocos (Keeling) Islands
🇨🇩|Flag: Congo - Kinshasa
🇨🇫|Flag: Central African Republic
🇨🇬|Flag: Congo - Brazzaville
🇨🇭|Flag: Switzerland
🇨🇮|Flag: Côte d’Ivoire
🇨🇰|Flag: Cook Islands
🇨🇱|Flag: Chile
🇨🇲|Flag: Cameroon
🇨🇳|Flag: China
🇨🇴|Flag: Colombia
🇨🇵|Flag: Clipperton Island
🇨🇷|Flag: Costa Rica
🇨🇺|Flag: Cuba
🇨🇻|Flag: Cape Verde
🇨🇼|Flag: Curaçao
🇨🇽|Flag: Christmas Island
🇨🇾|Flag: Cyprus
🇨🇿|Flag: Czechia
🇩🇪|Flag: Germany
🇩🇬|Flag: Diego Garcia
🇩🇯|Flag: Djibouti
🇩🇰|Flag: Denmark
🇩🇲|Flag: Dominica
🇩🇴|Flag: Dominican Republic
🇩🇿|Flag: Algeria
🇪🇦|Flag: Ceuta & Melilla
🇪🇨|Flag: Ecuador
🇪🇪|Flag: Estonia
🇪🇬|Flag: Egypt
🇪🇭|Flag: Western Sahara
🇪🇷|Flag: Eritrea
🇪🇸|Flag: Spain
🇪🇹|Flag: Ethiopia
🇪🇺|Flag: European Union
🇫🇮|Flag: Finland
🇫🇯|Flag: Fiji
🇫🇰|Flag: Falkland Islands
🇫🇲|Flag: Micronesia
🇫🇴|Flag: Faroe Islands
🇫🇷|Flag: France
🇬🇦|Flag: Gabon
🇬🇧|Flag: United Kingdom
🇬🇩|Flag: Grenada
🇬🇪|Flag: Georgia
🇬🇫|Flag: French Guiana
🇬🇬|Flag: Guernsey
🇬🇭|Flag: Ghana
🇬🇮|Flag: Gibraltar
🇬🇱|Flag: Greenland
🇬🇲|Flag: Gambia
🇬🇳|Flag: Guinea
🇬🇵|Flag: Guadeloupe
🇬🇶|Flag: Equatorial Guinea
🇬🇷|Flag: Greece
🇬🇸|Flag: South Georgia & South Sandwich Islands
🇬🇹|Flag: Guatemala
🇬🇺|Flag: Guam
🇬🇼|Flag: Guinea-Bissau
🇬🇾|Flag: Guyana
🇭🇰|Flag: Hong Kong SAR China
🇭🇲|Flag: Heard & McDonald Islands
🇭🇳|Flag: Honduras
🇭🇷|Flag: Croatia
🇭🇹|Flag: Haiti
🇭🇺|Flag: Hungary
🇮🇨|Flag: Canary Islands
🇮🇩|Flag: Indonesia
🇮🇪|Flag: Ireland
🇮🇱|Flag: Israel
🇮🇲|Flag: Isle of Man
🇮🇳|Flag: India
🇮🇴|Flag: British Indian Ocean Territory
🇮🇶|Flag: Iraq
🇮🇷|Flag: Iran
🇮🇸|Flag: Iceland
🇮🇹|Flag: Italy
🇯🇪|Flag: Jersey
🇯🇲|Flag: Jamaica
🇯🇴|Flag: Jordan
🇯🇵|Flag: Japan
🇰🇪|Flag: Kenya
🇰🇬|Flag: Kyrgyzstan
🇰🇭|Flag: Cambodia
🇰🇮|Flag: Kiribati
🇰🇲|Flag: Comoros
🇰🇳|Flag: St. Kitts & Nevis
🇰🇵|Flag: North Korea
🇰🇷|Flag: South Korea
🇰🇼|Flag: Kuwait
🇰🇾|Flag: Cayman Islands
🇰🇿|Flag: Kazakhstan
🇱🇦|Flag: Laos
🇱🇧|Flag: Lebanon
🇱🇨|Flag: St. Lucia
🇱🇮|Flag: Liechtenstein
🇱🇰|Flag: Sri Lanka
🇱🇷|Flag: Liberia
🇱🇸|Flag: Lesotho
🇱🇹|Flag: Lithuania
🇱🇺|Flag: Luxembourg
🇱🇻|Flag: Latvia
🇱🇾|Flag: Libya
🇲🇦|Flag: Morocco
🇲🇨|Flag: Monaco
🇲🇩|Flag: Moldova
🇲🇪|Flag: Montenegro
🇲🇫|Flag: St. Martin
🇲🇬|Flag: Madagascar
🇲🇭|Flag: Marshall Islands
🇲🇰|Flag: North Macedonia
🇲🇱|Flag: Mali
🇲🇲|Flag: Myanmar (Burma)
🇲🇳|Flag: Mongolia
🇲🇴|Flag: Macau Sar China
🇲🇵|Flag: Northern Mariana Islands
🇲🇶|Flag: Martinique
🇲🇷|Flag: Mauritania
🇲🇸|Flag: Montserrat
🇲🇹|Flag: Malta
🇲🇺|Flag: Mauritius
🇲🇻|Flag: Maldives
🇲🇼|Flag: Malawi
🇲🇽|Flag: Mexico
🇲🇾|Flag: Malaysia
🇲🇿|Flag: Mozambique
🇳🇦|Flag: Namibia
🇳🇨|Flag: New Caledonia
🇳🇪|Flag: Niger
🇳🇫|Flag: Norfolk Island
🇳🇬|Flag: Nigeria
🇳🇮|Flag: Nicaragua
🇳🇱|Flag: Netherlands
🇳🇴|Flag: Norway
🇳🇵|Flag: Nepal
🇳🇷|Flag: Nauru
🇳🇺|Flag: Niue
🇳🇿|Flag: New Zealand
🇴🇲|Flag: Oman
🇵🇦|Flag: Panama
🇵🇪|Flag: Peru
🇵🇫|Flag: French Polynesia
🇵🇬|Flag: Papua New Guinea
🇵🇭|Flag: Philippines
🇵🇰|Flag: Pakistan
🇵🇱|Flag: Poland
🇵🇲|Flag: St. Pierre & Miquelon
🇵🇳|Flag: Pitcairn Islands
🇵🇷|Flag: Puerto Rico
🇵🇸|Flag: Palestinian Territories
🇵🇹|Flag: Portugal
🇵🇼|Flag: Palau
🇵🇾|Flag: Paraguay
🇶🇦|Flag: Qatar
🇷🇪|Flag: Réunion
🇷🇴|Flag: Romania
🇷🇸|Flag: Serbia
🇷🇺|Flag: Russia
🇷🇼|Flag: Rwanda
🇸🇦|Flag: Saudi Arabia
🇸🇧|Flag: Solomon Islands
🇸🇨|Flag: Seychelles
🇸🇩|Flag: Sudan
🇸🇪|Flag: Sweden
🇸🇬|Flag: Singapore
🇸🇭|Flag: St. Helena
🇸🇮|Flag: Slovenia
🇸🇯|Flag: Svalbard & Jan Mayen
🇸🇰|Flag: Slovakia
🇸🇱|Flag: Sierra Leone
🇸🇲|Flag: San Marino
🇸🇳|Flag: Senegal
🇸🇴|Flag: Somalia
🇸🇷|Flag: Suriname
🇸🇸|Flag: South Sudan
🇸🇹|Flag: São Tomé & Príncipe
🇸🇻|Flag: El Salvador
🇸🇽|Flag: Sint Maarten
🇸🇾|Flag: Syria
🇸🇿|Flag: Swaziland
🇹🇦|Flag: Tristan Da Cunha
🇹🇨|Flag: Turks & Caicos Islands
🇹🇩|Flag: Chad
🇹🇫|Flag: French Southern Territories
🇹🇬|Flag: Togo
🇹🇭|Flag: Thailand
🇹🇯|Flag: Tajikistan
🇹🇰|Flag: Tokelau
🇹🇱|Flag: Timor-Leste
🇹🇲|Flag: Turkmenistan
🇹🇳|Flag: Tunisia
🇹🇴|Flag: Tonga
🇹🇷|Flag: Turkey
🇹🇹|Flag: Trinidad & Tobago
🇹🇻|Flag: Tuvalu
🇹🇼|Flag: Taiwan
🇹🇿|Flag: Tanzania
🇺🇦|Flag: Ukraine
🇺🇬|Flag: Uganda
🇺🇲|Flag: U.S. Outlying Islands
🇺🇳|Flag: United Nations
🇺🇸|Flag: United States
🇺🇾|Flag: Uruguay
🇺🇿|Flag: Uzbekistan
🇻🇦|Flag: Vatican City
🇻🇨|Flag: St. Vincent & Grenadines
🇻🇪|Flag: Venezuela
🇻🇬|Flag: British Virgin Islands
🇻🇮|Flag: U.S. Virgin Islands
🇻🇳|Flag: Vietnam
🇻🇺|Flag: Vanuatu
🇼🇫|Flag: Wallis & Futuna
🇼🇸|Flag: Samoa
🇽🇰|Flag: Kosovo
🇾🇪|Flag: Yemen
🇾🇹|Flag: Mayotte
🇿🇦|Flag: South Africa
🇿🇲|Flag: Zambia
🇿🇼|Flag: Zimbabwe
''',
  'pt': r'''
😀|engraçado|feliz|lol|rindo|risada|riso|rosto|rosto risonho|sorridente
😃|aberto|boca|feliz|olhos arregalados|risada|risonho|rosto|rosto sorrindo com boca aberta|sorridente|sorrindo|sorriso
😄|aberta|boca|engraçado|feliz|lol|olhos|risada|risonho|rosto|sorridente|sorrindo|sorriso|sorriso com olhos fechados
😁|feliz|olho|olhos sorrindo|rindo|rosto|rosto contente com olhos sorridentes|rosto rindo com olhos sorridentes|sorridente|sorrindo|sorriso|sorriso aberto
😆|gargalhada|gargalhando|hahaha|kkk|olhos fechados|rir|rosto|rosto risonho com olhos semicerrados|sorriso com olhos fechados|sorriso estilo XD
😅|estressada|estressado|nervoso|rindo|rosto|rosto risonho com gota de suor|sorriso com suor frio|sorriso mas com suor frio|suando frio|suor frio
🤣|chão|chorando|choro|engraçada|engraçado|felicidade|feliz|gargalhada|hahaha|kkk|lágrimas|rindo|rir|risada|riso|rolando|rosto
😂|alegria|chorando de rir|engraçada|engraçado|gargalhada|hahaha|kkk|lágrimas|lágrimas de alegria|rosto|rosto chorando de rir|rosto com lágrimas de alegria
🙂|feliz|rosto|rosto levemente sorridente|rosto sorrindo|sorriso|sorriso leve
🙃|de cabeça para baixo|rosto de cabeça para baixo|rosto invertido
😉|flerte|piscada|rosto|rosto com olho piscando|rosto piscando
😊|encabulada|encabulado|envergonhada|envergonhado|feliz|olhos sorrindo|rosado|rosto|rosto e olhos sorrindo|rosto sorridente com olhos sorridentes|rosto sorrindo|ruborizar|satisfeita|satisfeito|sorriso|vergonha
😇|anjinho|anjo|auréola|inocente|rosto|rosto sorridente com auréola|sorriso|sorriso com auréola
🥰|amando|amei|amo você|amor|apaixonada|apaixonado|coração|crush|paixão|romance|rosto|rosto sorridente|rosto sorridente com 3 corações|rosto sorridente com corações|te amo
😍|amor|apaixonado|coração|olhar apaixonado|olhos|olhos de coração|paixão|romance|rosto|rosto sorridente com olhos de coração
🤩|estrela|gargalhando|olhos|rosto|rosto com olhar maravilhado|super animada|super animado|super feliz|superanimada|superanimado|superfeliz
😘|beijo|flerte|jogando beijos|mandando beijo|rosto|rosto jogando beijos|rosto mandando um beijo
😗|beijo|rosto|rosto beijando|rosto com beijo
☺️|corada|corado|relaxado|rosto|rosto sorrindo|rosto sorrindo não preenchido|sorridente|sorriso
😚|beijando|beijando com os olhos fechados|beijinho|mandando beijo|olhos fechados|rosto|rosto beijando com olhos fechados
😙|beijar e sorrir|beijinho|beijos|flerte|mandando beijo|olhos sorrindo|rosto|rosto beijando com olhos sorridentes|rosto beijando com um sorriso|sorriso
😋|apetitoso|comida gostosa|delicioso|gostoso|nham|rosto|rosto com sorriso|rosto saboreando|rosto saboreando comida|saboroso|sorriso
😛|língua para fora|rosto|rosto com língua para fora|rosto mostrando a língua
😜|brincadeira|língua para fora com piscadela|piscadela|piscando e mostrando a língua|provocação|rosto|rosto piscando e com língua para fora
🤪|cara de maluco|doida|doido|excêntrico|grande|louca|louco|olhar de maluco|olho|pequeno|rosto bizarro
😝|eca|horrível|língua para fora|língua para fora com os olhos fechados|olhos fechados|rosto|rosto com olhos semicerrados e língua para fora
🤑|avarenta|avarento|caro|cifrão|dinheiro|dinheiro na boca|ganância|grana|rica|rico|riqueza|rosto|rosto com cifrões
🤗|abraço|carinho|feliz|mãos abraçando|rosto|rosto abraçando|rosto sorrindo
🫣|cativada|cativado|envergonhada|envergonhado|esconder|espiadinha|espiando|espiar|olhar fixamente|rosto com olho espiando|smiley|tímida|tímido|vergonha
🤭|hehe|ops|risadinha|risonho|rosto com a mão sobre a boca|sorriso envergonhado|vergonha
🫢|assustada|assustado|chocada|chocado|descrença|em choque|embaraçar|espanto|nossa|omg|passada|passado|quieta|quieto|rosto com olhos abertos e mão sobre a boca|surpresa|temor
🫡|boa sorte|ensolarado|exército|ok|respeito|rosto saudando|saudação|sim|sim senhor|sim senhora|smiley|tropa|tropas
🤫|faça silêncio|fica quieta|quieta|quieto|rosto fazendo sinal de silêncio|silêncio
🫠|calor|derretendo|derreter|desaparecer|dissolver|envergonhada|envergonhado|haha|líquido|quente|rosto derretendo|sarcasmo|sarcástica|sarcástico|smiley
🤔|curiosa|curioso|dúvida|hmm|ideia|ideias|mão no queixo|pensando|pensativa|pensativo|rosto
🤐|boca fechada|calada|calado|quieta|quieto|rosto|rosto com boca de zíper|segredo|zíper
🤨|cética|ceticismo|cético|confusa|confuso|desconfiada|desconfiado|desconfiança|rosto com sobrancelha levantada
😐|neutro|putz|rosto|rosto sem emoção|sem comentários|sem emoção|sem reação
🫤|cético|confusa|confusão|confuso|desapontado|dúvida|frustração|frustrada|frustrado|indiferença|inseguro|meh|rosto com boca diagonal|smiley|tanto faz
😑|aff|inespressiva|inespressivo|nada a dizer|rosto|rosto inexpressivo|sem comentários|sem expressão|tanto faz
😶|calada|calado|quieto|rosto|rosto sem boca|sem boca|sem comentários|sem palavras
🫥|deprimida|deprimido|desaparecer|esconder|escondida|escondido|indiferença|introvertido|invisível|meh|rosto com linha pontilhada|smiley|tanto faz
😏|flerte|rosto|rosto com sorriso maroto|sorriso maldoso|sorriso malicioso|sorriso maroto|suspeito
😒|aff|blasé|nada engraçado|não achou graça|não está feliz|rosto|rosto aborrecido|rosto de que não achou graça|rosto de quem não achou graça
🙄|olhando para cima|olhos|revirando os olhos|rolando os olhos|rosto|rosto com olhos revirados|tanto faz|virando os olhos
😬|careta|fazendo careta|rosto|rosto expressando desagrado|rosto fazendo careta|sem graça
🤥|mentindo|mentira|mentiroso|nariz crescendo|pinocchio|pinóquio|rosto de mentiroso
😌|alívio|em paz|rosto|rosto aliviado|zen
😔|abatido|chateado|deprimido|desanimado|pensativo|pra baixo|rosto
🥹|admiração|chorar|com raiva|emoção|gratidão|iti malia|lágrimas de alegria|orgulho|orgulhoso|por favor|resistir|rosto segurando as lágrimas|smiley|triste|tristeza
😪|cara de sono|rosto|rosto com sono|rosto sonolento
🤤|babando|babar|rosto|salivando
😴|boa noite|cama|cansada|cansado|cochilo|dormindo|dormir|rosto|soneca|sono|zzz
😷|doente|gripado|máscara|máscara médica|resfriado|rosto|rosto com máscara|rosto com máscara médica
🤒|de cama|doente|febre|febril|rosto|rosto com termômetro|termômetro
🤕|acidentado|doente|ferimento|machucado|rosto|rosto com atadura na cabeça|rosto com curativos
🤢|doente|enjoado|enjoo|náusea|rosto nauseado|vômito
🤮|doente|nojenta|nojento|nojo|rosto vomitando|vomitando|vômito|vomito, rosto vomitando, vomitar, passando mal
🤧|de cama|doente|espirrando|espirro|gripado|resfriado|rosto espirrando
🥵|calor|febre|febril|insolação|língua de fora|ofegante|quente|rosto|rosto fervendo de calor|rosto vermelho|suando|suor
🥶|abaixo de zero|congelando|congelei|frio|gélido|glacial|rosto|rosto azul|rosto azul de frio|rosto gelado|roxo de frio
🥴|alcoolizado|bêbada|bêbado|boca ondulada|embriagada|embriagado|intoxicado|olhos tortos|rosto|tonta|tonto
😵|rosto|rosto atordoado|tontura
😵‍💫|caramba|confusa|confuso|desnorteada|desnorteado|eita|espirais|hipnotizado|problema|putz|rosto com olhos em espiral|tonta|tonto|tontura|uau
🤯|cabeça explodindo|cabeça explodindo, em choque, perplexo|chocado
🤠|cara|cara de cauboi|cauboi|caubói|cowboy|rosto|rosto com chapéu de caubói|sertanejo|vaqueiro
🥳|animação|aniversário|apito|chapéu|comemoração|comemorar|feliz aniversário|festa|língua de sogra|parabéns|rosto|rosto festivo|viva
😎|muito sol|na boa|óculos escuros|rosto|rosto sorridente com óculos escuros|sol|sorrindo|sorrindo de óculos escuros|sorriso de óculos|to legal
🤓|cdf|esperto|estudioso|inteligência|inteligente|nerd|óculos|óculos de grau|rosto de nerd|sabe tudo|sabe-tudo
🧐|conservador|rosto com monóculo
😕|confuso|indeciso|não entendi|não tenho certeza|rosto
😟|decepcionado|preocupado|rosto
🙁|rosto|rosto meio triste|triste|tristeza|tristinho
☹️|decepção|decepcionado|descontente|insatisfeito|rosto|rosto de desaprovação|triste
😮|boca|boca aberta|boquiaberto|empatia|pasmo|rosto|rosto com boca aberta
😯|espantado|rosto|surpreso|uau
😲|chocado|estupefato|rosto|rosto espantado|totalmente chocado
😳|atordoado|deslumbrado|horrorizado|impressionado|rosto|ruborizado|vergonha
🥺|implorando|olhar de cachorrinho|olhos grandes|perdão|por favor|por que não|pq não|rosto|triste
😦|aberta|assustado|boca|decepcionado|inesperado|rosto assustado|rosto franzido com boca aberta|uau
😧|angustiado|rosto|sofrendo
😨|ansiedade|assustado|com medo|medo|preocupado|rosto|rosto amedrontado
😰|boca aberta|nervoso|rosto|rosto ansioso com gota de suor|rosto azul com suor frio|suando frio|suor frio
😥|aliviado|decepcionado|não|rosto|triste|ufa
😢|chorando|choro|lágrimas|rosto|triste
😭|chorando|chorando alto|chorar|infeliz|lágrimas|rosto|rosto chorando aos berros|triste
😱|assustada|assustado|gritando|grito|medo|rosto|susto|temeroso
😖|bravo|frustrado|indignado|perplexo|rosto
😣|concentração|concentrado|dor de cabeça|foco|perseverança|perseverante|rosto
😞|decepção|desapontado|desapontamento|rosto|rosto decepcionado|triste
😓|rosto|rosto cabisbaixo com gota de suor|rosto com suor frio|suando frio|suor frio
😩|aborrecido|cansado|cansei|exausto|infeliz|perdi|rosto|rosto desolado
😫|cansado|desesperado|exausto|rosto
😤|brava|bravo|furiosa|furioso|irritada|irritado|rosto|rosto soltando vapor pelo nariz|soltando fumaça|triunfo|vitória
😡|bravo|furioso|irado|rosto|vermelho|zangado
😠|irado|rosto|zangado
🤬|rosto com símbolos na boca|xingando|xingando, falando mal, censurado, mal educado
😈|cara|chifres|diabinho|diabo|malícia|rosto|roxa|sorridente|sorriso
👿|demônio|diabinho|diabo|pequeno demônio|rosto|rosto bravo|rosto zangado com chifres
💀|caveira|conto de fadas|corpo|morte|rosto
☠️|caveira|caveira e ossos|caveira e ossos cruzados|morte|ossos cruzados|pirata
💩|cocô|estrume|excremento|fezes|pilha|pilha de cocô
🤡|cara|cara de palhaço|circo|engraçado|palhaço|rosto|rosto de palhaço
👹|assustador|conto de fadas|demoníaco|malvado|máscara|monstro|ogro|ogro japonês|oni|rosto
👺|bravo|conto de fadas|duende japonês|goblin|japonês|máscara|monstro|raiva|rosto|tengu|zangado
👻|assombração|assombrado|buu|conto de fadas|fantasma|halloween|rosto
👽|alienígena|extraterrestre|OVNI|rosto
👾|alien|E.T.|extraterrestre|game|invasores alienígenas|monstro|monstro alienígena|OVNI|pixelado|rosto
🤖|monstro|robô|robotizado|rosto
🎃|abóbora|comemoração|dia das bruxas|halloween|jack|lanterna
😺|aberta|animal|boca|feliz|gato|rosto|rosto de gato|rosto de gato sorrindo|rosto de gato sorrindo com boca aberta|sorriso
😸|gato|olho|rindo|rosto|rosto de gato|rosto de gato com olhos sorrindo e riso|rosto de gato rindo|rosto de gato sorrindo com olhos sorridentes|sorridente|sorriso
😹|alegria|chorando|chorando de rir|choro|choro de felicidade|engraçado|felicidade|feliz|gato|gato chorando de rir|lágrimas|lágrimas de felicidade|rindo|risos|rosto|rosto de gato|rosto de gato com lágrimas de alegria
😻|aberta|amor|apaixonado|boca|coração|gato|olho|rosto|rosto de fato com olhos no formato de coração|rosto de gato sorridente com olhos de coração|sorriso
😼|gato|irônico|rosto|sorriso
😽|beijando|beijo|fechados|gato|olho fechado|olhos|rosto|rosto de gato mandando um beijo
🙀|gato|meu deus!|muito surpreso|oh!|rosto|rosto de gato desolado|surpresa
😿|chorando|chorar|choro|gato|lágrima|rosto|rosto de gato|rosto de gato chorando|triste
😾|bravo|fazendo bico|gato|rosto|rosto de gato|rosto de gato fazendo bico|rosto de gato mal-humorado
🫶|<3|amei|amo você|amor|coração|mão|mãos|mãos de coração|te amo
👋|aceno|até mais|está aí?|flw|mão|mão acenando|oi|olá|taí?|tchau
🤚|dorso da mão levantado|levantada|mão|palma|palma da mão levantada|para tudo|pare
🖐️|5|cinco dedos|dedos|mão|mão aberta|mão aberta com os dedos separados|mão aberta indicando cinco|palma da mão|pare
✋|5|cinco|high five|mão|mão erguida|mão levantada|papel|pare
🖖|dedos|jornada nas estrelas|mão|saudação|saudação star trek|saudação vulcana|spock|star trek|startrek
👌|beliscar|certo|concordo|mão|ok|ótimo|rude|sinal|sinalizando
🤌|beliscado|como|dedos|dedos comprimidos|gesto de mão|hã|interrogação|itália|mão|mão de coxinha|mão italiana|o quê|sarcástico
🤏|beliscar|mão beliscando|pequena quantidade|pequeno|pouco|pouquinho
🫳|cair|derrubar|descartar|mão|mão com a palma para baixo|pegar|segurar|soltar|xô
🫴|acenar|levantar|mão|mão com a palma para cima|oferecer|pegar|segurar|venha
✌️|mão|mão com sinal de vitória|mão em V de vitória|paz|sim!|vitória
🫰|<3|amor|army|caro|coração|dinheiro|estalar|k-pop|kpop|mão|mão com dedo indicador e polegar cruzados
🤞|boa sorte|cruzados|dedos|mão|sorte|torcendo
🤟|gesto de "te amo"|mão|te amo|te amo, gesto de amor
🤘|chifres|dedos|mão|metal|rock|saudação do rock
🤙|legal|ligar|mão|me liga|sinal "me liga"
👈|costas da mão|dedo|dedo apontado para esquerda|dedo indicador|dedo para esquerda|dorso da mão com dedo indicador apontando para a esquerda
👉|costas da mão|dedo|dedo apontado para direita|dedo indicador|dedo para direita|dorso da mão com dedo indicador apontando para a direita
👆|costas da mão|dedo|dedo apontado para cima|dedo indicador|dedo para cima|dorso da mão com dedo indicador apontando para cima|mão
🖕|dedo|dedo do meio|gesto ofensivo|mão
👇|abaixo|costas da mão|dedo|dedo apontado para baixo|dedo indicador|dedo para baixo|dorso da mão com dedo indicador apontando para baixo|embaixo
☝️|dedo|dedo apontando para cima|eu|indicador|indicador apontando para cima|mão
👍|beleza|concordo|dedão|dedão para cima|jóia|mão|ok|para cima|polegar|polegar para cima|sim|sinal|valeu
👎|dedão|dedão para baixo|desaprovação|desaprovado|mão|não|não gostei|para baixo|polegar para baixo|ruim|sinal
✊|pedra|punho|punho erguido|punho levantado|solidariedade
👊|mão|punho|punho fechado|soco
🤛|esquerdo|mão fechada|punho|soco
🤜|direito|punho|soco
🫲|apertar|aperto de mão|esquerda|mão|mão para a esquerda|para a esquerda|pegar|segurar
🫱|apertar|aperto de mão|direita|mão|mão para a direita|para a direita|pegar|segurar
👏|aplauso|bom trabalho|mãos|mãos aplaudindo|palmas|parabéns|sinal
🙌|ambas as mãos|comemoração|levantando ambas as mãos para comemorar|mãos para cima|viva
👐|abertas|mão|mãos abertas|sinal|sinal de mãos abertas
🤲|oração|palmas juntas, oração, mãos armadas, oração, devoção|palmas unidas para cima
🤝|aperto|aperto de mãos|combinado|cumprimento|mãos
🙏|gesto|mão|mãos juntas|reza|rezando|rezar
🫵|aí|apontar|cutucar|dedo|indicador|indicador apontando para o visualizador|mão|tu|você
✍️|caneta|escrevendo|escrevendo à mão|mão
💅|cosméticos|esmalte|esmalte de unha|manicure|mão|unhas
🤳|camera|câmera|celular|foto|selfie|smartphone
💪|academia|bíceps|contraído|engraçado|forte|musculação|músculo
🦵|chute|joelho|membro|pé|perna|perna dobrada
🦶|calcanhar|chutar|chute|pé|pisão|pisar|tornozelo
👂|corpo|escutar|orelha|ouvido
👃|cheirar|cheiro|corpo|nariz|odor|rosto
🧠|cérebro|cérebro, inteligência, inteligente|inteligente
🦴|cachorro|esqueleto|osso
👀|olhando|olho|olhos|rosto|tô de olho
👁️|olho|parte do corpo|rosto
💋|beijo|lábios|marca de beijo|romance
👄|batom|beijo|boca|corpo|lábios|rosto
🫦|ansioso|batom|beijo|desconfortável|flertando|lábios|medo|mordendo o lábio|mordida|nervosa|nervoso|preocupação|preocupada|preocupado|sedução|sexy|vontade
🦷|branco|dente|dentista
👅|corpo|língua|rosto
👶|bebê|bebezinho|grávida|neném|pessoas|recém-nascido
🧒|criança|criança, neutro em termos de gênero, jovem, criança
👦|garoto|guri|jovem|loiro|menino|pessoas|piá
👧|filha|garota|menina|menininha|neta|pessoas
🧑|adulta|adulto|pessoa
👨|adulto|amigo|homem|irmão|marido|namorado
🧔|barba|barbudo|homem|pessoa
👱|cabelo|loiro|louro|pessoa|pessoa loira|pessoa loura|pessoa
👨‍🦰|adulto|amigo|homem|irmão|marido|namorado cabelo vermelho|ruivo
👨‍🦱|adulto|amigo|homem|irmão|marido|namorado afro|cabelo|cacheado|encaracolado
👨‍🦳|adulto|amigo|homem|irmão|marido|namorado branco|cabelo|grisalho|velho
👨‍🦲|adulto|amigo|homem|irmão|marido|namorado careca|nenhum cabelo|quimioterapia|raspado|sem cabelo
👩|adulta|garota|guria|loira|menina|mina|mulher
👱‍♀️|cabelo|loiro|louro|pessoa|pessoa loira|pessoa loura|pessoa feminino|mulher|símbolo de feminino
👩‍🦰|adulta|garota|guria|loira|menina|mina|mulher cabelo vermelho|ruivo
👩‍🦱|adulta|garota|guria|loira|menina|mina|mulher afro|cabelo|cacheado|encaracolado
👩‍🦳|adulta|garota|guria|loira|menina|mina|mulher branco|cabelo|grisalho|velho
👩‍🦲|adulta|garota|guria|loira|menina|mina|mulher careca|nenhum cabelo|quimioterapia|raspado|sem cabelo
🧓|adulto|adulto mais velho, neutro em termos de gênero|idoso
👴|adulto|avô|careca|homem|idoso|pessoas|vovô
👵|adulta|idosa|mulher|pessoas|velhinha|vovó|vovozinha
🙍‍♂️|brava|bravo|chateada|chateado|franzindo a sobrancelha|franzindo a testa|gesto|pessoa|pessoa franzindo a sobrancelha|triste homem|masculino|símbolo de masculino
🙍‍♀️|brava|bravo|chateada|chateado|franzindo a sobrancelha|franzindo a testa|gesto|pessoa|pessoa franzindo a sobrancelha|triste feminino|mulher|símbolo de feminino
🙎‍♂️|beicinho|beiço|careta|chateada|chateado|emburrada|emburrado|fazendo bico|gesto|pessoa|pessoa fazendo bico homem|masculino|símbolo de masculino
🙎‍♀️|beicinho|beiço|careta|chateada|chateado|emburrada|emburrado|fazendo bico|gesto|pessoa|pessoa fazendo bico feminino|mulher|símbolo de feminino
🙅‍♂️|de jeito nenhum|gesto|mão|não|não pode|pessoa fazendo gesto de “não”|pessoa fazendo gesto de não|proibido|sem chance homem|masculino|símbolo de masculino
🙅‍♀️|de jeito nenhum|gesto|mão|não|não pode|pessoa fazendo gesto de “não”|pessoa fazendo gesto de não|proibido|sem chance feminino|mulher|símbolo de feminino
🙆‍♂️|exercício|gesto|gesto para OK|mão|mãos para cima|OK|pessoa|pessoa fazendo gesto de “OK” homem|masculino|símbolo de masculino
🙆‍♀️|exercício|gesto|gesto para OK|mão|mãos para cima|OK|pessoa|pessoa fazendo gesto de “OK” feminino|mulher|símbolo de feminino
💁‍♂️|ajuda|diva|divo|fala sério|fofoca|informações|jogada de cabelo|mão|pessoa|pessoa com a mão virada para cima|pessoa com a palma virada para cima|sarcasmo homem|masculino|símbolo de masculino
💁‍♀️|ajuda|diva|divo|fala sério|fofoca|informações|jogada de cabelo|mão|pessoa|pessoa com a mão virada para cima|pessoa com a palma virada para cima|sarcasmo feminino|mulher|símbolo de feminino
🙋‍♂️|dúvida|eu|eu sei|feliz|gesto|levantando a mão|levantar a mão|mão|pessoa|pessoa levantando a mão homem|masculino|símbolo de masculino
🙋‍♀️|dúvida|eu|eu sei|feliz|gesto|levantando a mão|levantar a mão|mão|pessoa|pessoa levantando a mão feminino|mulher|símbolo de feminino
🙇‍♂️|arrependimento|desculpa|desculpe|gesto|meditação|perdão|pessoa|pessoa fazendo reverência|reverência|reverência respeitosa homem|masculino|símbolo de masculino
🙇‍♀️|arrependimento|desculpa|desculpe|gesto|meditação|perdão|pessoa|pessoa fazendo reverência|reverência|reverência respeitosa feminino|mulher|símbolo de feminino
🤦‍♂️|como assim|decepção|decepcionada|decepcionado|desapontamento|descrença|inacreditável|meu deus|não acredito|não é possível|pessoa|pessoa dececionada homem|masculino|símbolo de masculino
🤦‍♀️|como assim|decepção|decepcionada|decepcionado|desapontamento|descrença|inacreditável|meu deus|não acredito|não é possível|pessoa|pessoa dececionada feminino|mulher|símbolo de feminino
🤷‍♂️|dar de ombros|dúvida|ignorância|indiferença|não sei|ombros|pessoa|pessoa dando de ombros|quem sabe|sei lá|tanto faz homem|masculino|símbolo de masculino
🤷‍♀️|dar de ombros|dúvida|ignorância|indiferença|não sei|ombros|pessoa|pessoa dando de ombros|quem sabe|sei lá|tanto faz feminino|mulher|símbolo de feminino
👨‍⚕️|adulto|amigo|homem|irmão|marido|namorado bastão de asclépio|esculápio|medicina|símbolo|símbolo da medicina
👩‍⚕️|adulta|garota|guria|loira|menina|mina|mulher bastão de asclépio|esculápio|medicina|símbolo|símbolo da medicina
👨‍🎓|aluno|colando grau|estudante|formando|graduação|homem
👩‍🎓|aluna|estudante|formanda|mulher
👨‍🏫|educador|homem|instrutor|mestre|professor
👩‍🏫|instrutora|mestra|mulher|professora
👨‍⚖️|adulto|amigo|homem|irmão|marido|namorado balança|ferramenta|justiça|libra|peso|zodíaco
👩‍⚖️|adulta|garota|guria|loira|menina|mina|mulher balança|ferramenta|justiça|libra|peso|zodíaco
👨‍🌾|agricultor|fazendeiro|homem|jardineiro
👩‍🌾|agricultora|fazendeira|jardineira|mulher
👨‍🍳|chef|cozinheiro|homem|restaurante
👩‍🍳|chef|cozinheira|mulher
👨‍🔧|eletricista|encanador|homem|mecânico|prestador de serviços
👩‍🔧|eletricista|encanadora|mecânica|mulher|prestadora de serviços
👨‍🏭|fábrica|homem|indústria|metalúrgico|operário|trabalhador
👩‍🏭|fábrica|indústria|mulher|operária|trabalhadora
👨‍💼|arquiteto|colarinho branco|empresário|escritório|funcionário de escritório|gerente|homem
👩‍💼|arquiteta|colarinho branco|empresária|escritório|funcionára de escritório|funcionária de escritório|gerente|mulher
👨‍🔬|biólogo|cientista homem|físico|homem|professor|químico
👩‍🔬|bióloga|cientista|física|mulher|professora|química
👨‍💻|codificador|computador|criador|desenvolvedor|homem|inventor|programador|software|tecnólogo
👩‍💻|codificadora|computador|criadora|desenvolvedora|inventora|mulher|programadora|software|tecnóloga
👨‍🎤|artista|ator|cantor|homem|pop|rock
👩‍🎤|artista|atriz|cantora|mulher|pop|rock
👨‍🎨|artista|artista plástico|homem|pintor de quadros|pintura
👩‍🎨|artista|artista plástica|mulher|pintura
👨‍✈️|adulto|amigo|homem|irmão|marido|namorado aéreo|avião|veículo|viajar|voar|voo
👩‍✈️|adulta|garota|guria|loira|menina|mina|mulher aéreo|avião|veículo|viajar|voar|voo
👨‍🚀|astronauta homem|espaço|foguete|homem
👩‍🚀|astronauta|espaço|foguete|mulher
👨‍🚒|bombeiro|caminhão do corpo de bombeiros|corpo de bombeiros|fogo|homem|incêndio
👩‍🚒|bombeira|bombeiro mulher|caminhão do corpo de bombeiros|corpo de bombeiros|fogo|incêndio|mulher
👮‍♂️|autoridade|multar|pessoa|polícia|policial|prender homem|masculino|símbolo de masculino
👮‍♀️|autoridade|multar|pessoa|polícia|policial|prender feminino|mulher|símbolo de feminino
🕵️‍♂️|detetive|espião|investigador|rosto|rosto com lupa homem|masculino|símbolo de masculino
🕵️‍♀️|detetive|espião|investigador|rosto|rosto com lupa feminino|mulher|símbolo de feminino
💂‍♂️|guarda|pessoas|segurança homem|masculino|símbolo de masculino
💂‍♀️|guarda|pessoas|segurança feminino|mulher|símbolo de feminino
👷‍♂️|capacete|chapéu|construção|construção civil|construir|pessoa|trabalhador|trabalhador de construção civil homem|masculino|símbolo de masculino
👷‍♀️|capacete|chapéu|construção|construção civil|construir|pessoa|trabalhador|trabalhador de construção civil feminino|mulher|símbolo de feminino
🤴|príncipe|Realeza|rei
👸|conto de fadas|coroa|fantasia|loira|menina|mulher|pessoas|princesa|rainha
👳‍♂️|pessoa|pessoa com turbante|turbante homem|masculino|símbolo de masculino
👳‍♀️|pessoa|pessoa com turbante|turbante feminino|mulher|símbolo de feminino
👲|chapéu chinês|gua pi mao|guapimao|homem com gua pi mao|homem de boné|pessoas
🧕|hijab|lenço|mulher com lenço de cabeça, hijab, mantilha, tichel, bandana, lenço de cabeça|mulher com véu
🤵|festa|gala|homem|homem de smoking|noivo|pessoa de smoking|smoking
👰|casamento|noiva|noiva com véu|pessoa com véu|pessoas|véu|véu de noiva
🤰|estou grávida|grávida|gravidez|mulher
🤱|amamentação|amamentando|amamentando, amamentação, leite materno|bebê|neném
👼|anjo|bebê|conto de fadas|rosto
🎅|comemoração|festas|natal|noel|papai
🤶|comemoração|mamãe noel|Mamãe Noel|natal|Natal|noel|Noel
🦸‍♂️|bem|boa|bom|herói|heroína|super-herói|super-homem|superman|superpoder homem|masculino|símbolo de masculino
🦸‍♀️|bem|boa|bom|herói|heroína|super-herói|super-homem|superman|superpoder feminino|mulher|símbolo de feminino
🦹‍♂️|bandido|criminoso|mal|malvado|mau|superpoder|supervilão|vilão homem|masculino|símbolo de masculino
🦹‍♀️|bandido|criminoso|mal|malvado|mau|superpoder|supervilão|vilão feminino|mulher|símbolo de feminino
🧙‍♂️|bruxa|fantasia|feiticeira|feiticeiro|feitiço|maga|magia|mago|mago, feiticeiro, bruxo, feiticeiro, feitiço, magia|rpg homem|masculino|símbolo de masculino
🧙‍♀️|bruxa|fantasia|feiticeira|feiticeiro|feitiço|maga|magia|mago|mago, feiticeiro, bruxo, feiticeiro, feitiço, magia|rpg feminino|mulher|símbolo de feminino
🧚‍♂️|asas|conto de fadas|fada|fantasia|ser encantado homem|masculino|símbolo de masculino
🧚‍♀️|asas|conto de fadas|fada|fantasia|ser encantado feminino|mulher|símbolo de feminino
🧛‍♂️|assustador|dia das bruxas|drácula|Drácula|fantasia|halloween|monstro|sangue|terror|vampiro homem|masculino|símbolo de masculino
🧛‍♀️|assustador|dia das bruxas|drácula|Drácula|fantasia|halloween|monstro|sangue|terror|vampiro feminino|mulher|símbolo de feminino
🧜‍♂️|canto|cauda|contos|criatura|fada|fundo|mar|oceano|ser encantado|sereia|sirene|tridente homem|masculino|símbolo de masculino
🧜‍♀️|canto|cauda|contos|criatura|fada|fundo|mar|oceano|ser encantado|sereia|sirene|tridente feminino|mulher|símbolo de feminino
🧝‍♂️|elfo|Elfo, duende, légolas|fantasia|magia|mágico|místico|rpg|ser encantado homem|masculino|símbolo de masculino
🧝‍♀️|elfo|Elfo, duende, légolas|fantasia|magia|mágico|místico|rpg|ser encantado feminino|mulher|símbolo de feminino
🧞‍♂️|desejos|fantasia|gênio|gênio da lâmpada|lâmpada mágica|místico homem|masculino|símbolo de masculino
🧞‍♀️|desejos|fantasia|gênio|gênio da lâmpada|lâmpada mágica|místico feminino|mulher|símbolo de feminino
🧟‍♂️|apocalipse|assustador|cazumbi|dia das bruxas|halloween|morto-vivo|terror|zumbi|zumbi, morto-vivo, halloween, dia das bruxas, assustador homem|masculino|símbolo de masculino
🧟‍♀️|apocalipse|assustador|cazumbi|dia das bruxas|halloween|morto-vivo|terror|zumbi|zumbi, morto-vivo, halloween, dia das bruxas, assustador feminino|mulher|símbolo de feminino
💆‍♂️|dor de cabeça|massagem|massagem facial|pele|pessoa recebendo massagem facial|relaxar|rosto|spa|tensão homem|masculino|símbolo de masculino
💆‍♀️|dor de cabeça|massagem|massagem facial|pele|pessoa recebendo massagem facial|relaxar|rosto|spa|tensão feminino|mulher|símbolo de feminino
💇‍♂️|beleza|cortando o cabelo|corte de cabelo|pessoa|pessoa cortando o cabelo|salão|salão de beleza homem|masculino|símbolo de masculino
💇‍♀️|beleza|cortando o cabelo|corte de cabelo|pessoa|pessoa cortando o cabelo|salão|salão de beleza feminino|mulher|símbolo de feminino
🚶‍♂️|andar|caminhada|caminhar|passo|pedestre|perambulando|pessoa andando|pessoa caminhando homem|masculino|símbolo de masculino
🚶‍♀️|andar|caminhada|caminhar|passo|pedestre|perambulando|pessoa andando|pessoa caminhando feminino|mulher|símbolo de feminino
🏃‍♂️|correr|corrida|esporte|maratona|maratonista|pessoa correndo|pressa homem|masculino|símbolo de masculino
🏃‍♀️|correr|corrida|esporte|maratona|maratonista|pessoa correndo|pressa feminino|mulher|símbolo de feminino
🕺|dançando|homem
💃|bailarina|dança|dançando|flamenco|mulher|pessoas|salsa|tango|vamos dançar
🕴️|homem|homem de terno|homem de terno levitando|terno
👯‍♂️|amigas|coelho|dançar|dançarinas|festa|gêmeas|melhores|orelhas homem|masculino|símbolo de masculino
👯‍♀️|amigas|coelho|dançar|dançarinas|festa|gêmeas|melhores|orelhas feminino|mulher|símbolo de feminino
🧖‍♂️|mulher na sauna|mulher na sauna úmida, sauna úmida, sauna, banho|pessoa na sauna|relaxar|sauna|spa homem|masculino|símbolo de masculino
🧖‍♀️|mulher na sauna|mulher na sauna úmida, sauna úmida, sauna, banho|pessoa na sauna|relaxar|sauna|spa feminino|mulher|símbolo de feminino
🧘|ioga|meditação|pernas cruzadas|pessoa em posição de lótus, meditação, yoga, serenidade, pernas cruzadas, pernas cruzadas, relaxar|pessoa na posição de lótus|relaxar|yoga|zen
👭|amigas|casal|duas mulheres|duas mulheres de mão dadas|duas mulheres de mãos dadas|garotas|gurias|irmãs|mãos dadas|moças|mulher|pessoas
👫|amigos|casal|homem|homem e mulher|homem e mulher de mãos dadas|mãos dadas|mulher|pessoas
👬|amigos|casal|dois homens|dois homens de mãos dadas|gêmeos|homem|homens|irmãos|mãos dadas|namorados|pessoas
💏|amor|beijar|beijo|casal|coração|pessoas|romance
👨‍❤️‍💋‍👨|adulto|amigo|homem|irmão|marido|namorado amor|coração|coração vermelho|s2 beijo|lábios|marca de beijo|romance adulto|amigo|homem|irmão|marido|namorado
👩‍❤️‍💋‍👩|adulta|garota|guria|loira|menina|mina|mulher amor|coração|coração vermelho|s2 beijo|lábios|marca de beijo|romance adulta|garota|guria|loira|menina|mina|mulher
💑|casal|casal apaixonado|casal com um coração|coração|pessoas|romance
👨‍❤️‍👨|adulto|amigo|homem|irmão|marido|namorado amor|coração|coração vermelho|s2 adulto|amigo|homem|irmão|marido|namorado
👩‍❤️‍👩|adulta|garota|guria|loira|menina|mina|mulher amor|coração|coração vermelho|s2 adulta|garota|guria|loira|menina|mina|mulher
👪|família|filho|mãe|pai|pessoas|um filho
👨‍👩‍👦|adulto|amigo|homem|irmão|marido|namorado adulta|garota|guria|loira|menina|mina|mulher garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👩‍👧|adulto|amigo|homem|irmão|marido|namorado adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas
👨‍👩‍👧‍👦|adulto|amigo|homem|irmão|marido|namorado adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👩‍👦‍👦|adulto|amigo|homem|irmão|marido|namorado adulta|garota|guria|loira|menina|mina|mulher garoto|guri|jovem|loiro|menino|pessoas|piá garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👩‍👧‍👧|adulto|amigo|homem|irmão|marido|namorado adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas filha|garota|menina|menininha|neta|pessoas
👨‍👨‍👦|adulto|amigo|homem|irmão|marido|namorado adulto|amigo|homem|irmão|marido|namorado garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👨‍👧|adulto|amigo|homem|irmão|marido|namorado adulto|amigo|homem|irmão|marido|namorado filha|garota|menina|menininha|neta|pessoas
👨‍👨‍👧‍👦|adulto|amigo|homem|irmão|marido|namorado adulto|amigo|homem|irmão|marido|namorado filha|garota|menina|menininha|neta|pessoas garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👨‍👦‍👦|adulto|amigo|homem|irmão|marido|namorado adulto|amigo|homem|irmão|marido|namorado garoto|guri|jovem|loiro|menino|pessoas|piá garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👨‍👧‍👧|adulto|amigo|homem|irmão|marido|namorado adulto|amigo|homem|irmão|marido|namorado filha|garota|menina|menininha|neta|pessoas filha|garota|menina|menininha|neta|pessoas
👩‍👩‍👦|adulta|garota|guria|loira|menina|mina|mulher adulta|garota|guria|loira|menina|mina|mulher garoto|guri|jovem|loiro|menino|pessoas|piá
👩‍👩‍👧|adulta|garota|guria|loira|menina|mina|mulher adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas
👩‍👩‍👧‍👦|adulta|garota|guria|loira|menina|mina|mulher adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas garoto|guri|jovem|loiro|menino|pessoas|piá
👩‍👩‍👦‍👦|adulta|garota|guria|loira|menina|mina|mulher adulta|garota|guria|loira|menina|mina|mulher garoto|guri|jovem|loiro|menino|pessoas|piá garoto|guri|jovem|loiro|menino|pessoas|piá
👩‍👩‍👧‍👧|adulta|garota|guria|loira|menina|mina|mulher adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas filha|garota|menina|menininha|neta|pessoas
👨‍👦|adulto|amigo|homem|irmão|marido|namorado garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👦‍👦|adulto|amigo|homem|irmão|marido|namorado garoto|guri|jovem|loiro|menino|pessoas|piá garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👧|adulto|amigo|homem|irmão|marido|namorado filha|garota|menina|menininha|neta|pessoas
👨‍👧‍👦|adulto|amigo|homem|irmão|marido|namorado filha|garota|menina|menininha|neta|pessoas garoto|guri|jovem|loiro|menino|pessoas|piá
👨‍👧‍👧|adulto|amigo|homem|irmão|marido|namorado filha|garota|menina|menininha|neta|pessoas filha|garota|menina|menininha|neta|pessoas
👩‍👦|adulta|garota|guria|loira|menina|mina|mulher garoto|guri|jovem|loiro|menino|pessoas|piá
👩‍👦‍👦|adulta|garota|guria|loira|menina|mina|mulher garoto|guri|jovem|loiro|menino|pessoas|piá garoto|guri|jovem|loiro|menino|pessoas|piá
👩‍👧|adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas
👩‍👧‍👦|adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas garoto|guri|jovem|loiro|menino|pessoas|piá
👩‍👧‍👧|adulta|garota|guria|loira|menina|mina|mulher filha|garota|menina|menininha|neta|pessoas filha|garota|menina|menininha|neta|pessoas
🗣️|berro|cabeça|falando|grito|silhueta|voz
👤|busto|mistério|pessoas|silhueta|sombra
👥|amigos|busto|dupla|pessoas|silhueta|silhueta de bustos
🫂|abraçando|abraço|adeus|amizade|amor|carinho|conforto|obrigado|olá|pessoas se abraçando
👣|corpo|gravura|pé|pegadas|pés descalços|rastro
🧳|bagagem|mala|rodinhas|viagem
🌂|chuva|chuvoso|guarda-chuva|guarda-chuva fechado
☂️|acessório|chuva|clima|guarda-chuva|sombrinha aberta
🧵|agulha|barbante|carretel|costura|linha
🧶|bola|crochê|lã|novelo|tricô|tricotar
👓|acessório|óculos
🕶️|óculos|óculos de sol|óculos escuros
🥽|mergulho|natação|óculos|óculos de proteção|proteção para os olhos|solda|soldagem
🥼|cientista|dr.|experiência|experimento|jaleco|médico|roupa
👔|acessório|gravata|roupa
👕|camisa|camiseta|roupa
👖|calça|jeans|roupa
🧣|cachecol|cachecol, pescoço, frio,|inverno|pescoço
🧤|inverno|luva|mão
🧥|blusa|casaco|casaco, jaqueta, frio, agasalho|jaqueta
🧦|meia|meião
👗|peça única|roupa|vestido
👘|quimono|roupa|vestir
👙|biquíni|piscina|praia|roupa|traje de banho
👚|blusa rosa|camiseta|roupas|roupas femininas
👛|acessório|bolsa rosa|bolsinha|moedas|niqueleira|porta moeda
👜|acessório|bolsa|bolsa de mão|fashion
👝|acessório|bolsa|bolsa pequena|carteira|fashion
🎒|bolsa escolar|escola|mochila|mochila escolar|viagem|viajar
👞|acessório|sapato masculino|sapatos
👟|acessório|correr|corrida|esportivo|sapato|tênis
🥾|acampamento|acampar|bota|bota de trekking|caminhada|marrom|mochilão|natureza|sapato|trilha
🥿|confortável|sapatilha|sapatilha de balé|sapato|sem fivela
👠|acessório|chique|fashion|moda|mulher|salto alto|sapato|sapato de salto alto
👡|acessório|feminino|sandália feminina|sandálias|sandálias femininas
👢|acessório|bota|bota feminina|botas|feminino|sapato
👑|acessório|coroa|família real|game of thrones|medieval|rainha|realeza|rei|reinado
👒|acessório|chapéu|chapéu feminino|fashion
🎩|cartola|chapéu|chique|entretenimento|roupa
🎓|capelo|chapéu|comemoração|formatura
🧢|boné|boné de beisebol|chapéu
⛑️|ajuda|branca|capacete|cruz|primeiros|resgate|rosto|salvamento|socorrista|socorros|vermelho
💄|batom|cosméticos|makeup|maquiagem|vermelho
💍|anel|diamante|romance
💼|mala|maleta|pasta
🐶|animal|cachorro|rosto|rosto de cachorro
🐱|animal|felino|gatinho|gato|rosto|rosto de gato
🐭|animal|camundongo|ratinho|rato|rosto|rosto de camundongo
🐹|animal|hamster|rosto|rosto de hamster
🐰|animal|coelho|rosto|rosto de coelho
🦊|animal|bicho|raposa|rosto|rosto de raposa
🐻|animal|rosto|rosto de urso|urso
🐼|animal|panda|rosto|rosto de panda
🐨|animal|coala
🐯|animal|rosto de tigre|tigre
🦁|animal|leão|rosto|rosto de leão|zodíaco
🐮|animal|fazenda|leite|muuu|rosto|rosto de vaca|vaca|vaquinha
🐷|animal|porco|rosto|rosto de porco
🐽|animal|nariz|nariz de porco|porco|rosto
🐸|animal|rosto|rosto de sapo|sapo
🐵|animal|macaco|rosto|rosto de macaco
🙈|envergonhado|macaco|macaco com olhos tapados|macaco não veja o mal|macaco que não vê nada|não veja o mal|olhos tapados|vergonha
🙉|macaco|macaco com ouvidos tapados|macaco não ouça o mal|macaco que não ouve nada|não ouça o mal|não ouço|não quero ouvir|ouvidos tapados
🙊|animal|boca tapada|macaco|macaco com as mãos tapando a boca|macaco que não fala nada|não|não posso contar|não posso falar|segredo|silencio|ups
🐒|animal|macaco
💥|colisão|emoção|engraçado|explosão|símbolo de colisão
💫|brilhante|emoção|engraçado|estrelas|olhando para as estrelas|zonzo
💦|borrifo|com suor|emoção|engraçado|pingos de suor|splash|suor
💨|correr|corrida|emoção|engraçado|fugir|rapidez
🦍|animal|gorila|macaco
🐕|animal|cachorro|cão
🐩|animal|cachorro|poodle
🐺|animal|lobo|rosto|rosto de lobo
🦝|animal|astuto|curioso|guaxinim|travesso
🐈|animal|felino|gato
🐅|animal|tigre
🐆|animal|leopardo|onça
🐴|animal|cavalo|equino|rosto|rosto de cavalo
🐎|animal|cavalo|corrida|equestre
🦄|animal|rosto|rosto de unicórnio|unicórnio
🦓|animal|listra|listras|zebra
🐂|animal|boi|Touro|zodíaco
🐃|água|animal|búfalo|búfalo-asiático
🐄|animal|fazenda|vaca
🐖|animal|porco
🐗|animal|javali
🐏|animal|áries|carneiro|chifre|zodíaco
🐑|animal|fazenda|lã|ovelha
🐐|animal|bode|cabra|capricórnio|zodíaco
🐪|animal|camelo|camelo de uma só corcova|corcova|deserto|dromedário
🐫|animal|camelo|camelo asiático com duas corcovas|camelo com duas corcovas|corcova|deserto
🦙|alpaca|animal|guanaco|lã|lhama|vicunha
🦒|animal|girafa
🐘|animal|elefante
🦏|animal|rinoceronte
🦛|animal|hipopótamo
🐁|animal|camundongo|ratinho
🐀|animal|ratazana|rato
🐇|animal|coelhinho|coelhinho da páscoa|coelho
🐿️|animal|esquilo
🦔|animal|espinhoso|ouriço|porco-espinho
🦇|animal|morcego|vampiro
🦘|animal|Austrália|canguru|filhote|joey|marsupial|pula|pulo|salto
🦡|animal|incomodar|ratel|texugo|texugo de mel
🐾|animal|pata|patas|patinhas de cachorro|pegada|pegada de pata
🦃|animal|ave|peru|peru de natal
🐔|animal|ave|galinha
🐓|animal|ave|galo
🐣|animal|ave|bebê|chocando|filhote|galinha|pintinho|pinto
🐤|animal|ave|bebê|filhote|galinha|pintinho|pintinho de perfil|pinto|rosto de pintinho
🐥|animal|ave|bebê|fihote|galinha|pintinho|pintinho de frente|pintinho olhando para frente|pinto
🐦|animal|pássaro
🐧|animal|antartica|frio|pinguim
🕊️|animal|ave branca|pássaro|paz|pomba|pomba branca
🦅|águia|pássaro
🦆|animal|pássaro|pato
🦢|animal|ave|cisne|pássaro|patinho feio
🦉|coruja|pássaro|sabedoria
🦚|animal|ave|colorido|orgulhoso|pavão|pavoa|pomposo
🦜|animal|ave|fala|papagaio|pássaro|pirata|repete
🐊|animal|crocodilo|jacaré
🐢|animal|tartaruga
🦎|animal|lagartixa|lagarto|réptil
🐍|animal|cobra|réptil|serpente
🐲|animal|dragão|rosto|rosto de dragão
🐉|animal|dragão|game of thrones
🦕|braquiosaurus|braquiossauro|brontossauro|brontossuro|dinossauro|diplódoco|diplodocus|saurópode
🦖|dinossauro|t-rex|T-Rex|tiranossauro rex
🧌|conto de fadas|fantasia|gigante|monstro|ogro|troll
🐳|animal|baleia|baleia esguichando água|esguicho
🐋|animal|baleia|mar|oceano
🐬|animal|golfinho|oceano
🐟|animal|peixe|Peixes|pesca|pescar|signo de peixes|zodíaco
🐠|animal|peixe|peixe tropical
🐡|animal|baiacu|peixe
🦈|peixe|tubarão
🐙|animal|oceano|octopus|polvo
🪹|aninhando|galhos|lar|ninho|ninho vazio|passarinho|pássaro
🪺|aninhando|galhos|lar|ninho|ninho com ovos|ovo|ovos|passarinho|pássaro
🐚|animal|caramujo|concha|concha do mar|concha em espiral
🪸|coral|mar|mudança climática|oceano|recife
🐌|animal|caracol|escargot
🦋|beleza|borboleta|inseto
🐛|animal|centopeia|inseto|lagarta
🐜|animal|formiga|inseto
🐝|abelha|animal|inseto|natureza
🐞|animal|besouro|inseto|joaninha|tipo de besouro
🦗|gafanhoto|grilo|inseto
🕷️|animal|aranha|dias das bruxas|halloween|inseto
🕸️|aranha|halloween|inseto|teia|teia de aranha
🦂|animal|deserto|escorpião|inseto|zodíaco
🦟|aedes aegypti|animal|chicungunha|dengue|doença|febre|febre amarela|inseto|malária|mosquito|pernilongo|vírus|zica
🦠|ameba|bactéria|ciência|micróbio|vírus
💐|aniversário|buquê|flor|planta|romance
🌸|cereja|cerejeira|flor|flor de cerejeira|planta|primavera
💮|carimbo|carimbo de flor|carimbo de parabéns|flor|flor branca
🏵️|flor|flor amarela|planta|primavera|roseta
🪷|beleza|budismo|calma|flor|flor de lótus|hinduísmo|Índia|lótus|paz|pureza|serenidade|Vietnã
🌹|flor|rosa
🥀|flor|morrendo|murcha|murchando
🌺|flor|hibisco|planta|primavera
🌻|flor|girassol|planta
🌼|flor|florescer|planta
🌷|flor|tulipa
🌱|brotar|broto|jovem|muda|muda de planta|planta jovem|plantinha
🌲|árvore|árvore de pinheiro|conífera|floresta|natal|pinheirinho|pinheiro
🌳|árvore|árvore cheia|caidiça|desfolha|natureza
🌴|árvore|árvore de palmeira|coqueiro|palmeira
🌵|cacto|deserto|natureza|planta|seca
🌾|arroz|comida|espiga|espiga de arroz|fazenda|grãos|planta|planta de arroz|planta do arroz
🌿|erva|folha|planta
☘️|Irlanda|irlandês|planta|trevo|trevo de três folhas
🍀|folhas|irlandês|planta|quatro|sorte|sortudo|trevo|trevo de quatro folhas
🍁|folha|folha caída|folha de bordo|folha vermelha|maple|outono
🍂|caídas|cair|folha|folhas|outono
🍃|folha|folha ao vento|soprando|vento
🍄|champignon|cogumelo|fungo|mario|planta
🌰|castanha|planta
🦀|animal|animal marinho|Câncer|caranguejo|signo de câncer|zodíaco
🦞|animal|bisque|caldo|fruto do mar|garras|lagosta
🦐|animal|camarão|comida|crustáceo
🦑|animal|comida|lula|molusco
🌍|África|Europa|globo mostrando Europa e África|Terra
🌎|América|as Américas|globo mostrando as Américas|Terra
🌏|Ásia|Austrália|globo mostrando Ásia e Oceania|Oceania|planeta terra|Terra
🌐|globo com meridianos|meridianos
🌑|escuro|lua|lua negra|noite|nova
🌒|côncava|crescente|lua|noite
🌓|lua|lua de quarto crescente|quarto|quarto crescente
🌔|convexa|crescente|lua
🌕|cheia|lua|luar
🌖|convexa|lua|minguante
🌗|lua|lua de quarto minguante|quarto|quarto minguante
🌘|côncava|lua|minguante
🌙|crescente|lua
🌚|lua|lua nova|lua nova com rosto|rosto|rosto da lua nova
🌛|crescente|lua|noite|quarto|rosto
🌜|lua|lua com rosto|lua de quarto minguante|quarto minguante|quarto minguante com rosto|rosto|rosto da lua de quarto minguante
☀️|clima|dia claro|raios|sol|solar|tempo
🌝|cheia|lua|lua cheia com rosto|lua com rosto|rosto|rosto da lua cheia
🌞|praia|rosto|sol
⭐|estrela|estrela branca média
🌟|brilhante|brilho|cintilante|estrela|luminosa|reluzente
🌠|cadente|cai|estrela
☁️|clima|nuvem
⛅|clima|nublado|nuvem|sol|sol com nuvens|sol por trás das nuvens
⛈️|chuva|clima|nuvem|relâmpago|temporal|trovão
🌤️|clima|nublado|nuvem|sol|sol com nuvens
🌥️|clima|nublado|nuvem|sol
🌦️|chuva|clima|nuvem|sol|sol com chuva
🌧️|chovendo|chuva|clima|nuvem
🌨️|clima|frio|neve|nuvem
🌩️|clima|nuvem|nuvem com trovão|relâmpago
🌪️|clima|furacão|nuvem|tornado
🌫️|clima|furacão|neblina|nevoeiro|nuvem
🌬️|clima|nuvem|rosto|soprar|sopro|vento
🌈|arco-íris|chuva|clima|gay|lésbica|lgbt|lgbtqia+|natureza|orgulho|queer|transgênero
☔|acessório|chuva|clima|gotas|guarda-chuva|sombrinha
⚡|alta|eletricidade|natureza|perigo|relâmpago|sinal|tensão
❄️|clima|floco|floco de neve|frio|neve
☃️|boneco|clima|frio|inverno|neve
⛄|boneco|frio|inverno|neve
☄️|cometa|espaço|estrela cadente|meteoro|satélite
🔥|chama|fogo
💧|com suor|engraçado|gota|gota de suor|suor
🫧|água|aquática|aquático|arroto|bolha|bolhas|embaixo d’água|flutuar|limpo|pérolas|sabão
🌊|onda|onda de água|onda do oceano|tsunami
🎄|árvore|comemoração|Natal|pinheirinho
✨|*|brilhos|estrelas|estrelas brilhantes|faíscas|mágica
🎋|árvore|comemoração|Estrelas|Festival|japonesa|papel|tanabata|tiras
🎍|bambu|comemoração|decoração de pinhas|decoração de pinhos|japonês|pinha
🍇|fruta|uva|uvas
🍈|fruta|melão
🍉|fruta|melancia
🍊|cítrica|fruta|laranja|tangerina
🍋|azedo|cítrico|fruta|lima|limão|limão siciliano
🍌|banana|fruta
🍍|abacaxi|comida|fome|fruta
🥭|comida|fruta|manga|tropical
🍎|fruta|maçã|vermelha
🍏|comida|fome|fruta|maçã|verde
🍐|comida|fome|fruta|pera
🍑|fruta|pêssego
🍒|cereja|comida|fome|fruta|frutas vermelhas
🍓|comida|fome|fruta|frutas vermelhas|morango
🥝|comida|fruta|kiwi
🍅|fruta|fruto|legume|tomate|vegetal
🥥|coco|fruta|palmeira|piña colada
🥑|abacate|comida|fruta
🍆|beringela|berinjela|comida|legume|vegetal
🥔|batata|comida|fome|legume|vegetal
🥕|cenoura|comida|fome|legume|salada|vegetal
🌽|comida|espiga|espiga de milho|fome|milho
🌶️|apimentada|apimentado|pimenta|tempero
🥒|comida|fome|legume|pepino|picles|salada|vegetal
🥬|alface|bok choy|comida|couve|hambúrguer|repolho|repolho chinês|salada|verdura
🥦|brócoli|brócolis
🥜|amendoim|comida
🫘|alimento|comida|feijão|feijões|grão|legume
🍞|pão|pão de forma|pão para fatiar|restaurante|torrada|tostex
🥐|café da manhã|comida|croissant|fome|pão
🥖|baguete|bisnaga|comida|pão|pão francês
🥨|pão torcido|pretzel
🥯|café da manhã|chimia|comida|confeitaria|pão|rosca|rosquinha
🥞|café da manhã|comida|crepes|fome|panquecas
🧀|comida|fome|queijo|queijo suíço
🍖|carne|carne com osso|carne no osso|churras|churrasco|osso|restaurante
🍗|aves|comida|coxa|coxa de frango|coxinha|fome|osso|peru|restaurante
🥩|bife|carne|carne vermelha|corte de carne|costela de cordeiro|costeleta|costeleta de porco|porco
🥓|bacon|comida|fome|toucinho
🍔|búrguer|cheese burguer|hambúrguer|restaurante
🍟|batata frita|comida|fast food|fome|fritas|lanchonete|restaurante
🍕|fatia|pizza|restaurante
🌭|cachorro quente|cachorro-quente|hot dog|pão com salsicha|pão com vina|vina
🥪|pão|pão de forma|sanduíche
🌮|comida mexicana|mexicano|taco|tacos
🌯|burrito|comida mexicana|mexicano
🥙|comida|kebab|pão|pão recheado|recheio|wrap
🍳|comida|culinária|frigideira|ovo|ovo estrelado|ovo frito|restaurante
🥘|caçarola|caçarola com comida|comida|fome|paella|panela|rasa
🍲|ensopado|panela|restaurante|tigela de comida
🥣|café da manhã|cereal|prato de sopa|tigela com colher
🥗|comida|fome|restaurante|salada|verde
🍿|balde|cinema|pipoca
🧂|comida|condimento|sabor|sal|saleiro|salgado
🥫|comida enlatada|lata
🫙|armazenar|condimento|conserva|jarra|jarro|molho|nada|pote|recipiente|vazio|vidro
🍱|almoço japonês|bentô|caixa|caixa de bentô|restaurante
🍘|arroz|biscoito de arroz|bolacha de arroz|cracker
🍙|arroz|bolinho de arroz|comida|fome|japonês|onigiri|restaurante
🍚|arroz|arroz cozido|comida|fome|restaurante
🍛|arroz|arroz com curry|curry|curry e arroz|restaurante
🍜|comida|fome|lámen|macarrão|miojo|quentinha|ramen|restaurante|sopa|tigela|tigela de macarrão
🍝|comida|espaguete|fome|italiano|macarrão|macarronada|restaurante
🍠|assada|batata|batata-doce|doce|restaurante
🍢|espetinho|frutos do mar|frutos do mar no espetinho|oden|restaurante
🍣|comida japonesa|restaurante|restaurante japonês|sashimi|sushi
🍤|camarão|camarão empanado|camarão frito|restaurante|tempura
🍥|bolinho de peixe|bolinho de peixe com redemoinho|croquete de peixe|peixe|restaurante
🥮|bolo da lua|bolo lunar|comida|confeitaria|festival|festival chinês|outono|yuèbǐng
🍡|bolinho de mochi|bolinho de mochi no espetinho|bolinho japonês|comida|dango|doce|fome|japonês|mochi|mochiko|sobremesa
🥟|asiático|bolinho|chinês|dumpling|empanada|gyōza|jiaozi|massa|pierogi|potsticker
🥠|biscoito chinês|biscoito da fortuna|biscoito da sorte|profecia|sorte
🥡|caixa para viagem|caixinha para levar|delivery|marmita
🍦|doce|fome|sobremesa|sorvete|sorvete de casquinha|sorvete de massa|sorvete italiano|sorvete na casquinha
🍧|gelo|raspadinha|raspadinha de gelo|restaurante|sobremesa
🍨|creme|gelo|restaurante|sobremesa|sorvete
🍩|comida|donut|fome|restaurante|rosquinha|sonho doce
🍪|biscoito|bolacha|comida|cookie|doce|fome|sobremesa
🎂|aniversário|bolo|bolo de aniversário|comemoração|doce|feliz aniversário|festa|niver
🍰|bolo|bolo recheado|doce|fatia|fatia de bolo|pão de ló|pão de ló de morango|restaurante|sobremesa
🧁|açúcar|bolinho|bolo|comida|confeitaria|confeito|cupcake|doce|sobremesa|torta
🥧|abóbora|carne|doce|fatia|fatia de torta|fruta|maçã|padaria|recheio|salgado|torta
🍫|barra|barra de chocolate|chocolate|doce|fome
🍬|bala|balinha|doce
🍭|bala|doce|pirulito
🍮|pudim|pudim de leite|pudim de ovos|restaurante
🍯|mel|pote|pote de mel|restaurante
🍼|bebê|leite|leitinho|mamadeira|mamar|neném
🥛|copo|copo de leite|leite
🫗|acabou|acidente|água|bebida|derramando líquido|derramar|derrubar|fim|ops|pingar|pingo|vazio|vidro
☕|café|cafeína|cafezinho|chá|inverno|quente
🍵|bebida|chá|chá verde|xícara|xícara de chá|xícara de chá sem alça
🧉|bebida|chimarrão|cuia de chimarrão|mate|tereré
🍶|bar|bebida|copo|garrafa|garrafa e copo de saquê|japonês|restaurante|saquê
🍾|aniversário|bar|champagne|champanha|champanhe|cidra|comemorar|espumante|espumante estourando|estourar|festa|garrafa|garrafa de champanhe|parabéns
🍷|bar|bebida|cálice de vinho|restaurante|taça|vinho
🍸|bar|beber|bebida|cachaça|coquetel|happy hour|martini|restaurante|taça|taça de coquetel
🍹|bar|bebida|coquetel|coquetel de frutas|drink|happy hour|restaurante|tropical
🍺|bar|bebida|caneca|caneca de cerveja|cerveja|chopp|gelada|happy hour|restaurante
🍻|bar|caneca|cerveja|chope|Chopp|restaurante
🥂|brinde|champagne|champanhe|comemoração|taça|taças brindando|tim-tim
🥃|bar|bebida|copo|drink|whisky
🥤|água|canudo|copo|copo com canudo|refrigerante|suco
🥢|comida japonesa|hashi|pauzinhos
🍽️|almoço|faca|fome|garfo|jantar|prato|prato com talheres ao lado|restaurante|talheres
🍴|almoço|comer|comida|faca|fome|garfo|garfo e faca|jantar|restaurante|talher|talheres
🥄|colher|talher
🗾|Japão|mapa
🏔️|alpes|frio|montanha|montanha com neve|neve
⛰️|montanha|natureza
🌋|erupção vulcânica|lava|natureza|vulcão
🗻|montanha|Monte Fuji
🏕️|acampamento|barraca
🏖️|guarda-sol|praia|praia e guarda-sol
🏜️|clima seco|deserto
🏝️|ilha|ilha deserta|palmeira|praia
🏞️|parque|parque com rio|parque nacional|reserva florestal|rio
🏟️|arena|estádio
🏛️|arquitetura|clássico|grego|prédio grego
🏗️|construção|guindaste|obra
🏘️|casas
🏚️|casa|casa abandonada
🏠|casa|construção|domicílio|lar|residência
🏡|casa|casa com jardim|construção|jardim|lar
🏢|edifício|edifício comercial|escritório
🏣|correio|japonês|oriental|prédio
🏤|correio|europeu|prédio
🏥|doente|hospital|internado|médico|prédio
🏦|banco|prédio
🏨|hotel|prédio
🏩|amor|hotel|motel|prédio
🏪|24 horas|24h|conveniência|loja|loja de conveniência|prédio
🏫|colégio|escola|prédio|prédio da escola
🏬|departamentos|estabelecimento comercial|loja|loja de departamentos
🏭|fábrica|prédio
🏯|castelo|japonês|pagoda|pagode|prédio
🏰|castelo|castelo europeu|castelo medieval|prédio
💒|capela|capela de casamento|casamento|romance
🗼|Japão|Tóquio|torre|Torre de Tóquio
🗽|estátua|Estátua da Liberdade|liberdade
⛪|capela|cristã|cristão|igreja|missa|prédio|religião
🕌|islã|mesquita|muçulmano|religião
🕍|judaísmo|judeu|judia|religião|sinagoga|templo
⛩️|japonês|oriental|religião|santuário|xintoísmo
🕋|caaba islã|islã|muçulmano|religião
⛲|água|chafariz|fonte|praça
⛺|acampamento|acampar|barraca
🌁|bruma|cerração|enevoado|neblina|névoa|nevoeiro
🌃|cidade à noite|estrelas|noite|noite estrelada|prédios
🏙️|cidade|prédios|urbano
🌄|aurora sobre montanhas|montanha|nascer do sol sobre as montanhas|sol da manhã
🌅|amanhecer|aurora|aurora sobre água|natureza|oceano|rio|sol|sol da manhã|sol nascendo
🌆|anoitecer|cidade|cidade ao anoitecer|noite|paisagem|pôr do sol|prédio
🌇|anoitecer|calor|cidade|entardecer|pôr do sol|pôr do sol sobre prédios|prédio
🌉|noite|ponte|ponte à noite|pontilhão
🎠|carrossel|cavalo|cavalo de carrossel|entretenimento|parque de diversão
🎡|entretenimento|gigante|parque de diversões|roda
🎢|entretenimento|montanha|parque de diversões|parque temático|russa
🚂|locomotiva|trem|vapor|veículo
🚃|bonde|elétrico|ferroviário|transporte|trem|trólebus|vagão|veículo
🚄|sistema de trens bala japonês|trem|trem bala|trem de alta velocidade|veículo
🚅|bala|ferrovia|japão|trem|velocidade|veloz|viagem
🚆|ferrovia|trem|veículo
🚇|metrô|trem|túnel|túnel subterrâneo|veículo
🚈|chegada|cheguei|leve|trem|trem urbano|veículo
🚉|estação|estação de trem|metrô|trem
🚊|bonde elétrico|trólebus|veículo
🚝|monotrilho|trem|veículo
🚞|carro|estrada de ferro|estrada de ferro na montanha|montanha|teleférico|veículo
🚋|bonde|bonde elétrico|carro|trólebus|veículo
🚌|ônibus|transporte público|veículo
🚍|ônibus|ônibus se aproximando|se aproximando|veículo
🚎|bonde elétrico|ônibus|ônibus movido a eletricidade|trólebus|veículo
🚐|mini ônibus|ônibus|van|veículo|veraneio
🚑|ambulância|veículo
🚒|bombeiro|caminhão do corpo de bombeiros|carro|carro do corpo de bombeiros|fogo|incêndio|veículo
🚓|carro patrulha|polícia|veículo|viatura policial
🚔|polícia|veículo|viatura policial|viatura policial se aproximando
🚕|táxi|veículo
🚖|chegada|táxi|transporte|veículo
🚗|automóvel|carro|veículo
🚘|automóvel|carona|carro|carro se aproximando|chegada|se aproximando|veículo
🚚|caminhão|caminhão de entrega|veículo
🚛|caminhão|caminhão articulado|semi|trailer|veículo
🚜|obra|trator|veículo
🏎️|automobilismo|carro|carro de corrida|corrida
🏍️|corrida|moto|motocicleta|veículo
🛵|monareta|motinho|moto|motoca|scooter
🚲|bicicleta|bike|veículo
🛴|brinquedo|patinete
🚏|bus|busão|ônibus|ponto|ponto de ônibus|transporte público
🛤️|trem|trilhos
⛽|abastecer|álcool|bomba|combustível|gasolina|posto
🛞|carro|círculo|direção|girar|pneu|roda|veículo|volante
🚨|carro da polícia|farol policial|luz de viatura policial|luz giratória|sirene
🚥|luz|semáforo|semáforo horizontal|sinais de trânsito|sinal de trânsito|sinaleira|sinaleiro|trânsito
🚦|cruzamento|luz|semáforo vertical|sinais de trânsito|sinaleira|sinaleiro|trânsito
🚧|construção|em construção|símbolo|símbolo para “em construção”
⚓|âncora|marinha|navegar|sinal
⛵|barco|barco a vela|iate|navegar|resort|resort marítimo
🚤|barco|férias|lancha|praia|veículo|verão
🛳️|barco|cruzeiro|embarcação|navio|passageiros|veículo
⛴️|balsa|barco|ferry|ferry boat|ferry-boat|navegar
🛥️|barco|lancha|motor|navio|veículo
🚢|barco|cruzeiro|férias|navio|veículo aquático|viagem
🛟|boia|colete salva-vidas|flutuar|guarda-vidas|nadar|resgate|salva-vidas|salvar|segurança
✈️|aéreo|avião|veículo|viajar|voar|voo
🛩️|aéreo|avião|jatinho|jato|pequeno|veículo
🛫|avião decolando|decolando|decolar|férias|partindo|partiu|veículo|viagem|viajando
🛬|aterrissagem|aterrissando|avião|chegando|pousando|veículo|voltando
💺|assento|cadeira|poltrona
🚁|helicóptero|veículo|viagem|viajar|voo
🚟|estrada de ferro|estrada de ferro suspensa|suspensão|trem|veículo
🚠|bonde|cabo|cabo suspenso usado em teleféricos nas montanhas|montanha|teleférico|teleférico na montanha|veículo
🚡|aérea|gondola|gôndola|linha de bonde|linha de bonde aérea|teleférico|veículo
🛰️|antena no espaço|satélite|veículo
🚀|espaço|foguete|veículo
🛸|disco voador|disco voador, ovni, alienígena, extra terrestre, ET|OVNI
🌌|céu|espaço|estrelado|via láctea
⛱️|chuva|clima|guarda-sol|praia|sol|sombra|sombrinha
🎆|ano novo|comemoração|fogos|fogos de artifício
🎇|comemoração|fogo de artifício|fogo de artifício vela estrela|vela estrela
🎑|cerimônia de contemplação da lua|comemoração|contemplação|contemplação da lua|lua
🗿|estátua|moai|moyai|Moyai|rosto
🛂|controle|passaporte
🛃|aduana|aduaneira|alfândega|bens|federal|impostos|receita
🛄|aeroporto|área|bagagem|bagagens|esteira|férias|mala|recolhimento|restituição|viagem
🛅|bagagem|depósito|esquecida|malas|serviço
🧗‍♂️|alpinista|escalada|escalando|escalar|esporte|montanha homem|masculino|símbolo de masculino
🧗‍♀️|alpinista|escalada|escalando|escalar|esporte|montanha feminino|mulher|símbolo de feminino
🏇|cavalo|corrida|esporte|jockey|jóquei
⛷️|esporte|esqui|esquiador|frio|neve
🏂|esporte|inverno|praticante de snowboard|snowboard|snowboarder
🏌️‍♂️|bola|esporte|golf|golfe|golfista|jogando homem|masculino|símbolo de masculino
🏌️‍♀️|bola|esporte|golf|golfe|golfista|jogando feminino|mulher|símbolo de feminino
🏄‍♂️|esporte|ondas|pegar onda|pessoa|pessoa surfando|praia|prancha|surf|surfar|surfe|surfista homem|masculino|símbolo de masculino
🏄‍♀️|esporte|ondas|pegar onda|pessoa|pessoa surfando|praia|prancha|surf|surfar|surfe|surfista feminino|mulher|símbolo de feminino
🚣‍♂️|barco|barco a remo|bote|canoa|pessoa remando|transporte|veículo homem|masculino|símbolo de masculino
🚣‍♀️|barco|barco a remo|bote|canoa|pessoa remando|transporte|veículo feminino|mulher|símbolo de feminino
🏊‍♂️|esporte|nadar|natação|pessoa nadando|triatlo homem|masculino|símbolo de masculino
🏊‍♀️|esporte|nadar|natação|pessoa nadando|triatlo feminino|mulher|símbolo de feminino
⛹️‍♂️|arremesso|atleta|basquete|bater bola|bola|cesta|esporte|jogador de basquete|lance livre|pessoa batendo bola|pessoa jogando basquete homem|masculino|símbolo de masculino
⛹️‍♀️|arremesso|atleta|basquete|bater bola|bola|cesta|esporte|jogador de basquete|lance livre|pessoa batendo bola|pessoa jogando basquete feminino|mulher|símbolo de feminino
🏋️‍♂️|bodybuilder|esporte|fisiculturista|força|levantar|peso homem|masculino|símbolo de masculino
🏋️‍♀️|bodybuilder|esporte|fisiculturista|força|levantar|peso feminino|mulher|símbolo de feminino
🚴‍♂️|bicicleta|bike|ciclismo|ciclista|esporte|pedalar homem|masculino|símbolo de masculino
🚴‍♀️|bicicleta|bike|ciclismo|ciclista|esporte|pedalar feminino|mulher|símbolo de feminino
🚵‍♂️|bicicleta|ciclismo|ciclista|esporte|montanha|mountain bike|pedalando|trilha homem|masculino|símbolo de masculino
🚵‍♀️|bicicleta|ciclismo|ciclista|esporte|montanha|mountain bike|pedalando|trilha feminino|mulher|símbolo de feminino
🤸‍♂️|animada|animado|esporte|estrela|estrelinha|feliz|ginasta|ginástica|pessoa homem|masculino|símbolo de masculino
🤸‍♀️|animada|animado|esporte|estrela|estrelinha|feliz|ginasta|ginástica|pessoa feminino|mulher|símbolo de feminino
🤼‍♂️|combate|esporte|luta|luta greco-romana|luta livre|lutadores|pessoa|pessoas|pessoas lutando|ringue homem|masculino|símbolo de masculino
🤼‍♀️|combate|esporte|luta|luta greco-romana|luta livre|lutadores|pessoa|pessoas|pessoas lutando|ringue feminino|mulher|símbolo de feminino
🤽‍♂️|esporte|esporte aquático|pessoa|pessoa jogando polo aquático|piscina|polo aquático homem|masculino|símbolo de masculino
🤽‍♀️|esporte|esporte aquático|pessoa|pessoa jogando polo aquático|piscina|polo aquático feminino|mulher|símbolo de feminino
🤾‍♂️|atleta|bola|esporte|gol|handball|handebol|jogador|jogando|passe|pessoa homem|masculino|símbolo de masculino
🤾‍♀️|atleta|bola|esporte|gol|handball|handebol|jogador|jogando|passe|pessoa feminino|mulher|símbolo de feminino
🤹‍♂️|equilíbrio|fazer malabarismo|habilidade|malabares|malabarismo|malabarista|multitarefa homem|masculino|símbolo de masculino
🤹‍♀️|equilíbrio|fazer malabarismo|habilidade|malabares|malabarismo|malabarista|multitarefa feminino|mulher|símbolo de feminino
🧘‍♂️|ioga|meditação|pernas cruzadas|pessoa em posição de lótus, meditação, yoga, serenidade, pernas cruzadas, pernas cruzadas, relaxar|pessoa na posição de lótus|relaxar|yoga|zen homem|masculino|símbolo de masculino
🧘‍♀️|ioga|meditação|pernas cruzadas|pessoa em posição de lótus, meditação, yoga, serenidade, pernas cruzadas, pernas cruzadas, relaxar|pessoa na posição de lótus|relaxar|yoga|zen feminino|mulher|símbolo de feminino
🎪|circo|entretenimento|lona|lona de circo|tenda
🛹|rodinhas|skate|skatista
🎗️|celebração|comemoração|fita de lembrete|laço|lembrete
🎟️|entrada|ingresso|ingresso de cinema|ticket
🎫|entretenimento|ingresso
🎖️|condecoração|medalha|militar|prêmio
🏆|campeã|campeão|prêmio|troféu
🏅|medalha|medalha esportiva|vitória
🥇|1o. lugar|1º. lugar|medalha|ouro|vitória
🥈|2o. lugar|2º. lugar|medalha|prata|segundo
🥉|3o. lugar|3º. lugar|bronze|medalha|terceiro
⚽|bola|futebol|jogar
⚾|beisebol|bola|esportes
🥎|bola|esporte|luva|softball|softbol
🏀|basquete|bola|cesta|esporte|jogo
🏐|bola|jogar|jogo|vôlei
🏈|americano|bola|bola de futebol americano|esporte|futebol americano|super bowl
🏉|americano|bola|esporte|futebol|rugby
🎾|bola|esporte|raquete|tênis
🥏|disco|esporte|frisbee|ultimate|voador
🎳|bola|boliche|jogo|strike
🏏|betes|bola|críquete|jogo|taco
🏑|bola|campo|hóquei|hóquei de campo|jogo|taco
🏒|disco|gelo|hóquei|hóquei no gelo|jogo|taco
🥍|bastão|bola|esporte|gol|lacrosse|raquete|taco
🏓|mesa|pingpong|pingue-pongue|raquete|tênis de mesa
🏸|badminton|jogo|peteca|raquete
🪃|aborígene|arma|austrália|bumerangue|rebote|repercussão
🥅|esporte|futebol|gol|goleira|goleiro|rede
⛳|bandeira|buraco|esporte|golfe
🪁|papagaio|pipa|planar|voar
🛝|brincar|brinquedo|escorregador|escorregar|parque de diversões|parquinho|playground
🏹|arco|arco e flecha|arma|flecha|sagitário|zodíaco
🎣|entretenimento|peixe|pesca|pescador|pescaria|recreação|vara
🤿 |esnórquel|máscara de mergulho|mergulhador|mergulhadora|mergulho|scuba|snorkel|snorkeling
🥊|boxe|esporte|lutar boxe|luva|luva de boxe
🥋|artes marciais|esporte|faixa preta|judô|karatê|quimono|quimono de artes marciais|taekwondo|uniforme
🎽|camiseta|corrida|esporte|faixa
🛼|esporte|patinação|patins|patins de rodas|rodas|roller
🛷|trenó|trenó, tobogã, neve
⛸️|gelo|patinação|patins
🥌|pedra|pedra de curling|pedra de curling, jogo
🎿|bota|esporte|esqui|esquiar|neve
🎯|dardos|jogo|mira|na mosca|no alvo|tiro|tiro certeiro
🎱|bilhar|bola oito|jogo
🎮|controle|game|jogo|jogos|playstation|video|videogame|xbox
🎰|aposta|caça-níquel|cassino|jogo de azar|máquina caça-níqueis
🎲|dado|dados|jogo|sorte
🧩|dica|encaixe|peça|quebra-cabeça
♟️|peão|peão de xadrez|truque|xadrez
🎭|arte|arte dramática|ator|atriz|entretenimento|espetáculo|máscara|peça|performance|teatro
🎨|arte|artista|museu|paleta|paleta artística|paleta de tintas|pintor|pintura|tinta
🎼|música|partitura|partitura musical
🎤|cantar|entretenimento|karaokê|mic|microfone|música
🎧|entretenimento|fone de ouvido|fones de ouvido|música|som
🎷|instrumento|instrumento musical|música|sax|saxofone
🎸|guitarra|instrumento|instrumento musical|música
🎹|instrumento|instrumento musical|música|piano|teclado|teclado musical
🎺|instrumento|instrumento musical|música|trompete
🎻|instrumento|instrumento musical|música|violino
🥁|baquetas|música|percussão|tambor
🎬|cena|claquete|entretenimento|filme|tomada
💌|carta|carta de amor|coração|correspondência com coração|romance
🕳️|buraco|buraco no chão
💣|bomba|emoção|engraçado|explosão|explosivo|perigo
🛀|água|banheira|banho|banho de banheira|banho de espuma|pessoa tomando banho
🛌|boa noite|cama|cochilo|dormindo|dormir|hotel|pessoa|pessoa deitada na cama|soneca|sono
🏺|ânfora|ornamento chinês|vaso|vaso chinês
🗺️|geografia|mapa|mapa-múndi|mundo
🧭|bússola|bússola magnética|direção|ímã|magnético|navegação|norte|orientação|pontos cardeais
🧱|argamassa|argila|cimento|muro|parede|terra|tijolo
💈|barbearia|barbeiro|barber pole|cortar cabelo|poste|poste de barbeiro
🛢️|barril|lata|latão|óleo
🛎️|hotel|portaria|sineta|sino
⌛|ampulheta|areia|tempo
⏳|ampulheta|areia|cheia|contando|em cima|hora|relógio|tempo
⌚|hora|relógio|relógio de pulso|tempo
⏰|alarme|atrasada|atrasado|despertador|hora|horário|relógio
⏱️|cronômetro|relógio|tempo
⏲️|cronômetro|relógio|relógio temporizador|timer
🕰️|relógio|relógio antigo|relógio de mesa
🌡️|clima|temperatura|tempo|termômetro
🧨|bomba|bomba chiando|bombinha|dinamite|estourando|estourar|explosivo|faísca|fogo|fogos de artifício|luz|pirotecnia|roubada
🎈|aniversário|balão|celebração|comemoração|festa de aniversário|parabéns
🎉|alegria|aniversário|celebrar|comemoração|cone de festa|festa|parabéns
🎊|bola|bola de confetes|celebração|comemoração|confete|parabéns
🎎|bonecas|comemoração|festival|japanesas|japonês
🎏|bandeira|bandeira de carpas|comemoração|koinobori|subida de carpas
🎐|carrilhão de vento|sino|som|vento
🪩|balada|boate|bola|brilho|dança|dançar|discoteca|espelhado|espelho|festa|globo|night
🧧|boa sorte|dinheiro|envelope vermelho|hóngbāo|lai see|presente
🎀|comemoração|fita|laço|presente
🎁|comemoração|embrulhado|mimo|presente
🔮|adivinhação|bola|bola de cristal|cristal|destino|prever o futuro
🧿|amuleto|conta|grego|mau-olhado|miçanga|nazar|olho|talismã
🪬|amuleto|Fátima|guia|hamsa|hamsá|mão|Maria|Miriam|palma|proteção|sorte
🕹️|controle|controle de atari|game|jogo|joystick|video game|videogame
🧸|bichinho|brinquedo|enchimento|pelúcia|ursinho|urso
🖼️|arte|moldura|museu|pintura|quadro|quadro emoldurado
🛍️|compras|sacolas|sacolas de compras|sacolas de shopping|shopping
📿|acessório|oração|religião|reza|rosário|rosário de oração|terço
💎|diamante|joia|pedra preciosa
📯|corneta|correios|postal
🎙️|estúdio|microfone|microfone de estúdio|música
🎚️|controle|controle de volume|música|volume
🎛️|botões|botões giratórios|controle|música
📻|rádio|radiola|som|vídeo
📱|celular|telefone|telefone móvel
📲|celular|celular com seta|fazer uma chamada|fazer uma ligação|receber|seta|telefone|telefone celular com seta|telefone móvel
☎️|gancho|telefone|telefone no gancho
📞|aparelho de telefone|comunicação|telefone
📟|comunicação|pager
📠|comunicação|fax|máquina de fax
🔋|bateria|pilha
🪫|acabando a bateria|bateria|bateria fraca|descarregada|descarregado|eletrônico|fim da bateria|pilha|pilha fraca|pouca bateria|pouca energia|sem bateria
🔌|cabo de energia|elétrica|eletricidade|plugue|tomada elétrica
💻|computador|laptop|notebook|PC|pessoal|trabalho
🖥️|computador|computador de mesa|desktop|mesa|monitor
🖨️|acessório|computador|impressão de documento|impressora|imprimir
⌨️|acessório|computador|digitação|teclado
🖱️|acessório|computador|mouse
🖲️|acessório|computador|mouse|mouse de bolinha|trackball
💽|computação|computador|disco|disco de computador|MD|mini disc|minidisc|minidisk
💾|computador|disco|disco flexível|disquete
💿|blu-ray|cd|CD|computador|disco|DVD|óptico
📀|blu-ray|cd|computador|disco|dvd|DVD|óptico
🧮|ábaco|calculadora|cálculo|matemática|número
🎥|câmera|cinema|entretenimento|filmar|filme|hollywood
🎞️|cinema|filme|rolo de filmes
📽️|cinema|filme|projetor|projetor de filmes|vídeo
📺|canal de tv|televisão|TV|video|vídeo
📷|câmera|foto|selfie|vídeo
📸|câmera|flash|foto|fotografia|vídeo
📹|câmera|filmadora|vídeo
📼|cassete|cassete de vídeo|fita|vhs|vídeo|videocassete
🔍|busca|ferramenta|lente de aumento|lupa|lupa apontado para a esquerda|lupa para a esquerda|pesquisa|procura
🔎|ferramenta|lente de aumento|lupa|lupa apontado para a direita|lupa para a direita|pesquisa|procura
🕯️|acesa|luz|vela
💡|elétrica|ideia|lâmpada|luz|quadrinhos|tenho uma ideia
🔦|elétrica|ferramenta|lanterna|luz
🏮|bar|izakaya|lanterna|papel|restaurante|vermelha
📔|caderno|caderno com decoração|capa|decorado|livro
📕|apostila|fechado|livro
📖|aberto|biblioteca|leitura|lendo|ler|livraria|livro
📗|biblioteca|caderno|colégio|escola|estudar|lendo|ler|livraria|livro|verde
📘|apostila azul|azul|estudo|leitura|livro
📙|apostila|cartilha|laranja|livro
📚|biblioteca|estudando|estudar|leitura|lendo|ler|livraria|livro|livros
📓|caderno|folhas
📃|dobrado|documento|página|página com a parte inferior enrolada|página dobrada
📜|pergaminho|rolo de papel
📄|documento|folha|página|página com a parte da frente para cima|página voltada para cima|parte da frente para cima
📰|jornal|notícias
🗞️|enrolado|jornal|notícias
📑|marcador|marcar|página
🔖|livro|marcador|página
🏷️|etiqueta|identificar|rótulo
💰|dinheiro|dólares|saco
💴|cédula|dinheiro|grana|iene|moeda|nota
💵|dinheiro|dólar|moeda|nota|nota bancária|nota de dólar
💶|cédula|dinheiro|euro|grana|moeda|nota
💷|cédula|dinheiro|grana|libra|moeda|nota
💸|asas|banco|cédula|dinheiro|dinheiro indo embora|nota|voando
💳|banco|cartão|crédito|débito|dinheiro
🪪|carta|cartão|carteira|crachá|credenciais|documento|habilitação|identidade|identificação|licença|motorista|RG|segurança
🧾|contabilidade|escrituração|evidência|fatura|prova|recibo
✉️|carta|correspondência|e-mail|email|envelope
📧|carta|comunicação|correspondência|e-mail
📨|carta|chegando|comunicação|correspondência|e-mail|envelope|nova|recebida
📩|carta|comunicação|correspondência|e-mail|email|envelope|seta
📤|bandeja|caixa|comunicação|correspondência|enviada|saída
📥|bandeja|caixa|comunicação|correspondência|e-mail|email|entrada|recebida|recebido
📦|caixa|embrulho|pacote
📫|bandeira|caixa|correio|correspondência|fechada|levantada
📪|abaixada|bandeira|caixa|correio|correspondência|fechada|vazia
📬|aberta|bandeira|caixa de correio aberta com bandeira levantada|caixa de correspondência aberta com bandeira levantada|correspondência
📭|aberta|bandeira|caixa de correio aberta com bandeira abaixada|caixa de correspondência aberta com bandeira abaixada|caixa de correspondência aberta e vazia|correspondência
📮|caixa|carta|correio|correspondência|enviar
🗳️|cédula|eleição|eleitoral|urna|votar|voto
✏️|lápis
✒️|caneta|ponta|preto|tinta|tinteiro
🖋️|caneta|destro|tinteiro
🖊️|caneta|esferográfica|tinteiro
🖌️|pincel|pintando|pintar
🖍️|cera|desenho|giz|vermelho
📝|anotações|caderno|comunicação|lápis|memorando|notas
📁|arquivo|pasta|pasta de arquivos
📂|aberta|abrir|arquivo|pasta
🗂️|arquivo|divisor|índice|organizador|pasta
📅|calendário|data|datas
📆|calendário|data|destacáveis|destacável|dia|folha|páginas|várias
🗒️|bloco|caderno|espiral
🗓️|bloco|calendário|data|espiral
📇|índice|índice de cartões
📈|crescimento|diagrama|gráfico|gráfico de tendência de crescimento|gráfico subindo|tendência de crescimento
📉|diagrama|gráfico|gráfico caindo|gráfico de tendência negativa|negativa|tendência negativa
📊|barra|diagrama|gráfico
📋|anotações|prancheta
📌|alfinete|tacha
📍|alfinete|localização|mapa|redonda|tacha
📎|clipe|clipe de papel
🖇️|clipe|clipes|clipes de papel|clipes de papel conectados
📏|régua|régua reta
📐|ângulo|geometria|matemática|régua|triangular|triângulo
✂️|aberta|cortar|ferramenta|tesoura
🗃️|arquivo|caixa|cartão|documentos|ficheiro
🗄️|arquivo|escritório|gabinete|gavetas|gavetas de escritório
🗑️|cesto|lixeira|lixo
🔒|cadeado|fechado|trancado
🔓|aberto|cadeado|destrancado
🔏|cadeado|caneta|privacidade|privado|tinteiro
🔐|cadeado|chave|fechado|seguro|trancado
🔑|chave|senha|trancado|trancar
🗝️|antiga|chave|fechadura
🔨|construção|ferramenta|martelada|martelo|reparo
⛏️|ferramenta|mineração|picareta
⚒️|ferramenta|geologia|martelo|picareta
🛠️|chave|chave-inglesa|ferramenta|inglesa|martelo
🔪|chef|cozinhar|faca|faca de cozinha
🗡️|adaga|arma|faca
⚔️|arma|batalha|cruzadas|espadas|guerra
🔫|água|arma|ferramenta|pistola|pistola d’água|revólver
🛡️|arma|escudo
🔧|chave|ferramenta|inglesa|obra|reforma
🔩|construção|ferramenta|parafuso|porca
⚙️|engrenagem|ferramenta
🗜️|braçadeira|compressão|ferramenta|morsa|torno
⚖️|balança|ferramenta|justiça|libra|peso|zodíaco
🔗|anéis|corrente|dois|link|símbolo|vínculo
⛓️|corrente|metal
🧰|caixa|ferramenta|mecânico|vermelha
🧲|atração|ferradura|ímã|magnético|positivo-negativo
⚗️|alambique|ferramenta|química
🧪|ciência|ensaio|experiência|experimento|laboratório|química|químico|tubo
🧫|bactéria|biologia|biologista|biólogo|ciência|cultura|laboratório|Petri|placa
🧬|biologista|biólogo|código|dna|evolução|gene|genética|genético|vida
🔬|ciência|ferramenta|microscópico|microscópio
🩻|doutor|esqueleto|médico|ossos|radiografia|raio x
🔭|ciência|ferramenta|telescópio
📡|antena|comunicação|parabólica|satélite
💉|agulha|injeção|médico|remédio|seringa|vacina|vacinação
💊|cápsula|comprimido|medicina|médico|pílula|remédio
🚪|fechada|porta
🛏️|cama|dormir|hotel|sono
🛋️|hotel|lâmpada|sofá|sofá e luminária
🚽|banheiro|patente|privada|sanitário|toalete|vaso
🚿|água|banho|chuveiro|ducha
🛁|banheira|banho
🧴|condicionador|creme|frasco|hidratante|loção|protetor|shampoo|solar|xampu
🧷|alfinete|alfinete de segurança|fralda|punk|rock
🧹|bruxa|limpar|limpeza|varrer|vassoura
🧺|agrícola|agricultura|cesta|lavanderia|lavoura|piquenique|roupa|suja
🧻|higiênico|papel|rolo|toalha
🧼|banho|barra|espuma|limpar|limpeza|sabonete|saboneteira
🧽|absorção|absorvente|encharcar|esponja|limpeza|porosa|poroso
🧯|apagar|extinguir|extintor|fogo|incêndio
🚬|cigarro|é permitido fumar|fumante|fumar|fumo|símbolo|símbolo para “É permitido fumar”
⚰️|caixão|caixão funerário|funeral|morte|velório
⚱️|cinzas|funeral|morte|urna|urna funerária
🚰|água|beber|potável|símbolo|torneira
💘|amor|coração|cupido|emoção|flecha|flechado|paixão|romance|s2
💝|amor|aniversário|coração|coração com fita|dia dos namorados|emoção|fita|s2
💖|amor|brilhante|coração brilhante|emoção|emocionante|s2
💗|amor|animado|coração|coração crescendo|emoção|nervosismo|pulsando|s2
💓|amor|batendo|coração|emoção|pulsante|s2
💞|adorável|amor|bonitinho|coração|corações|emoção|girando|s2
💕|amantes|amor|coração|dois corações|emoção|s2
💟|amor|coração|coração decorativo|decoração de coração|s2
❣️|amor|coração|exclamação|exclamação de coração|exclamação em forma de coração|pontuação|s2|sinal
💔|coração|coração partido|coração quebrado|decepção amorosa|desilusão amorosa|emoção|rompimento|s2|sofrendo|sofrimento|triste
❤️‍🔥|amor|coração|coração vermelho|s2|fogo|ardente
❤️|amor|coração|coração vermelho|s2
🧡|coração|emoção|laranja|s2
💛|amarelo|amor|coração|emoção|love|s2
💚|coração|emoção|s2|verde
💙|azul|coração|emoção|s2
💜|coração|coração lilás|emoção|roxo|s2
🖤|coração|negro|preto|s2
💯|100|100 pontos|cem pontos|certamente|certeza|conte comigo|pontuação|pontuação total
💢|com raiva|emoção|engraçado|raiva|símbolo de raiva
💬|balão|balão de conversa|balão de diálogo|diálogo|engraçado
👁️‍🗨️|olho|parte do corpo|rosto balão de diálogo|balão de diálogo à esquerda|balão de diálogo preto
🗯️|balão de diálogo|balão de diálogo enérgico|balão de raiva à direita|discurso furioso|enérgico|irado|raiva
💭|balão|balão de pensamento|engraçado|ideia|invenção|inventando|pensamento|pensando
💤|boa noite|cansada|cansado|com sono|dormindo|dormir|emoção|engraçado|roncando|sono|Zzz
♨️|calor|chamas|fogo|fumaça|quente
🛑|pare|sinal|sinal de pare
🕛|12 horas|12h00|doze|meia-noite|meio-dia|relógio
🕧|12h30|doze e meia|relógio
🕐|1 hora|13h|1h|1h00|relógio|uma
🕜|1
🕑|14h|2 horas|2h|2h00|duas|relógio
🕝|2
🕒|15h|3 horas|3
🕞|3
🕓|4 horas|4
🕟|4h30|quatro e meia|relógio
🕔|5 horas|5h00|cinco|relógio
🕠|17h30|5h30|cinco e meia|relógio
🕕|18h|6 horas|6h00|relógio|seis
🕡|18h30|6h30|relógio|seis e meia
🕖|19h|7 horas|7h00|relógio|sete
🕢|7
🕗|8 horas|8
🕣|8
🕘|21h|9 horas|9h00|nove|relógio
🕤|9
🕙|10 horas|10h00|22h|dez|relógio
🕥|10h30|22h30|dez e meia|relógio
🕚|11 horas|11
🕦|11h30|23h30|onze e meia|relógio
🌀|ciclone|clima|espiral|furacão|tonto|twister|zonzo
♠️|baralho|carta|espadas|jogo|naipe|naipe de espadas
♥️|baralho|carta|copas|jogo|naipe|s2
♦️|baralho|carta|jogo|naipe|naipe de ouros|ouro
♣️|baralho|carta|jogo|naipe|naipe de paus|paus
🃏|baralho|carta|coringa|curinga|jogo|joker
🀄|dragão|jogo|mahjong|peça|vermelho
🎴|baralho|carta de baralho|carta de flores|flores|Hanafuda|jogo de baralho
🔇|alto-falante|alto-falante com sinal de cancelamento|alto-falante silenciado|mudo|mute|quieto|silenciar|silêncio
🔈|alto-falante|alto-falante com volume baixo|música|som|volume|volume baixo
🔉|alto-falante com som baixo|alto-falante com volume baixo|alto-falante com volume médio|baixo|diminuir o volume|volume baixo|volume médio
🔊|alto|alto-falante com som alto|alto-falante com volume alto|música|volume alto
📢|alto|alto-falante|alto-falante manual|buzina|comunicação|discurso público|megafone|megafone em uso
📣|aplausos|comunicação|megafone
🔔|capela|sino
🔕|mudo|proibido|quieto|sem som|silencioso|símbolo de sino com sinal de cancelamento|sino|sino silenciado
🎵|música|nota|nota musical
🎶|música|nota|notas|notas musicais
🏧|ATM|automático|banco|caixa|dinheiro|eletrônico|grana|saque|símbolo
🚮|coloque o lixo no lixo|lata|lixeira|lixo|símbolo
♿|acesso|cadeira|rodas|símbolo|sinal
🩼|ajuda|bastão|bengala|deficiência|desculpa|lesão|machucar|mobilidade|muleta
🚹|banheiro|homem|lavatório|masculino|símbolo|toalete|wc
🚺|banheiro|feminino|lavabo|lavatório|mulher|símbolo|toalete|wc
🚻|banheiro|lavabo|sanitário|símbolo|toalete
🚼|bebê|fralda|fraldário|símbolo|trocar
🚾|latrina|lavabo|privada|toalete|vaso sanitário|WC
⚠️|atenção|aviso|cuidado|sinal
🚸|atravessando|criança|crianças|pedestre|símbolo|tráfego
⛔|entrada|entre|não|placa|proibida|proibido|sinal|trânsito
🚫|entrada|não|proibida|proibido|símbolo|sinal
🚳|bicicleta|não|permitidas|proibido|sem
🚭|cigarro|fumar|não é permitido fumar|proibido|símbolo
🚯|jogar|lixo|não|não jogue lixo no chão|proibido|símbolo
🚱|água|consumo|imprópria|não|potável|proibido|seco|sem
🚷|não|passagem|pedestre|permitidos|proibida|proibido
🔞|18|anos|dezoito|idade|menor|menores|proibido|restrição
☢️|perigo|radiação|radiativo|radioativo|símbolo|sinal
☣️|biológico|ciência|perigo|resíduos|resíduos biológicos|risco
⬆️|cardinal|direção|norte|seta|seta para cima
↗️|diagonal|direção|direita|flecha|intercardinal|nordeste|seta|superior
➡️|direção|direita|flecha|leste|seta|seta para a direita
↘️|diagonal|direção|direita|flecha|inferior|intercardinal|seta|sudeste
⬇️|abaixo|baixo|cardinal|direção|embaixo|flecha|seta|sul
↙️|diagonal|direção|esquerda|flecha|inferior|intercardinal|seta|sudoeste
⬅️|atrás|direção|esquerda|flecha|oeste|seta|voltar
↖️|diagonal superior esquerda|direção|flecha|intercardinal|noroeste|seta|seta para cima e para a esquerda|seta para esquerda superior
↕️|flecha|para baixo|para cima|seta|seta para cima e para baixo|vertical
↔️|flecha|horizontal|lados|seta|seta para esquerda e direita
↩️|curva|flecha|retorno|seta|seta curva da direita para a esquerda|seta curva da direita para esquerda|voltar à esquerda
↪️|curva|flecha|retorno|seta|seta curva da esquerda para a direita|seta curva da esquerda para direita|voltar à direita
⤴️|curva|flecha|seta|seta curva de baixo para cima|seta para a direita curvada para cima|seta para cima
⤵️|curva|embaixo|flecha|seta curva de cima para baixo|seta para a direita curvada para baixo|seta para baixo
🔃|flechas|recarregar|sentido horário|seta|setas|setas em sentido horário na vertical|setas verticais no sentido horário|símbolo de recarregar
🔄|anti-horário|atualizar|botão de setas em sentido anti-horário|botão de setas no sentido anti-horário|sentido anti-horário|seta|setas|setas em sentido anti-horário
🔙|flecha|seta|seta "BACK"|seta para a esquerda|seta para voltar|voltar|voltar com seta para a esquerda
🔚|fim|fim com seta para a esquerda|final|seta|seta "END"|seta para a esquerda|seta para ir para o fim
🔛|flecha|marca|on|ON!|seta|seta "ON!"|seta “ON”
🔜|“Soon” com seta para a direita|em breve|flecha|seta|seta "SOON"|símbolo “Soon”|soon
🔝|cima|para cima|seta|seta "TOP|seta "TOP"|seta para cima|símbolo top|top|top com seta para cima
🛐|culto|local de culto|local sagrado|oração|religião|reza
⚛️|ateísmo|ateu|átomo|símbolo de átomo|símbolo do ateísmo
🕉️|hindu|om|religião
✡️|davi|estrela|estrela de Davi|judaico|judeu|religião
☸️|budista|dharma|religião|roda|roda do Dharma
☯️|religião|tao|taoista|taoistas|yang|yin|yin-yang
✝️|cristão|cruz|cruz latina|religião
☦️|cristão|cruz|cruz ortodoxa|religião
☪️|estrela e lua crescente|islã|muçulmano|religião|símbolo islã
☮️|paz|símbolo|símbolo da paz
🕎|candelabro|candelabro judeu|castiçal|judaísmo|memorah|menorá|religião
🔯|adivinhação|destino|estrela de seis pontas|seis pontas
♈|Áries|carneiro|signo de Áries|zodíaco
♉|boi|signo de Touro|touro|zodíaco
♊|gêmeos|signo de Gêmeos|zodíaco
♋|câncer|caranguejo|signo de Câncer|zodíaco
♌|leão|signo de Leão|zodíaco
♍|signo de Virgem|virgem|zodíaco
♎|balança|justiça|libra|signo de Libra|signo de Virgem|zodíaco
♏|escorpião|signo de Escorpião|zodíaco
♐|arqueiro|sagitário|signo de Sagitário|zodíaco
♑|cabra|capricórnio|signo de Capricórnio|zodíaco
♒|água|aquário|signo de Aquário|zodíaco
♓|peixes|signo de Peixes|zodíaco
⛎|cobra|Ofiúco|Ophiuchus|serpente|signo de Ofiúco|zodíaco
🔀|botão de músicas aleatórias|cruzadas|flechas|seta|setas|setas cruzadas em direção à direita
🔁|botão de repetir|flechas|horário|repetir|sentido horário|seta|setas|setas em sentido horário
🔂|botão de repetir|botão de repetir uma única faixa|horário|número 1|repetir|repetir uma vez|sentido horário|seta|setas|setas em sentido horário com número 1|uma vez
▶️|botão reproduzir|direita|play|reproduzir|seta|seta para a direita|triângulo
⏩|avançar|botão avançar|direita|dupla|flechas|passar para a frente|rápido|seta|seta dupla para a direita
◀️|botão de voltar|esquerda|seta|seta para a esquerda|triângulo|voltar
⏪|botão de retroceder|dupla|esquerda|retroceder|seta|seta dupla para a esquerda|seta dupla para trás|voltar
🔼|acima|botão|botão apontando para cima|botão de triângulo apontando para cima|para cima|seta|triângulo|triângulo apontando para cima|vermelho
⏫|botão de avanço para cima|dupla|flechas para cima|para cima|seta|seta dupla para cima
🔽|botão|botão apontando para baixo|botão de triângulo apontando para baixo|para baixo|seta|triângulo|triângulo apontando para baixo|vermelho
⏬|botão de avanço para baixo|flechas|flechas para baixo|para baixo|retroceder rápido|seta|seta dupla para baixo
⏹️|botão parar|parar|quadrado|stop
⏏️|botão ejetar|ejetar
🎦|cinema|entretenimento|filme|símbolo do cinema
🔅|botão de diminuir brilho|brilho|diminuir|escurecer|símbolo para reduzir brilho
🔆|aumentar brilho|botão de aumentar brilho|brilho|símbolo para aumentar brilho
📶|antena|antena com barras|barras de sinal|celular|conexão|força do sinal|internet|sinais de telefonia móvel|telefone
📳|cel|celular|modo|modo vibratório|smartphone|telefone|vibração
📴|celular|desligado|desligue o celular|smartphone|telefone
♾️|eternidade|ilimitado|infinito|universal
♻️|reciclagem|reclicar|símbolo de reciclagem|símbolo de reciclagem sólido universal|sinal
🔱|âncora|emblema|emblema de tridente|ferramenta|navio|símbolo de tridente|tridente
📛|crachá|identificação|nome
🔰|folha verde e amarela|iniciante|japonês|símbolo japonês de principiante|símbolo japonês para iniciante|verde e amarela|verde e amarelo
⭕|aro|círculo|círculo grande oco|círculo vermelho vazio|grande|o|vermelho
✅|✓|botão|check|completo|feito|marca|marca de seleção branca|marca de verificação|marca de verificação grande|verificação|verificado
☑️|✓|caixa|caixa de seleção marcada com tique|check|feito|marca de verificação|marca de verificação cinza|verificação
✔️|✓|check|feito|marca|marca de seleção|marca de verificação simples|marcar|selecionar|verificação
❌|×|cancelar|multiplicação|multiplicar|vermelho|X|xis
❎|×|botão com x|botão de caixa com X|botão de xis|marcado|multiplicar|quadrado|x|x em um quadrado verde|x verde
➕|+|cruz|mais|matemática|símbolo de adição|sinal|sinal de maior|sinal de mais|somar
➖|-|−|diminuir|matemática|menos|símbolo de subtração|sinal|sinal de menos|travessão
➗|÷|dividir|divisão|matemática|símbolo de divisão|sinal|sinal de divisão|sinal de divisão grande
✖️|×|cancelar|multiplicação|multiplicar|sinal de multiplicação|X|x de multiplicação|X preto
🟰|conta|iguais|igual|igualdade|matemática|resposta|resultado|sinal de igual
➰|laço encaracolado|loop|onda|ondulado|volta
➿|duas vezes|duplo|encaradolado|loop|loop encaracolado duas vezes|onda|ondulado
〽️|canto|japonês|símbolo japonês de canto|sinal japonês indicando início de música
✳️|*|asterisco|asterisco de oito pontas|estrela
✴️|*|estrela|estrela de oito pontas|oito pontas
❇️|*|cruz|faísca
‼️|!|!!|dupla exclamação|exclamação|exclamação dupla|explosão|ponto de exclamação duplo|pontuação
⁉️|!|!?|?|exclamação|exclamação com interrogação|interrogação|pergunta|pontuação|sinal
❓|?|interrogação|pergunta|ponto|ponto de interrogação|ponto de interrogação vermelho|pontuação|sinal
❔|?|delineado|interrogação|pergunta|ponto de interrogação branco|pontuação|sinal
❕|!|delineado|exclamação|mark|ponto|ponto de exclamação branco|pontuação|sinal
❗|!|exclamação|ponto de exclamação|ponto de exclamação vermelho|pontuação
©️|copyright|Copyright|direitos autorais|símbolo de copyright
®️|marca registrada|Marca registrada|marca registrada “R”|Marca registrada “R”|símbolo de registrado
™️|marca registrada|marca registrada “TM”|Marca registrada “TM”|símbolo|símbolo de marca registrada
#️⃣|Keycap Number Sign
0️⃣|Keycap Digit Zero
1️⃣|Keycap Digit One
2️⃣|Keycap Digit Two
3️⃣|Keycap Digit Three
4️⃣|Keycap Digit Four
5️⃣|Keycap Digit Five
6️⃣|Keycap Digit Six
7️⃣|Keycap Digit Seven
8️⃣|Keycap Digit Eight
9️⃣|Keycap Digit Nine
🔟|Keycap: 10
🔠|ABCD|caracteres latinos maiúsculos|digitação|inserir caracteres latinos maiúsculos|latinas|letras|maiúsculas|maiúsculos
🔡|abcd|caracteres latinos minúsculos|digitação|latinas|latino|letras|minúsculas|minúsculos
🔢|1234|digitação|inserir números|números
🔣|〒♪&%|digitação|inserir símbolos|símbolos
🔤|abc|ABC|alfabeto|digitação|inglês|inserir alfabeto latino|latinas|latino|letras
🅰️|A|botão A (tipo sanguíneo)|sangue|tipo A|tipo sanguíneo|tipo sanguíneo A
🆎|AB|botão AB (tipo sanguíneo)|sangue|tipo AB|tipo sanguíneo|tipo sanguíneo AB
🅱️|B|botão B (tipo sanguíneo)|sangue|tipo B|tipo sanguíneo|tipo sanguíneo B
🆑|botão CL|cl|CL|limpar|símbolo do CL
🆒|botão "COOL"|botão cool|cool|legal|símbolo “cool”
🆓|botão "FREE"|free|grátis|gratuito|símbolo|símbolo “Free”
ℹ️|i|informação|informações|símbolo|símbolo de informações
🆔|botão ID|ID|identidade|símbolo|símbolo “ID”
Ⓜ️|círculo|círculo com a letra M|letra M|m
🆕|botão "NEW"|new|Novo|símbolo
🆖|botão NG|NG|símbolo|símbolo “NG”
🅾️|botão O (tipo sanguíneo)|O|sangue|tipo O|tipo sanguíneo|tipo sanguíneo O
🆗|botão OK|ok|sim|símbolo “OK”
🅿️|botão P|estacionamento|estacionar|garagem de carros
🆘|Ajuda|botão SOS|símbolo|símbolo “SOS”|Socorro|SOS
🆙|botão "UP!"|para cima|símbolo|símbolo “UP!”|up|UP!
🆚|botão vs|botão VS|símbolo|símbolo “vs”|versus|vs
🈁|"aqui"|“aqui”|alfabeto|botão "aqui"|botão japonês de “aqui”|japonês|katakana|koko|ココ
🈂️|“taxa de serviço”|alfabeto|botão japonês de “taxa de serviço”|japonês|katakana|katanaka|sa|taxa de serviço|サ
🈷️|“quantidade mensal”|alfabeto|botão japonês de “quantidade mensal”|ideográfico|ideograma|japonês|valor mensal|月
🈶|“não gratuito”|alfabeto|botão japonês de “não gratuito”|ideográfico|ideograma|japonês|não gratuito|有
🈯|“reservado”|alfabeto|botão japonês de “reservado”|ideográfico|ideograma|japonês|reservado|指
🉐|“barganha”|alfabeto|barganha|botão japonês de “barganha”|ideográfico|ideograma|japonês|pechincha|得
🈹|“desconto”|alfabeto|botão japonês de “desconto”|desconto|ideográfico|ideograma|japonês|割
🈚|“gratuito”|alfabeto|botão japonês de “gratuito”|de graça|grátis|ideográfico|ideograma|japonês|sem custo|無
🈲|“proibido”|alfabeto|botão japonês de “proibido”|ideográfico|ideográfico quadrado “proibir”|ideograma|japonês|proibido|proibir|禁
🉑|“aceitável”|aceitar|alfabeto|botão japonês de “aceitável”|chinês|ideográfico circular “aceitar”|ideograma|japonês|可
🈸|“aplicação”|alfabeto|aplicar|botão japonês de “aplicação”|chinês|ideográfico quadrado “aplicar”|ideograma|japonês|申
🈴|“nota mínima”|alfabeto|botão japonês de “nota mínima”|chinês|ideográfico|ideográfico quadrado “juntos”|ideograma|japonês|juntos|合
🈳|“vago”|alfabeto|botão japonês de “vago”|ideográfico|ideograma|japonês|vaga|vago|vazio|空
㊗️|“parabéns”|alfabeto|botão japonês de “parabéns”|ideográfico|ideográfico circular “parabéns”|ideograma|janonês|japonês|parabéns|祝
㊙️|“segredo”|alfabeto|botão japonês de “segredo”|ideográfico|ideográfico circular “segredo”|ideograma|japonês|segredo|秘
🈺|“aberto para negócios”|botão japonês de “aberto para negócios”|chinês|ideográfico quadrado “operando”|ideograma|japonês|operando|営
🈵|“sem vagas”|alfabeto|botão japonês de “sem vagas”|completude|ideográfico|ideográfico quadrado “completude”|ideograma|japonês|満
🔴|bola vermelha|círculo|círculo vermelho grande|geométrico|vermelho
🔵|azul|bolinha azul|círculo|círculo azul grande|geométrico
⚫|círculo|geométrico|preto
⚪|branco|círculo|geométrico
⬛|geométrico|preto|quadrado|quadrado preto grande
⬜|geométrico|quadrado|quadrado branco grande
◼️|geométrico|quadrado|quadrado preto médio
◻️|geométrico|quadrado|quadrado branco médio
◾|geométrico|preto|quadrado|quadrado preto médio menor
◽|branco|geométrico|quadrado|quadrado branco médio menor
▪️|geométrico|pequeno|preto|quadrado
▫️|branco|geométrico|pequeno|quadrado
🔶|cor de laranja|diamante|diamante cor de laranja grande|diamante laranja grande|geométrico|laranja|losango|losango laranja grande
🔷|azul|balão|diamante|diamante azul grande|geométrico|losango|losango azul grande
🔸|cor de laranja|diamante|diamante cor de laranja pequeno|diamante laranja pequeno|geométrico|laranja|losango|losango laranja pequeno
🔹|azul|diamante|diamante azul pequeno|geométrico|losango|losango azul pequeno
🔺|geométrico|triângulo|triângulo vermelho apontando para cima|triangulo vermelho para cima|triângulo vermelho para cima|vermelho
🔻|geométrico|triângulo|triângulo vermelho apontando para baixo|triangulo vermelho para baixo|triângulo vermelho para baixo|vermelho
💠|cômico|dentro|diamante|diamante com ponto|diamante com um ponto|formato de diamante|geométrico
🔳|botão|botão quadrado branco|botão quadrado branco e preto|quadrado
🔲|botão|botão quadrado preto|botão quadrado preto e branco|geométrico|quadrado
🏁|bandeira|chegada|corrida|esporte|quadriculada|vitória
🚩|bandeira|informações|localização|poste|triangular|vermelha|vermelho
🎌|bandeira|comemoração|cruzadas|cruzar|Japão|Japonês
🏴|bandeira|preta|tremulando
🏳️|bandeira|branca|paz|tremulando
🏳️‍🌈|bandeira|branca|paz|tremulando arco-íris|chuva|clima|gay|lésbica|lgbt|lgbtqia+|natureza|orgulho|queer|transgênero
🏳️‍⚧️|bandeira|branca|paz|tremulando símbolo transgênero|transgênero
🏴‍☠️|bandeira|preta|tremulando caveira|caveira e ossos|caveira e ossos cruzados|morte|ossos cruzados|pirata
🇦🇨|Flag: Ascension Island
🇦🇩|Flag: Andorra
🇦🇪|Flag: United Arab Emirates
🇦🇫|Flag: Afghanistan
🇦🇬|Flag: Antigua & Barbuda
🇦🇮|Flag: Anguilla
🇦🇱|Flag: Albania
🇦🇲|Flag: Armenia
🇦🇴|Flag: Angola
🇦🇶|Flag: Antarctica
🇦🇷|Flag: Argentina
🇦🇸|Flag: American Samoa
🇦🇹|Flag: Austria
🇦🇺|Flag: Australia
🇦🇼|Flag: Aruba
🇦🇽|Flag: Åland Islands
🇦🇿|Flag: Azerbaijan
🇧🇦|Flag: Bosnia & Herzegovina
🇧🇧|Flag: Barbados
🇧🇩|Flag: Bangladesh
🇧🇪|Flag: Belgium
🇧🇫|Flag: Burkina Faso
🇧🇬|Flag: Bulgaria
🇧🇭|Flag: Bahrain
🇧🇮|Flag: Burundi
🇧🇯|Flag: Benin
🇧🇱|Flag: St. Barthélemy
🇧🇲|Flag: Bermuda
🇧🇳|Flag: Brunei
🇧🇴|Flag: Bolivia
🇧🇶|Flag: Caribbean Netherlands
🇧🇷|Flag: Brazil
🇧🇸|Flag: Bahamas
🇧🇹|Flag: Bhutan
🇧🇻|Flag: Bouvet Island
🇧🇼|Flag: Botswana
🇧🇾|Flag: Belarus
🇧🇿|Flag: Belize
🇨🇦|Flag: Canada
🇨🇨|Flag: Cocos (Keeling) Islands
🇨🇩|Flag: Congo - Kinshasa
🇨🇫|Flag: Central African Republic
🇨🇬|Flag: Congo - Brazzaville
🇨🇭|Flag: Switzerland
🇨🇮|Flag: Côte d’Ivoire
🇨🇰|Flag: Cook Islands
🇨🇱|Flag: Chile
🇨🇲|Flag: Cameroon
🇨🇳|Flag: China
🇨🇴|Flag: Colombia
🇨🇵|Flag: Clipperton Island
🇨🇷|Flag: Costa Rica
🇨🇺|Flag: Cuba
🇨🇻|Flag: Cape Verde
🇨🇼|Flag: Curaçao
🇨🇽|Flag: Christmas Island
🇨🇾|Flag: Cyprus
🇨🇿|Flag: Czechia
🇩🇪|Flag: Germany
🇩🇬|Flag: Diego Garcia
🇩🇯|Flag: Djibouti
🇩🇰|Flag: Denmark
🇩🇲|Flag: Dominica
🇩🇴|Flag: Dominican Republic
🇩🇿|Flag: Algeria
🇪🇦|Flag: Ceuta & Melilla
🇪🇨|Flag: Ecuador
🇪🇪|Flag: Estonia
🇪🇬|Flag: Egypt
🇪🇭|Flag: Western Sahara
🇪🇷|Flag: Eritrea
🇪🇸|Flag: Spain
🇪🇹|Flag: Ethiopia
🇪🇺|Flag: European Union
🇫🇮|Flag: Finland
🇫🇯|Flag: Fiji
🇫🇰|Flag: Falkland Islands
🇫🇲|Flag: Micronesia
🇫🇴|Flag: Faroe Islands
🇫🇷|Flag: France
🇬🇦|Flag: Gabon
🇬🇧|Flag: United Kingdom
🇬🇩|Flag: Grenada
🇬🇪|Flag: Georgia
🇬🇫|Flag: French Guiana
🇬🇬|Flag: Guernsey
🇬🇭|Flag: Ghana
🇬🇮|Flag: Gibraltar
🇬🇱|Flag: Greenland
🇬🇲|Flag: Gambia
🇬🇳|Flag: Guinea
🇬🇵|Flag: Guadeloupe
🇬🇶|Flag: Equatorial Guinea
🇬🇷|Flag: Greece
🇬🇸|Flag: South Georgia & South Sandwich Islands
🇬🇹|Flag: Guatemala
🇬🇺|Flag: Guam
🇬🇼|Flag: Guinea-Bissau
🇬🇾|Flag: Guyana
🇭🇰|Flag: Hong Kong SAR China
🇭🇲|Flag: Heard & McDonald Islands
🇭🇳|Flag: Honduras
🇭🇷|Flag: Croatia
🇭🇹|Flag: Haiti
🇭🇺|Flag: Hungary
🇮🇨|Flag: Canary Islands
🇮🇩|Flag: Indonesia
🇮🇪|Flag: Ireland
🇮🇱|Flag: Israel
🇮🇲|Flag: Isle of Man
🇮🇳|Flag: India
🇮🇴|Flag: British Indian Ocean Territory
🇮🇶|Flag: Iraq
🇮🇷|Flag: Iran
🇮🇸|Flag: Iceland
🇮🇹|Flag: Italy
🇯🇪|Flag: Jersey
🇯🇲|Flag: Jamaica
🇯🇴|Flag: Jordan
🇯🇵|Flag: Japan
🇰🇪|Flag: Kenya
🇰🇬|Flag: Kyrgyzstan
🇰🇭|Flag: Cambodia
🇰🇮|Flag: Kiribati
🇰🇲|Flag: Comoros
🇰🇳|Flag: St. Kitts & Nevis
🇰🇵|Flag: North Korea
🇰🇷|Flag: South Korea
🇰🇼|Flag: Kuwait
🇰🇾|Flag: Cayman Islands
🇰🇿|Flag: Kazakhstan
🇱🇦|Flag: Laos
🇱🇧|Flag: Lebanon
🇱🇨|Flag: St. Lucia
🇱🇮|Flag: Liechtenstein
🇱🇰|Flag: Sri Lanka
🇱🇷|Flag: Liberia
🇱🇸|Flag: Lesotho
🇱🇹|Flag: Lithuania
🇱🇺|Flag: Luxembourg
🇱🇻|Flag: Latvia
🇱🇾|Flag: Libya
🇲🇦|Flag: Morocco
🇲🇨|Flag: Monaco
🇲🇩|Flag: Moldova
🇲🇪|Flag: Montenegro
🇲🇫|Flag: St. Martin
🇲🇬|Flag: Madagascar
🇲🇭|Flag: Marshall Islands
🇲🇰|Flag: North Macedonia
🇲🇱|Flag: Mali
🇲🇲|Flag: Myanmar (Burma)
🇲🇳|Flag: Mongolia
🇲🇴|Flag: Macau Sar China
🇲🇵|Flag: Northern Mariana Islands
🇲🇶|Flag: Martinique
🇲🇷|Flag: Mauritania
🇲🇸|Flag: Montserrat
🇲🇹|Flag: Malta
🇲🇺|Flag: Mauritius
🇲🇻|Flag: Maldives
🇲🇼|Flag: Malawi
🇲🇽|Flag: Mexico
🇲🇾|Flag: Malaysia
🇲🇿|Flag: Mozambique
🇳🇦|Flag: Namibia
🇳🇨|Flag: New Caledonia
🇳🇪|Flag: Niger
🇳🇫|Flag: Norfolk Island
🇳🇬|Flag: Nigeria
🇳🇮|Flag: Nicaragua
🇳🇱|Flag: Netherlands
🇳🇴|Flag: Norway
🇳🇵|Flag: Nepal
🇳🇷|Flag: Nauru
🇳🇺|Flag: Niue
🇳🇿|Flag: New Zealand
🇴🇲|Flag: Oman
🇵🇦|Flag: Panama
🇵🇪|Flag: Peru
🇵🇫|Flag: French Polynesia
🇵🇬|Flag: Papua New Guinea
🇵🇭|Flag: Philippines
🇵🇰|Flag: Pakistan
🇵🇱|Flag: Poland
🇵🇲|Flag: St. Pierre & Miquelon
🇵🇳|Flag: Pitcairn Islands
🇵🇷|Flag: Puerto Rico
🇵🇸|Flag: Palestinian Territories
🇵🇹|Flag: Portugal
🇵🇼|Flag: Palau
🇵🇾|Flag: Paraguay
🇶🇦|Flag: Qatar
🇷🇪|Flag: Réunion
🇷🇴|Flag: Romania
🇷🇸|Flag: Serbia
🇷🇺|Flag: Russia
🇷🇼|Flag: Rwanda
🇸🇦|Flag: Saudi Arabia
🇸🇧|Flag: Solomon Islands
🇸🇨|Flag: Seychelles
🇸🇩|Flag: Sudan
🇸🇪|Flag: Sweden
🇸🇬|Flag: Singapore
🇸🇭|Flag: St. Helena
🇸🇮|Flag: Slovenia
🇸🇯|Flag: Svalbard & Jan Mayen
🇸🇰|Flag: Slovakia
🇸🇱|Flag: Sierra Leone
🇸🇲|Flag: San Marino
🇸🇳|Flag: Senegal
🇸🇴|Flag: Somalia
🇸🇷|Flag: Suriname
🇸🇸|Flag: South Sudan
🇸🇹|Flag: São Tomé & Príncipe
🇸🇻|Flag: El Salvador
🇸🇽|Flag: Sint Maarten
🇸🇾|Flag: Syria
🇸🇿|Flag: Swaziland
🇹🇦|Flag: Tristan Da Cunha
🇹🇨|Flag: Turks & Caicos Islands
🇹🇩|Flag: Chad
🇹🇫|Flag: French Southern Territories
🇹🇬|Flag: Togo
🇹🇭|Flag: Thailand
🇹🇯|Flag: Tajikistan
🇹🇰|Flag: Tokelau
🇹🇱|Flag: Timor-Leste
🇹🇲|Flag: Turkmenistan
🇹🇳|Flag: Tunisia
🇹🇴|Flag: Tonga
🇹🇷|Flag: Turkey
🇹🇹|Flag: Trinidad & Tobago
🇹🇻|Flag: Tuvalu
🇹🇼|Flag: Taiwan
🇹🇿|Flag: Tanzania
🇺🇦|Flag: Ukraine
🇺🇬|Flag: Uganda
🇺🇲|Flag: U.S. Outlying Islands
🇺🇳|Flag: United Nations
🇺🇸|Flag: United States
🇺🇾|Flag: Uruguay
🇺🇿|Flag: Uzbekistan
🇻🇦|Flag: Vatican City
🇻🇨|Flag: St. Vincent & Grenadines
🇻🇪|Flag: Venezuela
🇻🇬|Flag: British Virgin Islands
🇻🇮|Flag: U.S. Virgin Islands
🇻🇳|Flag: Vietnam
🇻🇺|Flag: Vanuatu
🇼🇫|Flag: Wallis & Futuna
🇼🇸|Flag: Samoa
🇽🇰|Flag: Kosovo
🇾🇪|Flag: Yemen
🇾🇹|Flag: Mayotte
🇿🇦|Flag: South Africa
🇿🇲|Flag: Zambia
🇿🇼|Flag: Zimbabwe
''',
};
