#pragma once

#include <QAbstractListModel>

class RSSModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        DescriptionRole,
        DateRole,
        ContentRole
    };

    explicit RSSModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    struct FeedItem {
        QString title;
        QString description;
        QString date;
        QString content;
    };

    QVector<FeedItem> m_items;
}; 