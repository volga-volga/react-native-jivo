package ru.vvdev.jivo;

public interface Observer {
    void handleEvent(String event, String data);
}
