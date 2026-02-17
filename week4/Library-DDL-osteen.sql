/* ------------------------------------------------------------
   File: Library-DDL-osteen.sql
   DB  : LIBRARY
   Dialect: PostgreSQL
------------------------------------------------------------ */

-- Optional: keep everything in a dedicated schema
CREATE SCHEMA IF NOT EXISTS library;
SET search_path TO library;

-- Drop in FK-safe order
DROP TABLE IF EXISTS book_loans;
DROP TABLE IF EXISTS book_copies;
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS borrower;
DROP TABLE IF EXISTS library_branch;
DROP TABLE IF EXISTS publisher;

-- -------------------------
-- PUBLISHER
-- -------------------------
CREATE TABLE publisher (
                           name    VARCHAR(100) PRIMARY KEY,
                           address VARCHAR(255),
                           phone   VARCHAR(25)
);

-- -------------------------
-- BOOK
-- -------------------------
CREATE TABLE book (
                      book_id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                      title           VARCHAR(255) NOT NULL,
                      publisher_name  VARCHAR(100) NOT NULL,

                      CONSTRAINT fk_book_publisher
                          FOREIGN KEY (publisher_name)
                              REFERENCES publisher(name)
                              ON UPDATE CASCADE
                              ON DELETE RESTRICT
);

-- -------------------------
-- BOOK_AUTHORS (M:N)
-- -------------------------
CREATE TABLE book_authors (
                              book_id     INTEGER NOT NULL,
                              author_name VARCHAR(150) NOT NULL,

                              CONSTRAINT pk_book_authors PRIMARY KEY (book_id, author_name),

                              CONSTRAINT fk_book_authors_book
                                  FOREIGN KEY (book_id)
                                      REFERENCES book(book_id)
                                      ON UPDATE CASCADE
                                      ON DELETE CASCADE
);

-- -------------------------
-- LIBRARY_BRANCH
-- -------------------------
CREATE TABLE library_branch (
                                branch_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                                branch_name VARCHAR(150) NOT NULL,
                                address     VARCHAR(255),

                                CONSTRAINT uq_library_branch_name UNIQUE (branch_name)
);

-- -------------------------
-- BORROWER
-- -------------------------
CREATE TABLE borrower (
                          card_no INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                          name    VARCHAR(150) NOT NULL,
                          address VARCHAR(255),
                          phone   VARCHAR(25)
);

-- -------------------------
-- BOOK_COPIES
-- -------------------------
CREATE TABLE book_copies (
                             book_id      INTEGER NOT NULL,
                             branch_id    INTEGER NOT NULL,
                             no_of_copies INTEGER NOT NULL DEFAULT 0,

                             CONSTRAINT pk_book_copies PRIMARY KEY (book_id, branch_id),

                             CONSTRAINT ck_book_copies_nonneg
                                 CHECK (no_of_copies >= 0),

                             CONSTRAINT fk_book_copies_book
                                 FOREIGN KEY (book_id)
                                     REFERENCES book(book_id)
                                     ON UPDATE CASCADE
                                     ON DELETE CASCADE,

                             CONSTRAINT fk_book_copies_branch
                                 FOREIGN KEY (branch_id)
                                     REFERENCES library_branch(branch_id)
                                     ON UPDATE CASCADE
                                     ON DELETE CASCADE
);

-- -------------------------
-- BOOK_LOANS
-- -------------------------
CREATE TABLE book_loans (
                            book_id   INTEGER NOT NULL,
                            branch_id INTEGER NOT NULL,
                            card_no   INTEGER NOT NULL,
                            date_out  DATE NOT NULL,
                            due_date  DATE NOT NULL,

    -- Allows same borrower to loan same book again on a different date
                            CONSTRAINT pk_book_loans PRIMARY KEY (book_id, branch_id, card_no, date_out),

                            CONSTRAINT ck_book_loans_dates
                                CHECK (due_date >= date_out),

                            CONSTRAINT fk_book_loans_book
                                FOREIGN KEY (book_id)
                                    REFERENCES book(book_id)
                                    ON UPDATE CASCADE
                                    ON DELETE CASCADE,

                            CONSTRAINT fk_book_loans_branch
                                FOREIGN KEY (branch_id)
                                    REFERENCES library_branch(branch_id)
                                    ON UPDATE CASCADE
                                    ON DELETE CASCADE,

                            CONSTRAINT fk_book_loans_borrower
                                FOREIGN KEY (card_no)
                                    REFERENCES borrower(card_no)
                                    ON UPDATE CASCADE
                                    ON DELETE CASCADE
);

-- Helpful indexes (Postgres does not auto-index FKs)
CREATE INDEX IF NOT EXISTS ix_book_publisher_name ON book(publisher_name);
CREATE INDEX IF NOT EXISTS ix_book_copies_branch  ON book_copies(branch_id);
CREATE INDEX IF NOT EXISTS ix_book_loans_card     ON book_loans(card_no);
