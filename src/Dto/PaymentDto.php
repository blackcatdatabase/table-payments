<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\Payments\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Bez logiky; pouze nosič dat.
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
        public readonly \DateTimeImmutable $updatedAt,
        public readonly int $version
    ) {}

    /** Vhodné pro serializaci/logování (bez velkých blobů). */
    public function toArray(): array {
        return get_object_vars($this);
    }
}
