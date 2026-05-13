#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Set import paths for QML modules
    engine.addImportPath("qrc:/");


    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    engine.load(url);
    
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
