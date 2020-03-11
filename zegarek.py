#!/usr/bin/env python3.6
"""Idea za tym jest taka, że fajnie byłoby powiedzieć: 

1. ile temu miała miejsce 16:36
2. o której zdarzyło się coś 'godzinę i 18 minut temu'
Wersja 1: mamy Godzinę jako klasę i ona działa z '16:30' robiąc obiekt
"""
class Godzina:
    """Odpowie na pytanie: Która godzina?"""
    
    def __init__(instancja, godzina:int, minuty:int):
        instancja.godzina = godzina
        instancja.minuty = minuty

    @classmethod
    def z_napisu(klasa, napis : str):
        części = napis.split(":")
        return klasa(int(części[0]), int(części[1]))

    def __str__(instancja):
        return f"{instancja.godzina}:{instancja.minuty}"

    def __repr__(instancja):
        return f"""jest godzina {instancja.__str__()}.
    Godzinowa część jest typu {type(instancja.godzina)}.
    Minutowa część jest typu {type(instancja.minuty)}."""

    def __subtract__(instancja, odejmujemy):
        return "zawołano odejmowanie"


if __name__ == "__main__":
    print(Godzina.z_napisu("16:40"))
