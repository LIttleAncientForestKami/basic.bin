#!/bin/bash

mkdir -p .gitlab/{issue_templates,merge_request_templates}
cat << EOF > .gitlab/issue_templates/Kwit.md

## Temat

1 zdanie opisu: 

Zrobione, gdy (to mogą być testy):

1. spełniony warunek
2. inne kryterium
3. itp.

/assign @Marcin_Ogorzałek
/milestone %"Wersja 1.0"

EOF

cat << EOF > .gitlab/issue_templates/Błąd.md

## Zwięzłe podsumowanie

1. Opis problemu
2. Scenariusz replikacji (kroki by błąd ujrzeć)
3. Co się stało?
4. Co się powinno stać (oczekiwany rezultat)?
5. Istotne załączniki (dzienniki, zrzuty ekranu)

Użyj \`\`\`bloków kodu\`\`\` do formatowania, via trzy grawisy: \` wokół kodu.

## Poprawka
Jak rzecz poprawić? 
_Podaj nr problematycznej linii kodu, jeśli możesz_

/label ~błąd ~replikowalny ~do-oglądu
/cc @Tomasz_Borek
/assign @Marcin_Ogorzałek

EOF

cat << EOF > .gitlab/issue_templates/Bug.md

## Concise summary

1. What happened?
2. Steps to reproduce
3. What actually happens 
4. What should have happened (expected and correct behaviour)
5. Relevant attachments (logs, screenshots)

Use \`\`\`code blocks\`\`\` to format, you get them by triple gravis character: \`.

## Fixes

Possible fixes?
_If you can, link to the line of code that might be responsible for the problem_

/label ~błąd ~replikowalny ~do-oglądu
/cc @Tomasz_Borek
/assign @Marcin_Ogorzałek

EOF

cat << EOF > .gitlab/merge_request_templates/recka.md

# By recka się zdarzyła, potrzebuję

- [ ] opisu z celnymi pytaniami do recenzenta (na co mam zwrócić uwagę?)
- [ ] kodu, który działa, chociażby w szczęśliwej ścieżce, jako MVP
- [ ] oznaczenia że to MVP ("to MVP" styknie) albo finałowy produkt 
- [ ] polecamy testy ODDD (Od-Deski-Do-Deski, ręczne odpalenie i przejście się czy przeklikanie co trzeba)

MVP :: Minimum Viable Product, taki prezentowalny prototyp, niecałkiem gotów jeszcze

EOF
cat << EOF > .gitlab/merge_request_templates/review.md

# Mandatory things so review can happen /  Definition of Done:

- [ ] review description asking pointed questions (to direct a review, so you get answers you want the most - or what the reviewer should focus on)
- [ ] code works: no errors, at least happy path (MVP)
- [ ] clear mark that it's a final approach or a partial one (may be done through "This is MVP" statement)
- [ ] we recommend doing end2end test prior to every approach to make sure everything works at a later time this will be a requirement
- [ ] scripts only: docstring on a module, doctest welcome but not necessary
- [ ]  UI: program is understandable for the user, just instructions from program and its readme are enough to run / complete it
- [ ]  iterative process is recommended - one thing needs to be done per review and focus should be on new items in the iteration with tests making sure previous items work

MVP :: Minimum Viable Product, usually first version that you would call "presentable", so main features work, but frequently it's a partially done thing.

EOF

tree -a .gitlab
