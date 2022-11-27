import UIKit

// MARK: - Потоки
/// - Thread
/// - Operation

// MARK: - Альтернатива потокам
/// - Grand Central Dispatch (GCD)


// MARK: - Параллельность
// 1) Thread --------------------
// 2) Thread --------------------

// MARK: - Последовательность
// -------------Последовательные потоки--------------
// 1) Thread - - - --
// 2) Thread -- - --

// MARK: - Асинхронность
// -------------Асинхронные потоки-------------------
// 1) Main(UI) -----
// 2) Thread

// MARK: - Unix (POSIX)
// Под капотом (на низком уровне)
var thread = pthread_t(bitPattern: 0) // создание потока
var attribute = pthread_attr_t() // создание атрибута

pthread_attr_init(&attribute)
pthread_create(&thread, &attribute, {(pointer) -> UnsafeMutableRawPointer? in
    print("test")
    return nil
}, nil)

// 2) Thread
// На высоком уровне
var nsthread = Thread {
    print("test")
}

nsthread.start()
nsthread.cancel()
