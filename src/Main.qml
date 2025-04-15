// Includes relevant modules used by the QML
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.tutorial 1.0

// Provides basic features needed for all kirigami applications
Kirigami.ApplicationWindow {
    // Unique identifier to reference this object
    id: root

    width: 800
    height: 600

    // Window title
    // i18nc() makes a string translatable
    // and provides additional context for the translators
    title: i18nc("@title:window", "RSS Reader")

    // Create the C++ model instance
    RSSModel {
        id: rssModel
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        id: mainPage
        
        RowLayout {
            anchors.fill: parent
            spacing: 0
            
            // Left side - Feed list
            Controls.ScrollView {
                Layout.preferredWidth: Kirigami.Units.gridUnit * 20
                Layout.fillHeight: true
                
                ListView {
                    id: feedListView
                    model: rssModel
                    width: parent.width
                    height: parent.height
                    
                    delegate: Controls.ItemDelegate {
                        width: parent.width
                        height: Kirigami.Units.gridUnit * 3
                        
                        contentItem: Column {
                            spacing: Kirigami.Units.smallSpacing
                            
                            Controls.Label {
                                text: model.title
                                font.bold: true
                                elide: Text.ElideRight
                            }
                            
                            Controls.Label {
                                text: model.description
                                elide: Text.ElideRight
                                opacity: 0.7
                            }
                            
                            Controls.Label {
                                text: model.date
                                font.pointSize: 8
                                opacity: 0.5
                            }
                        }
                        
                        onClicked: {
                            feedDetail.currentItem = model
                        }
                    }
                }
            }
            
            // Right side - Detail view
            Controls.ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                id: feedDetail
                property var currentItem: null
                
                ColumnLayout {
                    width: parent.width
                    spacing: Kirigami.Units.largeSpacing
                    
                    Controls.Label {
                        visible: !feedDetail.currentItem
                        text: i18n("Select an item from the list to view its details")
                        Layout.alignment: Qt.AlignCenter
                    }
                    
                    ColumnLayout {
                        visible: feedDetail.currentItem
                        width: parent.width
                        
                        Controls.Label {
                            text: feedDetail.currentItem ? feedDetail.currentItem.date : ""
                            font.pointSize: 10
                            opacity: 0.7
                        }
                        
                        Controls.Label {
                            text: feedDetail.currentItem ? feedDetail.currentItem.content : ""
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
    }
}

