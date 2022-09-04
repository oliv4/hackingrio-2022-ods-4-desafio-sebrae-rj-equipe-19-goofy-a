import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EthereumProvider } from './providers/ethereum.provider';
import { NFTProvider } from './providers/nft.provider';
import { WalletsRepository } from './wallets.repository';
import { WalletsService } from './wallets.service';

@Module({
  imports: [TypeOrmModule.forFeature([WalletsRepository])],
  providers: [WalletsService, NFTProvider, EthereumProvider],
  exports: [WalletsService, NFTProvider, EthereumProvider],
})
export class BlockchainModule {}
