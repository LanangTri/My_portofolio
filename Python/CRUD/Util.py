import random
import string


def random_string (panjang:int)-> int:
    hasil_string = ''.join(random.choices(string.ascii_uppercase + string.digits, k=panjang))
    return hasil_string 