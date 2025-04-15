#include "rssmodel.h"

RSSModel::RSSModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Add mock data
    m_items = {
        {
            QStringLiteral("KDE Plasma 6.0 Released"),
            QStringLiteral("The KDE Community is proud to announce the release of Plasma 6.0..."),
            QStringLiteral("2024-02-28"),
            QStringLiteral("Plasma 6.0 brings many improvements including a new default theme, better performance, and enhanced Wayland support...")
        },
        {
            QStringLiteral("New KDE Applications Update"),
            QStringLiteral("Latest KDE Applications suite brings new features and improvements..."),
            QStringLiteral("2024-02-25"),
            QStringLiteral("The KDE Applications team has released a new version with improved stability and new features...")
        },
        {
            QStringLiteral("KDE Connect 24.02 Released"),
            QStringLiteral("KDE Connect gets major updates in the latest release..."),
            QStringLiteral("2024-02-20"),
            QStringLiteral("The latest version of KDE Connect brings better device synchronization and new plugins...")
        }
    };
}

int RSSModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_items.count();
}

QVariant RSSModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();

    const FeedItem &item = m_items[index.row()];

    switch (role) {
        case TitleRole:
            return item.title;
        case DescriptionRole:
            return item.description;
        case DateRole:
            return item.date;
        case ContentRole:
            return item.content;
        default:
            return QVariant();
    }
}

QHash<int, QByteArray> RSSModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[DescriptionRole] = "description";
    roles[DateRole] = "date";
    roles[ContentRole] = "content";
    return roles;
} 