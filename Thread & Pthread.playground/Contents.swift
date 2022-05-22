import UIKit
import Darwin

// Unix - POSIX
var thread = pthread_t(bitPattern: 0) //создаем поток
var attribut = pthread_attr_t() //создаем атрибут

pthread_attr_init(&attribut) //инициализируем наш атрибут

pthread_create(&thread, &attribut, { pointer in
    print("Test")
    return nil
}, nil)



//Thread
var nsThread = Thread {
    print("Test")
}

nsThread.start()
