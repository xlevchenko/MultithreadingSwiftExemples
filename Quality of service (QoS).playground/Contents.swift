import Foundation
import Darwin
//Quality of service (QoS) Приоритеты потока

//язык - С

// Создаем переменную потока
var thread = pthread_t(bitPattern: 0)
// Создаем переменную аттрибутов очереди
var threadAttributes = pthread_attr_t()
// Инициализируем аттрибуты
pthread_attr_init(&threadAttributes)
// Создаем поток, передав все аргументы
pthread_attr_set_qos_class_np(&threadAttributes, QOS_CLASS_USER_INITIATED, 0)
pthread_create(&thread, &threadAttributes, { pointer in
    print("hi")
    
    //переводим виполнение в background
    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
    return nil
}, nil)




//язык - Swift
let nsThread = Thread {
    print("test")
    print(qos_class_self())
}

nsThread.qualityOfService = .userInteractive
nsThread.start()

print(qos_class_main())
