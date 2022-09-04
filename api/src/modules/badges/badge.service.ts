import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { BadgesRepository } from './badge.repository';

@Injectable()
export class BadgesService {
  constructor(
    @InjectRepository(BadgesRepository)
    private readonly badgesRepository: BadgesRepository,
  ) {}

  async createBadge(
    userId: string,
    eventId: string,
    nft: {
      transactionHash: any;
      tokenId: any;
      timestamp: Date;
    },
  ) {
    return this.badgesRepository.save({
      userId,
      ref: eventId,
      tx: nft.transactionHash,
      nftid: nft.tokenId,
      issuedAt: nft.timestamp,
    });
  }
}
