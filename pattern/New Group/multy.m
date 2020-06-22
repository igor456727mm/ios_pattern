//
//  multy.m
//  pattern
//
//  Created by Igor Selivestrov on 22.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//  multy.swift
//  pattern
//
//  Created by Igor Selivestrov on 22.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//


var thread = pthread_t(bitPattern: 0)
var attribute = pthread_attr_t()


pthread_attr_init(&attribute)
pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_DEFAULT, 0) // Приоритет потока
pthread_create(&thread, &attribute, { (pointer) -> UnsafeMutableRawPointer? in // Инициализация потока
    print("Код первого потока")
    pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0) // Меняем приоритет потока
    return nil
}, nil)

var nstread = Thread {
    print("Код второго потока")
    print(qos_class_self())
}
nstread.qualityOfService = .userInteractive
nstread.start()


print(qos_class_main())

class SaveThread {
    private var mutex = pthread_mutex_t()
    
    //private let mutex = NSLook() NSRecursiveLook()
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func method(competion: () -> ()) {
        //mutex.look() mutex.unlook()
        pthread_mutex_lock(&mutex)
        competion()
        do {
            pthread_mutex_unlock(&mutex)
        }
        
    }
}
var array = [String]()
var saveThread = SaveThread()
saveThread.method {
    print("test")
    array.append("thred")
}

let recursive = NSRecursiveLock()
class RecursiveTread: Thread {
    override func main() {
        recursive.lock()
        print("recursive look ")
        
        defer {
            recursive.unlock()
        }
    }
    func callMe()  {
        recursive.lock()
        defer {
            recursive.unlock()
        }
        print("exit")
    }
}

let tread = RecursiveTread()
tread.start()
