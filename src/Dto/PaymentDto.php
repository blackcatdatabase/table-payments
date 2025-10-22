<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\Payments\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Žádná logika; pouze nosič dat.
 * - Silné typy drží kontrakt napříč vrstvami.
 */
final class PaymentDto {
    public function __construct(
        public readonly ?int $id,
        public readonly ?int $orderId,
        public readonly string $gateway,
        public readonly ?string $transactionId,
        public readonly ?string $providerEventId,
        public readonly string $status,
        public readonly string $amount,
        public readonly string $currency,
        public readonly array|null $details,
        public readonly \DateTimeImmutable $createdAt,
        public readonly \DateTimeImmutable $updatedAt
    ) {}

    /** Vhodné pro serializaci/logování (bez binárních/velkých blobů). */
    public function toArray(): array {
        // get_object_vars funguje dobře s public readonly vlastnostmi
        return get_object_vars($this);
    }
}
