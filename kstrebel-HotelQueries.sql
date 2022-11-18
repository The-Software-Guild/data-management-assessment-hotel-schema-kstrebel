SELECT
    GUEST.FirstName,
    GUEST.LastName,
    RESERVATION.RoomNumber,
    RESERVATION.StartDate,
    RESERVATION.EndDate
FROM
    RESERVATION
    INNER JOIN GUEST ON RESERVATION.GuestID = GUEST.UniqueID
WHERE
    YEAR(EndDate) = 2023
    AND MONTH(EndDate) = 6;

SELECT
    GUEST.FirstName,
    GUEST.LastName,
    RESERVATION.RoomNumber,
    RESERVATION.StartDate,
    RESERVATION.EndDate
FROM
    ROOM_NUMBER
    INNER JOIN RESERVATION ON RESERVATION.RoomNumber = ROOM_NUMBER.RoomNumber
    INNER JOIN GUEST ON RESERVATION.GuestID = GUEST.UniqueID
WHERE
    Jacuzzi = TRUE;

SELECT
    GUEST.FirstName,
    GUEST.LastName,
    RESERVATION.RoomNumber,
    RESERVATION.StartDate,
    (RESERVATION.Adults + RESERVATION.Children) AS TotalGuests
FROM
    GUEST
    INNER JOIN RESERVATION ON RESERVATION.GuestID = GUEST.UniqueID
WHERE
    GUEST.UniqueID = 2;

SELECT
    ROOM_NUMBER.RoomNumber,
    RESERVATION.UniqueID AS ReservationID,
    (
        (
            ROOM_TYPE.BasePrice + ROOM_TYPE.AddAdultPrice * RESERVATION.Adults
        ) * DATEDIFF(RESERVATION.EndDate, RESERVATION.StartDate) + IF(ROOM_NUMBER.Jacuzzi = TRUE, 25.0, 0)
    ) AS PerRoomCost
FROM
    RESERVATION
    INNER JOIN ROOM_NUMBER ON RESERVATION.RoomNumber = ROOM_NUMBER.RoomNumber
    INNER JOIN ROOM_TYPE ON ROOM_TYPE.UniqueID = ROOM_NUMBER.RoomTypeID
ORDER BY
    ROOM_NUMBER.RoomNumber ASC;

SELECT
    RESERVATION.UniqueID AS ResID,
    RESERVATION.RoomNumber,
    ROOM_TYPE.MaxPeople AS Capacity,
    RESERVATION.StartDate,
    RESERVATION.EndDate
FROM
    RESERVATION
    INNER JOIN ROOM_NUMBER ON RESERVATION.RoomNumber = ROOM_NUMBER.RoomNumber
    INNER JOIN ROOM_TYPE ON ROOM_NUMBER.RoomTypeID = ROOM_TYPE.UniqueID
WHERE
    ROOM_TYPE.MaxPeople >= 3
    AND(
        (
            YEAR(RESERVATION.EndDate) = 2023
            AND MONTH(RESERVATION.EndDate) = 4
        )
        OR (
            YEAR(RESERVATION.StartDate) = 2023
            AND MONTH(RESERVATION.StartDate) = 4
        )
        OR (
            "2023-4-15" BETWEEN RESERVATION.StartDate
            AND RESERVATION.EndDate
        )
    )
ORDER BY
    RESERVATION.StartDate ASC;

SELECT
    COUNT(*) AS NumberReservations,
    GUEST.FirstName,
    GUEST.LastName
FROM
    RESERVATION
    INNER JOIN GUEST ON RESERVATION.GuestID = GUEST.UniqueID
GROUP BY
    RESERVATION.GuestID
ORDER BY
    NumberReservations DESC,
    GUEST.LastName ASC;

SELECT
    FirstName,
    LastName,
    Address,
    Phone
FROM
    GUEST
WHERE
    Phone = "(308) 494-0198"