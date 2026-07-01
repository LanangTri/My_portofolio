import os
import CRUD as CRUD 

if __name__ == "__main__":
    sistem_operasi = os.name
    match sistem_operasi:
            case "nt":
                os.system("cls")
            case "posix":
                os.system("clear")

    print("SELAMAT DATANG DI PROGRAM")
    print("DATABASE PERPUSTAKAAN")
    print("=========================")

    # Check Database Ada atau Tidak
    CRUD.init_console()

    while (True):
        match sistem_operasi:
            case "nt":
                os.system("cls")
            case "posix":
                os.system("clear")
        
        print("SELAMAT DATANG DI PROGRAM")
        print("DATABASE PERPUSTAKAAN")
        print("=========================")

        print(f"1. Lihat data buku")
        print(f"2. Tambah data buku")
        print(f"3. Ubah data buku")
        print(f"4. Hapus data buku")

        user_option = input("Masukkan pilihan anda (1-4): ")

        match user_option:
            case "1": CRUD.read_console()
            case "2": CRUD.create_console()
            case "3": CRUD.update_console()
            case "4": CRUD.delete_console()
        
        is_done = input("Apakah Sudah Selesai? (y/n): ")
        if is_done == "y" or is_done == "Y":
            break

    print("Terima kasih telah menggunakan program ini.")


