import { EntityRepository, Repository } from 'typeorm';
import { WalletsEntity } from './wallets.entity';

@EntityRepository(WalletsEntity)
export class WalletsRepository extends Repository<WalletsEntity> {}
